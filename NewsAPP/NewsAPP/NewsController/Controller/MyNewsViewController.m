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
    CMPageTitleView *pageView = [[CMPageTitleView alloc] initWithFrame:CGRectMake(0, 44+47, self.view.bounds.size.width, self.view.bounds.size.height)];
    pageView.delegate = self;
    
    CMPageTitleConfig *config = [CMPageTitleConfig defaultConfig];
    // 遮罩样式
    config.cm_switchMode = CMPageTitleSwitchMode_Cover;
    // 是否全面屏显示
    config.cm_fullScreen = NO;

    NSMutableArray *childController = [NSMutableArray arrayWithCapacity:10];
    // channel top(头条，默认),shehui(社会),guonei(国内),guoji(国际),yule(娱乐),tiyu(体育)junshi(军事),keji(科技),caijing(财经),shishang(时尚)
    NSArray *channels = @[@{@"title":@"头条", @"type":@"top"}, @{@"title":@"国内", @"type":@"guonei"}, @{@"title":@"国际", @"type":@"guoji"}, @{@"title":@"娱乐", @"type":@"yule"}, @{@"title":@"体育", @"type":@"tiyu"}, @{@"title":@"军事", @"type":@"junshi"}, @{@"title":@"科技", @"type":@"keji"}, @{@"title":@"财经", @"type":@"caijing"}, @{@"title":@"时尚", @"type":@"shishang"}];
    for (NSDictionary *channel in channels) {
        MyNewsPageViewController *PageController = [[MyNewsPageViewController alloc] initControllerWithChannel:channel Frame:self.view.frame];
        [childController addObject:PageController];
    }
    config.cm_childControllers = childController; //必传参数
    
    pageView.cm_config = config;

    [self.view addSubview:pageView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.navigationItem setTitleView:({
        MySearchBar *searchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
        searchBar;
    })];
}

@end
