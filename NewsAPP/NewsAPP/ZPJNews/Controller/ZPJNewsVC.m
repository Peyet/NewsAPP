//
//  ZPJNewsVC.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/9.
//

#import "ZPJNewsVC.h"
#import "ZPJSearchBar.h"
#import <CMPageTitleView/CMPageTitleView.h>
#import "ZPJNewsPageVC.h"
#import "ZPJHeader.h"

@interface ZPJNewsVC ()
@property (nonatomic, strong) CMPageTitleView *pageView;
@property (nonatomic, strong) NSMutableArray<ZPJNewsPageVC *> *childControllers;
@end

@implementation ZPJNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageTitleView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setViewFrame];
}

#pragma mark - Life Cycle
/// 设置PageTitleView
- (void)setupPageTitleView {
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    pageView.backgroundColor = [UIColor purpleColor];
    self.pageView = pageView;
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    // 遮罩样式
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    // 是否全面屏显示
    config.cm_fullScreen = NO;

    // 设置pageView的子控制器
    _childControllers = [NSMutableArray arrayWithCapacity:10];
    // channel配置信息 top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
    NSArray *channels = @[@{kZPJModelKeyNewsChannelTitle:@"头条", kZPJModelKeyNewsChannelType:@"top"}, @{kZPJModelKeyNewsChannelTitle:@"国内", kZPJModelKeyNewsChannelType:@"guonei"}, @{kZPJModelKeyNewsChannelTitle:@"国际", kZPJModelKeyNewsChannelType:@"guoji"}, @{kZPJModelKeyNewsChannelTitle:@"娱乐", kZPJModelKeyNewsChannelType:@"yule"}, @{kZPJModelKeyNewsChannelTitle:@"体育", kZPJModelKeyNewsChannelType:@"tiyu"}, @{kZPJModelKeyNewsChannelTitle:@"军事", kZPJModelKeyNewsChannelType:@"junshi"}, @{kZPJModelKeyNewsChannelTitle:@"科技", kZPJModelKeyNewsChannelType:@"keji"}, @{kZPJModelKeyNewsChannelTitle:@"财经", kZPJModelKeyNewsChannelType:@"caijing"}, @{kZPJModelKeyNewsChannelTitle:@"时尚", kZPJModelKeyNewsChannelType:@"shishang"}];
    for (NSDictionary *channel in channels) {
        ZPJNewsPageVC *pageController = [[ZPJNewsPageVC alloc] init];
        // 设置page Controller大小
        NSMutableDictionary *channelInfo = [channel mutableCopy];
        pageController.channelInfo = [channelInfo mutableCopy];
        [_childControllers addObject:pageController];
    }
    config.cm_childControllers = _childControllers; //必传参数
    pageView.cm_config = config;

    [self.view addSubview:pageView];
}

/// 重新布局当前frame
- (void)setViewFrame {
    self.pageView.frame = CGRectMake(0,kZPJScreenStatusBarHeight + kZPJScreenNavigationBarHeight,kZPJScreenWidth,kZPJScreenHeight);
    NSMutableDictionary *channelInfo;
    for (ZPJNewsPageVC *childController in _childControllers) {
        channelInfo = [childController.channelInfo mutableCopy];
        NSValue *pageSize = [NSValue valueWithCGSize:CGSizeMake(kZPJScreenWidth, kZPJScreenHeight - kZPJScreenNavigationBarHeight)];
        [channelInfo setObject:pageSize forKey:kZPJModelKeyNewsChannelPageSize];
        childController.channelInfo = channelInfo;
    }
}

@end
