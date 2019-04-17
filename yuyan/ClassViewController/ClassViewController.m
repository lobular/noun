//
//  ClassViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassHeaderVIew.h"
#import "JDCategoryLeftTabelView.h"
#import "JDCategoryRightCollectionView.h"
#import "RequestFromNet.h"
#import <SVProgressHUD.h>
#import "SearchViewController.h"
#import "HomeDetailViewController.h"
#import "ErrorView.h"
#import <AFNetworking.h>
#import "NetWorkSingle.h"
#import "Tools.h"
#import "NewsViewController.h"

@interface ClassViewController ()<UIScrollViewDelegate, UICollectionViewDelegate>

@property (nonatomic,strong)ClassHeaderVIew *headerView;

@property (nonatomic, strong) JDCategoryLeftTabelView *leftView;
@property (nonatomic, strong) JDCategoryRightCollectionView *rightView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) BOOL didEndDecelerating;

@property (nonatomic,strong)NSArray *fatherArr;
@property (nonatomic,strong)NSArray *childArr;
@property (nonatomic,strong)ErrorView *err;

@end

@implementation ClassViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (NSArray *)fatherArr{
    if (!_fatherArr) {
        _fatherArr = [NSArray array];
    }
    return _fatherArr;
}

- (NSArray *)childArr{
    if (!_childArr) {
        _childArr = [NSArray array];
    }
    return _childArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    [self getData:nil];
    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
    
    
}

- (void)notifi:(NSNotification *)noti{
    [self getData:@"load"];
}

- (void)getData:(NSString *)status{
    [SVProgressHUD show];
    [RequestFromNet getDataForCateList:CateListAPI succ:^(NSDictionary *dataDic) {
        [SVProgressHUD dismiss];
        if ([dataDic[@"status"] isEqualToString:@"success"]) {
            self->_fatherArr = dataDic[@"father"];
            self->_childArr = dataDic[@"child"];
            [self setupSubViews];
            [self->_leftView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:dataDic[@"message"]];
        }
        
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
        if (self.fatherArr.count > 0 && self.childArr.count > 0) {
            self.err = nil;
            [self.err removeFromSuperview];
        }else{
            [self.leftView removeFromSuperview];
            [self.rightView removeFromSuperview];
            self.rightView = nil;
            self.leftView = nil;
            [self createError];
        }
    }];
}
- (void)createError{
    if (!_err) {
        _err = [[ErrorView alloc] init];
        [self.view addSubview:_err];
        _err.frame = CGRectMake(0, NavigationHeight, ScreenWidth,ScreenHeight - self.tabBarController.tabBar.frame.size.height - NavigationHeight);
        [_err addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loan)]];
    }
}
- (void)loan{
    [NetWorkSingle new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

/**
 *思路1
 *使用CollectionView,每个cell添加一个collectionView
 */
#pragma mark -------UI设置-------
- (void)setupSubViews {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    JDCategoryLeftTabelView *leftView = [[JDCategoryLeftTabelView alloc] initWithFrame:CGRectMake(0, NavigationHeight, 90, ScreenHeight) style:UITableViewStylePlain];
    self.leftView = leftView;
    _leftView.fatherArr = self.fatherArr;
    [self.view addSubview:leftView];
    __weak typeof(self) weakSelf = self;
    [leftView setCellSelectedBlock:^(NSIndexPath *indexPath) {
        [weakSelf.rightView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(ScreenWidth - 91, ScreenHeight - NavigationHeight);
    
    
    JDCategoryRightCollectionView *rightView = [[JDCategoryRightCollectionView alloc] initWithFrame:CGRectMake(91, NavigationHeight + 1, ScreenWidth - 91, ScreenHeight - NavigationHeight) collectionViewLayout:flowLayout];
    self.rightView = rightView;
    self.rightView.childArr = self.childArr;
    self.rightView.fatherArr = self.fatherArr;
    rightView.delegate = self;
    rightView.pagingEnabled = YES;
    [self.view addSubview:rightView];
    [self push];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.didEndDecelerating = YES;
    // 调用方法A，传scrollView.contentOffset
    [self scrollViewWithScrollView:scrollView];
//    NSLog(@"停止滑动");
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"%f", offsetY);
    CGFloat height = self.rightView.frame.size.height;
//    NSLog(@"高度%f", height);
    NSInteger index = offsetY/height;
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    //    [self.rightView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    //    [self.leftView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    self.leftView.selectedRow = index;
}
- (void)scrollViewWithScrollView:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    //    NSLog(@"%f", offsetY);
    if (offsetY < _lastContentOffset) {
        //        NSLog(@"上");
        
    }else {
        //        NSLog(@"下");
    }
}


- (void)createNav{
    if (!_headerView) {
        _headerView = [[ClassHeaderVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight)];
        [self.view addSubview:_headerView];
    }
    [_headerView.content addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchAction)]];
    [_headerView.news addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(newsAction)]];
}

- (void)searchAction{
    SearchViewController *search = [[SearchViewController alloc] init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark 消息列表
- (void)newsAction{
    NewsViewController *new = [[NewsViewController alloc] init];
    new.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:new animated:YES];
}

- (void)push{
    __weak __typeof(&*self)weakSelf = self;
    self.rightView.value = ^(childModel *model) {
        HomeDetailViewController *detail = [[HomeDetailViewController alloc] init];
        detail.creed_id = model.creed_id;
        detail.name = model.title;
        detail.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detail animated:YES];
    };
}
@end
