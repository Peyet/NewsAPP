//
//  ZPJVideoListItem.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 视频界面的model
@interface ZPJVideoListItem : NSObject<NSSecureCoding>

// video cover
@property (nonatomic, copy) NSString *videoCover;
// video detail
@property (nonatomic, copy) NSString *videoTitle;
@property (nonatomic, copy) NSString *videoDescription;
// video playUrl
@property (nonatomic, copy) NSString *videoPlayUrl;
// video tag
@property (nonatomic, copy) NSString *videoCategory;//广告
// video author
@property (nonatomic, copy) NSString *videoAuthorIcon;
@property (nonatomic, copy) NSString *videoAuthorName;
// video consumption:
@property (nonatomic, copy) NSNumber *videoCollectionCount;
@property (nonatomic, copy) NSNumber *videoShareCount;
@property (nonatomic, copy) NSNumber *videoReplyCount;
// video webUrl
@property (nonatomic, copy) NSString *videoRaw;
// video duration
@property (nonatomic, copy) NSNumber *videoDuration;
// video cellHeight
@property (nonatomic, assign) CGFloat videoCellHeight;

/// 根据cell内容设置cell的布局信息
/// @param dictionary cell的内容
- (instancetype)initWithConfig:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
