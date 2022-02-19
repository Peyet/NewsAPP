//
//  MyVideoListItem.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 视频界面的model
@interface MyVideoListItem : NSObject<NSSecureCoding>

// video cover
@property (nonatomic, strong, readwrite) NSString *videoCover;
// video detail
@property (nonatomic, strong, readwrite) NSString *videoTitle;
@property (nonatomic, strong, readwrite) NSString *videoDescription;
// video playUrl
@property (nonatomic, strong, readwrite) NSString *videoPlayUrl;
// video tag
@property (nonatomic, strong, readwrite) NSString *videoCategory;//广告
// video author
@property (nonatomic, strong, readwrite) NSString *videoAuthorIcon;
@property (nonatomic, strong, readwrite) NSString *videoAuthorName;
// video consumption:
@property (nonatomic, strong, readwrite) NSNumber *videoCollectionCount;
@property (nonatomic, strong, readwrite) NSNumber *videoShareCount;
@property (nonatomic, strong, readwrite) NSNumber *videoReplyCount;
// video webUrl
@property (nonatomic, strong, readwrite) NSString *videoRaw;
// video duration
@property (nonatomic, strong, readwrite) NSNumber *videoDuration;
// video cellHeight
@property (nonatomic, assign, readwrite) CGFloat videoCellHeight;

/// 根据cell内容设置cell的布局信息
/// @param dictionary cell的内容
- (instancetype)initWithConfig:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
