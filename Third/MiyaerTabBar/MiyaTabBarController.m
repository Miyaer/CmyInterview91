//
//  MiyaTabBarController.m
//  MiyaUITabBar
//
//  Created by miya on 16/7/14.
//  Copyright © 2016年 miya. All rights reserved.
//

#import "MiyaTabBarController.h"

@interface MiyaTabBarController ()
{
    NSMutableArray * viewControllers;
}
@end

@implementation MiyaTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUITabBar];
}
- (void)createUITabBar{
    viewControllers = [[NSMutableArray alloc]init];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"MyTabBar" ofType:@"plist"];
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary * dic in array) {
        Class vcName = NSClassFromString(dic[@"VCname"]);
        UIViewController * vc = [[vcName alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
        vc.navigationItem.title = dic[@"titleName"];
        nav.tabBarItem.image = [[UIImage imageNamed:dic[@"imageName"]] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:dic[@"image_selectName"]] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.title = dic[@"name"];
        vc.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
        UIColor * color = [UIColor whiteColor];
        NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
        vc.navigationController.navigationBar.titleTextAttributes = dict;
        [vc.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
        //更改tabBar的title的颜色
        self.tabBar.tintColor = [UIColor colorWithRed:0.92 green:0.50 blue:0.06 alpha:1.00];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
