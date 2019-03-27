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
    
    [self setupChildViewControllers];
    self.selectedIndex = 0;
}

- (void)setupChildViewControllers{
    HomeViewController *home = [[HomeViewController alloc] init];
    [self childViewController:home imageName:@"" selectedImageName:@"" withTitle:@"首页"];
    ClassViewController *class = [[ClassViewController alloc] init];
    [self childViewController:class imageName:@"" selectedImageName:@"" withTitle:@"分类"];
    WellViewController *well = [[WellViewController alloc] init];
    [self childViewController:well imageName:@"" selectedImageName:@"" withTitle:@"福利"];
    MineViewController *mine = [[MineViewController alloc] init];
    [self childViewController:mine imageName:@"" selectedImageName:@"" withTitle:@"我的"];
    
    
    
}

- (void)childViewController:(UIViewController *)vc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName withTitle:(NSString *)title {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.navigationItem.title = title;
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor mainColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];
    [self addChildViewController:nav];
}

@end
