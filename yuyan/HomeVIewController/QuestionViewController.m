//
//  QuestionViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/12.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionView.h"
#import "RequestFromNet.h"
#import "KeyChain.h"
#import <SVProgressHUD.h>
#import "YuYanLoginViewController.h"
#import "QuWeiModel.h"
#import <MJExtension.h>
#import "QuestionAllView.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface QuestionViewController ()
{
    NSInteger nums; //记录当前是第几次答题
    NSInteger rightNum; //答对了几道题
    BOOL  is_Choose;  //是否选择了答案
}

@property (nonatomic,strong)QuestionView *questionView;
@property (nonatomic,strong)QuestionAllView *allView;
@property (nonatomic,strong)QuWeiModel *model;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,strong)NSMutableArray *arr;

@end

@implementation QuestionViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _dic;
}
- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray arrayWithCapacity:0];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavigationTitle:@"开始答题" LeftBtnHidden:NO RightBtnHidden:YES];
    nums = 0;
    [self getData];
    
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [RequestFromNet getQuestionListForNet:questionAPI params:@{@"token":[KeyChain objectWithKey:@"token"],@"creed_id":self.creed_id} succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",dataDic[@"errcode"]] isEqualToString:@"1"]) {
            [SVProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
            YuYanLoginViewController *login = [[YuYanLoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
        }
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self.dataArr = dataDic[@"data"];
            [self createQuestion:self.dataArr];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
        
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

- (void)createQuestion:(NSArray *)arr{
    if (!_questionView) {
        _questionView = [[QuestionView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight)];
    }
    [_questionView.nextBtn addTarget:self action:@selector(NextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_questionView];
    if (self.dataArr.count > 0) {
        _model = self.dataArr[nums];
    }
    _questionView.title.text = [NSString stringWithFormat:@"%ld.%@",nums + 1,_model.name];
    NSArray *arrs = [AnswersModel mj_objectArrayWithKeyValuesArray:_model.answers];
    for (UIButton *btn in _questionView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag >= 10000 && btn.tag < 20000) {
                for (UILabel *label in btn.subviews) {
                    if ([label isKindOfClass:[UILabel class]]) {
                        AnswersModel *model = arrs[label.tag - 30000];
                        label.text = model.name;
                        label.whc_HeightAuto();
                        btn.whc_HeightAuto();
                    }
                }
            }
        }
    }
}
- (void)createAllView{
    if (!_allView) {
        _allView = [[QuestionAllView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight)];
    }
    if (rightNum == self.dataArr.count) {
        [SVProgressHUD show];
        [RequestFromNet getDataForCustom:AnswerSuccAPI params:@{@"token":[KeyChain objectWithKey:@"token"],@"creed_id":self.creed_id} succ:^(NSDictionary *dataDic) {
            [SVProgressHUD dismiss];
            NSDictionary *dic = @{@"score":dataDic[@"data"][@"score"]};
            NSArray *arr = @[dic];
            [self->_allView config:arr];
        } fault:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
        }];
        _allView.tip.image = [UIImage imageNamed:@"exchange_success_icon"];
        _allView.tipLabel.text = @"恭喜您,答题成功";
    }else{
        _allView.tip.image = [UIImage imageNamed:@"failure_icon"];
        _allView.tipLabel.text = @"很遗憾,您没有全答对";
        [_allView config:self.arr];
    }
    [_allView.converBtn addTarget:self action:@selector(converAction) forControlEvents:UIControlEventTouchUpInside];
    [_allView.againBtn addTarget:self action:@selector(againAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_allView];
}
- (void)setAllViewConfig{
    
}

- (void)NextAction{
    NSArray *arr = [AnswersModel mj_objectArrayWithKeyValuesArray:_model.answers];
    [_questionView sendValue:^(NSInteger num) {
        if (num > 9999) {
            self->is_Choose = YES;
            AnswersModel *model = arr[num - 10000];
            if ([model.is_true integerValue] == 1) {
                self->rightNum ++;
            }else{
                int trueNum = 0;
                for (AnswersModel *model in arr) {
                    trueNum ++;
                    if ([model.is_true integerValue] == 1) {
                        NSDictionary *dic = @{[NSString stringWithFormat:@"%d",trueNum]:model.name};
                        [self.dic setObject:dic forKey:[NSString stringWithFormat:@"%ld",self->nums]];
                        [self.arr addObject:self.dic];
                    }
                }
                self->rightNum --;
                if (self->rightNum < 0) {
                    self->rightNum = 0;
                }
            }
        }
    }];
    if (is_Choose) {
        is_Choose = NO;
        nums ++;
        if (nums == self.dataArr.count ) {
            [_questionView removeFromSuperview];
            _questionView = nil;
            [self createAllView];
        }else{
            [_questionView removeFromSuperview];
            _questionView = nil;
            [self createQuestion:self.dataArr];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请先选择答案才可以进行下一题哦"];
        return;
    }
}
#pragma mark
- (void)converAction{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    MainTabBarController *tabViewController = (MainTabBarController *) appDelegate.window.rootViewController;
    [tabViewController setSelectedIndex:2];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 再来一次
- (void)againAction{
    [self getData];
    [_questionView removeFromSuperview];
    _questionView = nil;
    [_allView removeFromSuperview];
    _allView = nil;
    nums = 0;
    rightNum = 0;
    [self.arr removeAllObjects];
    [self createQuestion:self.dataArr];
}

@end
