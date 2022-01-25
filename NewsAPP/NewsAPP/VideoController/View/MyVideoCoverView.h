//
//  MyVideoCoverView.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import <UIKit/UIKit.h>
@class MyVideoListItem;

NS_ASSUME_NONNULL_BEGIN

/// 视频Tab对应的Cell
@interface MyVideoCoverView : UICollectionViewCell

/// 设置播放内容
/// @param videoCoverUrl 视频封面图URL
/// @param videoUrl 视频内容URL
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;

- (void)layoutWithVideoItem:(MyVideoListItem *)videoListItem;

@end

NS_ASSUME_NONNULL_END
