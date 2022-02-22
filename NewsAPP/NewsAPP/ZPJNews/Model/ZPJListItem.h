//
//  ZPJListItem.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 新闻界面的model
@interface ZPJListItem : NSObject <NSSecureCoding>

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *is_content;
@property (nonatomic, copy) NSString *uniquekey;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *author_name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *thumbnail_pic_s;
@property (nonatomic, copy) NSString *thumbnail_pic_s02;
@property (nonatomic, copy) NSString *thumbnail_pic_s03;

- (instancetype)initWithConfig:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
