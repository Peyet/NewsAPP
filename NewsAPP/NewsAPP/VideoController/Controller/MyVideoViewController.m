//
//  MyVideoViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import "MyVideoViewController.h"
#import <CMPageTitleView/CMPageTitleView.h>
#import "MyVideoPageViewController.h"

@interface MyVideoViewController ()

@end

@implementation MyVideoViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"video@2x_selected.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CMPageTitleView *pageView = [[CMPageTitleView alloc] initWithFrame:CGRectMake(0, 47, self.view.bounds.size.width, self.view.bounds.size.height)];
    pageView.delegate = self;
    
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    // 遮罩样式
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    // 是否全面屏显示
    config.cm_fullScreen = NO;

    NSMutableArray *childController = [NSMutableArray arrayWithCapacity:10];
    // channel
    NSArray *channels = @[@{@"title":@"推荐", @"type":@"1600"}, @{@"title":@"记录", @"type":@"1610"}, @{@"title":@"旅行", @"type":@"1620"}, @{@"title":@"科技", @"type":@"1630"}, @{@"title":@"搞笑", @"type":@"1611"}, @{@"title":@"综艺", @"type":@"1621"}, @{@"title":@"生活", @"type":@"1631"}, @{@"title":@"音乐", @"type":@"1612"}, @{@"title":@"时尚", @"type":@"1622"}];
    for (NSDictionary *channel in channels) {
        MyVideoPageViewController *PageController = [[MyVideoPageViewController alloc] initControllerWithChannel:channel Frame:self.view.frame];
        [childController addObject:PageController];
    }
    config.cm_childControllers = childController; //必传参数
    
    pageView.cm_config = config;

    [self.view addSubview:pageView];

}

@end
