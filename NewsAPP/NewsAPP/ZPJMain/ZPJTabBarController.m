//
//  ZPJTabBarController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/20.
//

#import "ZPJTabBarController.h"
#import "ZPJNewsVC.h"
#import "ZPJVideoVC.h"
#import "ZPJRecommendVC.h"
#import "ZPJMineVC.h"
#import "ZPJSearchBar.h"
#import "ZPJHeader.h"



@interface ZPJTabBarController () <UITabBarControllerDelegate>
@end

@implementation ZPJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildrenViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNewsNaviBar];
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[ZPJNewsVC class]]) {
        // 设置新闻界面导航栏
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self setupNewsNaviBar];
    } else {
        // 其他界面无导航栏
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

#pragma mark - Life Cycle

/// 初始化tabBar的子控制器
- (void)setupChildrenViewController {
    ZPJNewsVC *newsVC = (ZPJNewsVC *)[self _createChildViewControllerWithClass:([ZPJNewsVC class]) imageName:@"page.png" selectedImageName:@"page_selected.png" title:@"新闻"];
    
    ZPJVideoVC *videoVC = (ZPJVideoVC *)[self _createChildViewControllerWithClass:([ZPJVideoVC class]) imageName:@"video.png" selectedImageName:@"video_selected.png" title:@"视频"];
    
    ZPJRecommendVC *recommendVC = (ZPJRecommendVC *)[self _createChildViewControllerWithClass:([ZPJRecommendVC class]) imageName:@"like.png" selectedImageName:@"like_selected.png" title:@"推荐"];
    
    ZPJMineVC *mineVC = (ZPJMineVC *)[self _createChildViewControllerWithClass:([ZPJMineVC class]) imageName:@"home.png" selectedImageName:@"home_selected.png" title:@"我的"];
    
    self.viewControllers = @[newsVC, videoVC, recommendVC, mineVC];
    
    // 设置tabBar的颜色
    self.tabBar.backgroundColor = kZPJ_COLOR_TABBAR;
    self.delegate = self;

}

/// 创建子控制器
/// @param class 子控制器的类型
/// @param imageName tabbar未选中时显示的图片
/// @param selectedImageName tabbar选中时显示的图片
/// @param title tabbar的标题
- (UIViewController *)_createChildViewControllerWithClass:(Class)class
                              imageName:(NSString *)imageName
                      selectedImageName:(NSString *)selectedImageName
                                  title:(NSString *)title {
    UIViewController *vc = [[class alloc] init];
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    vc.tabBarItem.title = title;
    return vc;
}

/// 设置新闻界面导航栏
- (void)setupNewsNaviBar {
    self.navigationController.view.backgroundColor = kZPJ_COLOR_NAVIGATIONBAR;
    [self.navigationItem setTitleView:({
        ZPJSearchBar *searchBar = [[ZPJSearchBar alloc] init];
        searchBar;
    })];
    self.navigationItem.leftBarButtonItem = nil;
}

@end
