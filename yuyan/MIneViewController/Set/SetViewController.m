//
//  SetViewController.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "SetViewController.h"
#import "KeyChain.h"
#import "YuYanLoginViewController.h"
#import <SVProgressHUD.h>
#import "UIView+CornerRadiusLayer.h"

@interface SetViewController ()

@property (nonatomic,strong)UILabel *cache;
@property (nonatomic,strong)UIButton *cleanBtn;
@property (nonatomic,strong)UIButton *backBtn;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavigationTitle:@"设置" LeftBtnHidden:NO RightBtnHidden:YES];
 
    [self createSub];
}

- (void)leftBtnAcion:(id)sender;{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark sub
- (void)createSub{
    if (!_cache) {
        _cache = [UILabel new];
        [self.view addSubview:_cache];
        _cache.whc_TopSpace( NavigationHeight + 20 *ScaleHeight).whc_LeftSpace(24);
        _cache.text = [NSString stringWithFormat:@"当前缓存( %.2f)",[self filePath]];
        _cache.textColor = [UIColor textColorWithType:0];
        _cache.font = [UIFont systemFontOfSize:16];
        _cache.textAlignment = NSTextAlignmentCenter;
    }
    if (!_cleanBtn) {
        _cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_cleanBtn];
        _cleanBtn.whc_CenterYToView(0, self.cache).whc_RightSpace(15).whc_Width(60).whc_Height(30);
        _cleanBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        [_cleanBtn setTitle:@"清除" forState:UIControlStateNormal];
        [_cleanBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_cleanBtn addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
        [_cleanBtn setLayerCornerRadius:15];
    }
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_backBtn];
        _backBtn.whc_TopSpaceToView(150, _cache).whc_LeftSpace(55).whc_RightSpace(55).whc_Height(45);
        [_backBtn setTitle:@"注销" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _backBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_backBtn addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setLayerCornerRadius:22];
    }
}

#pragma mark 退出登录
- (void)BackAction{
    NSArray *arr = @[@"token",@"mobile"];
    [KeyChain clearObjects:arr];
    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"isLogin"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"isLoad" object:@"YES"];
    
    YuYanLoginViewController *login = [[YuYanLoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:^{
        
    }];
}
#pragma mark 清理缓存
- (void)cleanAction{
    [self clearFile];
}

-( float )filePath{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    return [ self folderSizeAtPath :cachPath];
}
//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}
// 缓存大小
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0 );
}

- (void)clearFile{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
    [self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}
-(void)clearCachSuccess{
    [SVProgressHUD showSuccessWithStatus:@"缓存已清理"];
    _cache.text = [NSString stringWithFormat:@"当前缓存(0.00)"];
}

@end
