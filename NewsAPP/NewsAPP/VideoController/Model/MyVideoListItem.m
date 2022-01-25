//
//  MyVideoListItem.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/22.
//

#import "MyVideoListItem.h"
#import "NSString+LabelSizeCalculator.h"

@implementation MyVideoListItem

#pragma mark - NSSecureCoding
- (void)encodeWithCoder:(NSCoder *)coder {
    // video cover
    [coder encodeObject:self.videoCover forKey:@"videoCover"];
    // video detail
    [coder encodeObject:self.videoTitle forKey:@"videoTitle"];
    [coder encodeObject:self.videoDescription forKey:@"videoDescription"];
    // video playUrl
    [coder encodeObject:self.videoPlayUrl forKey:@"videoPlayUrl"];
    // video tag
    [coder encodeObject:self.videoCategory forKey:@"videoCategory"];
    // video author
    [coder encodeObject:self.videoAuthorIcon forKey:@"videoAuthorIcon"];
    [coder encodeObject:self.videoAuthorName forKey:@"videoAuthorName"];
    // video consumption
    [coder encodeObject:self.videoCollectionCount forKey:@"videoCollectionCount"];
    [coder encodeObject:self.videoShareCount forKey:@"videoShareCount"];
    [coder encodeObject:self.videoReplyCount forKey:@"videoReplyCount"];
    // video webUrl
    [coder encodeObject:self.videoCategory forKey:@"videoRaw"];
    // video duration
    [coder encodeObject:self.videoDuration forKey:@"videoDuration"];
    // video cellHeight
    [coder encodeFloat:self.videoCellHeight forKey:@"cellHeight"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        // video cover
        [coder decodeObjectForKey:@"videoCover"];
        // video detail
        [coder decodeObjectForKey:@"videoTitle"];
        [coder decodeObjectForKey:@"videoDescription"];
        // video playUrl
        [coder decodeObjectForKey:@"videoPlayUrl"];
        // video tag
        [coder decodeObjectForKey:@"videoCategory"];
        // video author
        [coder decodeObjectForKey:@"videoAuthorIcon"];
        [coder decodeObjectForKey:@"videoAuthorName"];
        // video consumption
        [coder decodeObjectForKey:@"videoCollectionCount"];
        [coder decodeObjectForKey:@"videoShareCount"];
        [coder decodeObjectForKey:@"videoReplyCount"];
        // video webUrl
        [coder decodeObjectForKey:@"videoRaw"];
        // video duration
        [coder decodeObjectForKey:@"videoDuration"];
        // video cellHeight
        [coder decodeFloatForKey:@"cellHeight"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - public method
- (instancetype)initWithConfig:(NSDictionary *)dictionary {
    if ([dictionary[@"type"] isEqualToString:@"video"]) {
        self = [super init];
        if (self) {
            NSDictionary *videoData = dictionary[@"data"];
            _videoCover = [(videoData[@"cover"]) objectForKey:@"feed"];
            
            _videoTitle = videoData[@"title"];
            _videoDescription = videoData[@"description"];
            
            _videoPlayUrl = videoData[@"playUrl"];
            
            _videoCategory = videoData[@"category"];
            
            _videoAuthorIcon = [(videoData[@"author"]) objectForKey:@"icon"];
            _videoAuthorName = [(videoData[@"author"]) objectForKey:@"name"];
            
            _videoCollectionCount = [(videoData[@"consumption"]) objectForKey:@"collectionCount"];
            _videoShareCount = [(videoData[@"consumption"]) objectForKey:@"shareCount"];
            _videoReplyCount = [(videoData[@"consumption"]) objectForKey:@"replyCount"];
            
            _videoRaw = [videoData[@"webUrl"] objectForKey:@"raw"];;
            
            _videoDuration = videoData[@"duration"];
            
            _videoCellHeight = [self layoutCell];
        }
        return self;
    }
    return nil;
}

- (CGFloat)layoutCell {
    // cell格式默认配置
    CGFloat margin = 10;
    CGFloat titleFontSize = 22, detailFontSize = 15;
    UIFont *titleFont = [UIFont systemFontOfSize:titleFontSize];
    UIFont *detailFont = [UIFont systemFontOfSize:detailFontSize];

    // 视频封面大小
    CGFloat videoCoverwidth = ([UIApplication sharedApplication].keyWindow.frame.size.width - 16);
    CGFloat videoCoverHeight = ([UIApplication sharedApplication].keyWindow.frame.size.width - 16) * 9 / 16;
    // 视频文字介绍大小
    CGFloat titleHeight = [self.videoTitle sizeOfTextWithMaxSize:CGSizeMake(videoCoverwidth - margin*2, CGFLOAT_MAX) Font:titleFont].height;
    CGFloat detailHeight = [self.videoCategory sizeOfTextWithMaxSize:CGSizeMake(videoCoverwidth - margin*2, CGFLOAT_MAX) Font:detailFont].height;
    // cell的高度
    CGFloat cellHeight = videoCoverHeight + (margin + titleHeight) + (margin + detailHeight) + margin;
    return cellHeight;
}

@end
