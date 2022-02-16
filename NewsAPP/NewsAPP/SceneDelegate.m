//
//  SceneDelegate.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/9.
//

#import "SceneDelegate.h"
#import "NewsController/Controller/MyNewsViewController.h"
#import "VideoController/Controller/MyVideoViewController.h"
#import "RecommendController/Controller/MyRecommendViewController.h"
#import "MineController/Controller/MyMineViewController.h"
#import "MySplashView.h"

@interface SceneDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong, readwrite) UINavigationController *navigationController;

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
        
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.delegate = self;
    tabbarController.tabBar.backgroundColor = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:244.0/255 alpha:1];
    
    MyNewsViewController *newsViewController = [[MyNewsViewController alloc] init];
//    UIViewController *newsViewController = [[UIViewController alloc] init];
 
    MyVideoViewController *videoViewController = [[MyVideoViewController alloc] init];
    
    MyRecommendViewController *recommendViewController = [[MyRecommendViewController alloc] init];
    
    MyMineViewController *mineViewController = [[MyMineViewController alloc] init];

    [tabbarController setViewControllers:@[newsViewController, videoViewController, recommendViewController, mineViewController]];
    
    _navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    _navigationController.view.backgroundColor = [UIColor redColor];

    self.window.rootViewController = _navigationController;
    [self.window makeKeyAndVisible];
    [self.window addSubview:({
            MySplashView *splash = [[MySplashView alloc] initWithFrame:self.window.bounds];
            splash;
    })];

}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[MyNewsViewController class]]) {
        [_navigationController setNavigationBarHidden:NO animated:NO];
    } else {
        [_navigationController setNavigationBarHidden:YES animated:NO];
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
