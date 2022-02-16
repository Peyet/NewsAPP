//
//  MyVideoPageViewController.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyVideoPageViewController : UIViewController
@property (nonatomic, strong, readwrite) NSMutableDictionary *channelInfo;

//- (void)loadControllerWithChannel:(NSDictionary *)channel Frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
