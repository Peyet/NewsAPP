//
//  MyDetailViewController.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 新闻内容（webView）对应的controller，文章底层页
@interface MyDetailViewController : UIViewController

- (instancetype)initWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
