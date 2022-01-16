//
//  MyDetailViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import "MyDetailViewController.h"
#import <WebKit/WebKit.h>

@interface MyDetailViewController ()

@property (nonatomic, strong, readwrite) WKWebView *webView;
@property (nonatomic, strong, readwrite) UIProgressView *progressView;
@property (nonatomic, strong, readwrite) NSString *articleUrl;

@end

@implementation MyDetailViewController

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _articleUrl = urlString;
    }
    return self;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
            WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
            self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        self.webView;
    })];
    
    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, 20)];
        self.progressView;
    })];
    
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.articleUrl]]];
    
    // 监听网页加载进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

// 更新进度条
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    self.progressView.progress = self.webView.estimatedProgress;
}

@end
