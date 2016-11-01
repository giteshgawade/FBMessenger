//
//  CustomTabBarController.m
//  FBMessenger
//
//  Created by Gitesh Gawade on 28/10/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import "CustomTabBarController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    FriendsController *friendsController = [[FriendsController alloc] initWithCollectionViewLayout:layout];
    
    UINavigationController *recentMessageNavController = [[UINavigationController alloc] initWithRootViewController:friendsController];
    recentMessageNavController.tabBarItem.title = @"Recent";
    recentMessageNavController.tabBarItem.image = [UIImage imageNamed:@"settings"];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor purpleColor];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navController.tabBarItem.title = @"ViewController";
    navController.tabBarItem.image = [UIImage imageNamed:@"settings"];
//
    self.viewControllers = @[friendsController,viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
