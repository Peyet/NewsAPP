//
//  ZPJVideoPlayer.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 播放器
@interface ZPJVideoPlayer : NSObject


/// 全局（单例）播放器
+ (ZPJVideoPlayer *)sharedPlayer;

/// 设置播放内容
/// @param videoUrl 视频内容URL
- (void)playVideoWithvideoUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
