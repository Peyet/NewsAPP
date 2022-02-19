//
//  MyRecommendPageViewController.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 推荐Tab对应的Controller
@interface MyRecommendPageViewController : UIViewController

@property (nonatomic, strong, readwrite) NSMutableDictionary *channelInfo;

@end

NS_ASSUME_NONNULL_END
