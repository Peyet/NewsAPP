//
//  ZPJVideoPageVC.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPJVideoPageVC : UIViewController

/// 设置page View的初始化信息
/// @param channelInfo 设置频道的信息
- (void)setPageChannleInfo:(NSDictionary *)channelInfo;

@end

NS_ASSUME_NONNULL_END
