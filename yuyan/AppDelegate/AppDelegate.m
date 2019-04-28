//
//  AppDelegate.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import <AFNetworking.h>
#import "HomeViewController.h"
#import "RequestFromNet.h"
#import "KeyChain.h"
#import "WebViewController.h"
#import "Tools.h"
#import "ErrorView.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

{
    BOOL is_first; //是否是首次进入
    NSData *apns_token; //设备token
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //开启检测
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:50.0];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    self.window.rootViewController = [[MainTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    
//    HomeViewController *home = [[HomeViewController alloc] init];
//    self.window.rootViewController = home;
//    home.is_valid = YES;
//    [self.window makeKeyAndVisible];
//    
//    [self getVersion];
    
    [self netWorkChangeEvent];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10特有
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            // 必须写代理，不然无法监听通知的接收与点击
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    // 点击允许
                    NSLog(@"注册成功");
                    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                        NSLog(@"%@", settings);
                    }];
                } else {
                    // 点击不允许
                    NSLog(@"注册失败");
                    //                     [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) { }];
                }
            }];
        } else {
            // Fallback on earlier versions
        }
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >8.0){
        //iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        
    }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        //iOS8系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    // 注册获得device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    return YES;

}

- (void)getVersion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        [RequestFromNet getDataForCustom:VersionAPI params:nil succ:^(NSDictionary *dataDic) {
            if ([dataDic[@"status"] isEqualToString:@"success"]) {
                NSString *version = [dataDic[@"data"][@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                
                NSString *strVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                NSString *ver = [strVersion  stringByReplacingOccurrencesOfString:@"." withString:@""];
                
                [KeyChain saveObject:version Forkey:@"version" ToKeyChainStore:YES];
                if ([[KeyChain objectWithKey:@"version"] integerValue] < [ver integerValue] || [[KeyChain objectWithKey:@"version"] integerValue] == [ver integerValue] ) {
                    self.window.rootViewController = [[MainTabBarController alloc] init];
                    [self.window makeKeyAndVisible];
                }else{
                    WebViewController *custom = [[WebViewController alloc] init];
                    self.window.rootViewController = custom;
                    [self.window makeKeyAndVisible];
                }
            }
        } fault:^(NSError *error) {
            
        }];
    });
}

#pragma mark 获取token
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"======%@",deviceToken);
    self->apns_token = deviceToken;
    //    NSLog(@"===========%@",deviceToken);
    //    NSString *str = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"apns_token":[NSString stringWithFormat:@"%@",deviceToken]};
    
    [RequestFromNet getDataForCustom:ApnsAPI params:dic succ:^(NSDictionary *dataDic) {
        
    } fault:^(NSError *error) {
        
    }];
}

#pragma mark iOS10 收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){
    NSString *identifier = notification.request.identifier;
    NSString *categoryIdentifier = notification.request.content.categoryIdentifier;
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        
//        NSString *identifier =  response.notification.request.identifier;
        UNNotificationRequest *request = response.notification.request;
        UNNotificationContent *content = request.content; // 收到推送的消息内容
//        NSNumber *badge = content.badge;  // 推送消息的角标
//        NSString *body = content.body;    // 推送消息体
//        UNNotificationSound *sound = content.sound;  // 推送消息的声音
//        NSString *subtitle = content.subtitle;  // 推送消息的副标题
//        NSString *title = content.title;  // 推送消息的标题
        
        [self setNumNoRead];
        
        
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            
            NSString *url = content.userInfo[@"aps"][@"alert"][@"userInfo"][@"url"];
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];//清除角标
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                WebViewController *custom = [[WebViewController alloc] init];
                self.window.rootViewController = custom;
                custom.url = url;
                [self.window makeKeyAndVisible];
            });
        }
    }
    completionHandler();  // 系统要求执行这个方法
}
- (void)setNumNoRead{
    [RequestFromNet getDataForCustom:ApnsReadAPI params:@{@"apns_token": [NSString stringWithFormat:@"%@",self->apns_token],@"method":@"-0"} succ:^(NSDictionary *dataDic) {
        
    } fault:^(NSError *error) {
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self setNumNoRead];
    [application setApplicationIconBadgeNumber:0];   //清除角标
    [application cancelAllLocalNotifications];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}

#pragma mark 网络监听
- (void)netWorkChangeEvent{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring]; //开启网络监控
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                NSLog(@"未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                [[NSUserDefaults standardUserDefaults]setObject:@"noAfn" forKey:@"afnStatus"];
                //无法联网
                NSLog(@"无法联网");
                //                    [Tools getCurrentViewController];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                         message:@"您没有联网,请检查下网络"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (@available(iOS 10.0, *)) {
                        //                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=WIFI"]];
                        //                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@"App-Prefs:root=WIFI"} completionHandler:^(BOOL success) { }];
                    } else {
                        // Fallback on earlier versions
                    }
                }];
                
                [alertController addAction:okAction];           // A
                
                UIViewController *vc =  [Tools getCurrentViewController];
                if (self->is_first) {
                    self->is_first = NO;
                    [vc.view addSubview:[[ErrorView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]];
                    ErrorView *error = (ErrorView *) vc.view.subviews[0];
                    [error.image addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getVersion)]];
                }
                
                [vc presentViewController:alertController animated:YES completion:nil];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                self->is_first = NO;
                //手机自带网络
                NSLog(@"当前使用的是3g/4g网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                self->is_first = NO;
                //WIFI
                NSLog(@"========当前在WIFI网络下");
            }
            default:
                break;
        }
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"netWorkChangeEventNotification" object:@(status)];
    }];
}

#pragma mark   释放应用
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"netWorkChangeEventNotification" object:nil];
}

@end
