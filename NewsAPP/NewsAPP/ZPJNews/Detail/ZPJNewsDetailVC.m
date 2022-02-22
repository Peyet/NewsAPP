//
//  ZPJNewsDetailVC.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import "ZPJNewsDetailVC.h"
#import <WebKit/WebKit.h>

@interface ZPJNewsDetailVC ()

@property (nonatomic, strong, readwrite) WKWebView *webView;
@property (nonatomic, strong, readwrite) UIProgressView *progressView;
@property (nonatomic, strong, readwrite) NSString *articleUrl;

@end

@implementation ZPJNewsDetailVC
#pragma mark - 监听Key
static NSString *const kEstimatedProgress = @"estimatedProgress";                    // 加载进度

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _articleUrl = urlString;
    }
    return self;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:kEstimatedProgress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDetailView];
}

/// 初始化新闻详情界面
- (void)setupDetailView {
    [self.view addSubview:({
            WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
            self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        self.webView;
    })];
    // 加载进度条
    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, 20)];
        self.progressView;
    })];
    
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.articleUrl]]];
    
    // 监听网页加载进度
    [self.webView addObserver:self forKeyPath:kEstimatedProgress options:NSKeyValueObservingOptionNew context:nil];

}

/// 更新进度条
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    self.progressView.progress = self.webView.estimatedProgress;
}

@end
