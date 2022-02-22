//
//  ZPJVideoVC.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import "ZPJVideoVC.h"
#import <CMPageTitleView/CMPageTitleView.h>
#import "ZPJVideoPageVC.h"
#import "ZPJHeader.h"

@interface ZPJVideoVC ()
@property (nonatomic, strong) CMPageTitleView *pageView;
@end

@implementation ZPJVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageTitleView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 设置PageTitleView
- (void)setupPageTitleView {
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    self.pageView = pageView;
    self.pageView.frame = CGRectMake(0, kZPJScreenStatusBarHeight, kZPJScreenWidth, kZPJScreenHeight - kZPJScreenStatusBarHeight - kZPJScreenTabBarHeight - kZPJScreenBottomMargin);
    pageView.delegate = self;
    
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    // 遮罩样式
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    // 是否全面屏显示
    config.cm_fullScreen = NO;

    NSMutableArray *childController = [NSMutableArray arrayWithCapacity:10];
    // channel
    NSArray *channels = @[@{kZPJModelKeyVideoChannelTitle:@"推荐", kZPJModelKeyVideoChannelType:@"1600"}, @{kZPJModelKeyVideoChannelTitle:@"记录", kZPJModelKeyVideoChannelType:@"1610"}, @{kZPJModelKeyVideoChannelTitle:@"旅行", kZPJModelKeyVideoChannelType:@"1620"}, @{kZPJModelKeyVideoChannelTitle:@"科技", kZPJModelKeyVideoChannelType:@"1630"}, @{kZPJModelKeyVideoChannelTitle:@"搞笑", kZPJModelKeyVideoChannelType:@"1611"}, @{kZPJModelKeyVideoChannelTitle:@"综艺", kZPJModelKeyVideoChannelType:@"1621"}, @{kZPJModelKeyVideoChannelTitle:@"生活", kZPJModelKeyVideoChannelType:@"1631"}, @{kZPJModelKeyVideoChannelTitle:@"音乐", kZPJModelKeyVideoChannelType:@"1612"}, @{kZPJModelKeyVideoChannelTitle:@"时尚", kZPJModelKeyVideoChannelType:@"1622"}];
    for (NSDictionary *channel in channels) {
        ZPJVideoPageVC *pageController = [[ZPJVideoPageVC alloc] init];
        NSMutableDictionary *channelInfo = [channel mutableCopy];
        NSValue *pageSize = [NSValue valueWithCGSize:CGSizeMake(kZPJScreenWidth, kZPJScreenHeight - kZPJScreenNavigationBarHeight)];
        [channelInfo setObject:pageSize forKey:kZPJModelKeyVideoChannelPageSize];
        pageController.channelInfo = channelInfo.copy;
        [childController addObject:pageController];
    }
    config.cm_childControllers = childController; //必传参数
    
    pageView.cm_config = config;

    [self.view addSubview:pageView];
}

@end
