//
//  ZPJNewsPageVC.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPJNewsPageVC : UIViewController

/// 设置page View的初始化信息
/// @param channelInfo 设置频道的信息
- (void)setPageChannleInfo:(NSDictionary *)channelInfo;

@end

NS_ASSUME_NONNULL_END
