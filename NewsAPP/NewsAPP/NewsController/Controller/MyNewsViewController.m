//
//  MyNewsViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/9.
//

#import "MyNewsViewController.h"
#import "MySearchBar.h"
#import <CMPageTitleView/CMPageTitleView.h>
#import "MyNewsPageViewController.h"

@interface MyNewsViewController ()
@property (nonatomic, strong, readwrite) CMPageTitleView *pageView;
@property (nonatomic, strong, readwrite) NSMutableArray<MyNewsPageViewController *> *childControllers;
@end

@implementation MyNewsViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"page@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"page@2x_selected.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageTitleView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupSearchBar];
    [self setViewFrame];
}

#pragma mark - Life Cycle
/// 设置PageTitleView
- (void)setupPageTitleView {
    CMPageTitleView *pageView = [[CMPageTitleView alloc] init];
    pageView.backgroundColor = [UIColor purpleColor];
    self.pageView = pageView;
//    self.pageView.frame = CGRectMake(0,47 + 44,self.view.bounds.size.width,self.view.bounds.size.height - 47 - 44 - 83);// navi 44 statusBar47
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    // 遮罩样式
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    // 是否全面屏显示
    config.cm_fullScreen = NO;

    // 设置pageView的子控制器
    _childControllers = [NSMutableArray arrayWithCapacity:10];
    // channel配置信息 top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
    NSArray *channels = @[@{@"title":@"头条", @"type":@"top"}, @{@"title":@"国内", @"type":@"guonei"}, @{@"title":@"国际", @"type":@"guoji"}, @{@"title":@"娱乐", @"type":@"yule"}, @{@"title":@"体育", @"type":@"tiyu"}, @{@"title":@"军事", @"type":@"junshi"}, @{@"title":@"科技", @"type":@"keji"}, @{@"title":@"财经", @"type":@"caijing"}, @{@"title":@"时尚", @"type":@"shishang"}];
    for (NSDictionary *channel in channels) {
        MyNewsPageViewController *pageController = [[MyNewsPageViewController alloc] init];
        // 设置page Controller大小
        NSMutableDictionary *channelInfo = [channel mutableCopy];
        pageController.channelInfo = [channelInfo mutableCopy];
        [_childControllers addObject:pageController];
    }
    config.cm_childControllers = _childControllers; //必传参数
    pageView.cm_config = config;

    [self.view addSubview:pageView];
}

/// 设置导航栏搜索框
- (void)setupSearchBar {
    [self.tabBarController.navigationItem setTitleView:({
        MySearchBar *searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
        searchBar;
    })];
}

/// 重新布局当前frame
- (void)setViewFrame {
    self.pageView.frame = CGRectMake(0,[[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height);// statusBar47
    NSMutableDictionary *channelInfo;
    for (MyNewsPageViewController *childController in _childControllers) {
        channelInfo = [childController.channelInfo mutableCopy];
        NSValue *pageSize = [NSValue valueWithCGSize:CGSizeMake(self.view.frame.size.width, self.pageView.frame.size.height - 44)];
        [channelInfo setObject:pageSize forKey:@"pageSize"];
        childController.channelInfo = channelInfo;
    }
}

@end
