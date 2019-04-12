//
//  MainTabBarController.m
//  yuyan
//
//  Created by tangfeimu on 2019/3/27.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "ClassViewController.h"
#import "WellViewController.h"
#import "MineViewController.h"
#import "UIColor+Category.h"


@interface MainTabBarController ()



@end

@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [UITabBar appearance].translucent = NO;
    
    [self setupChildViewControllers];
    self.selectedIndex = 0;
}

- (void)setupChildViewControllers{
    HomeViewController *home = [[HomeViewController alloc] init];
    [self childViewController:home imageName:@"home_icon" selectedImageName:@"home_press_icon" withTitle:@"首页"];
    ClassViewController *class = [[ClassViewController alloc] init];
    [self childViewController:class imageName:@"classification_icon" selectedImageName:@"classification_press_icon" withTitle:@"分类"];
    WellViewController *well = [[WellViewController alloc] init];
    [self childViewController:well imageName:@"gift_icon" selectedImageName:@"gift_press_icon" withTitle:@"福利"];
    MineViewController *mine = [[MineViewController alloc] init];
    [self childViewController:mine imageName:@"mine_icon" selectedImageName:@"mine_press_icon" withTitle:@"我的"];
    
    
    
}

- (void)childViewController:(UIViewController *)vc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName withTitle:(NSString *)title {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor textColorWithType:0],NSFontAttributeName:[UIFont systemFontOfSize:10.0f]} forState:UIControlStateNormal];
    nav.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.navigationItem.title = title;
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor textColorWithType:0],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];
    [self addChildViewController:nav];
}

@end
