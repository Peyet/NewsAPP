//
//  MyListItem.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 新闻界面的model
@interface MyListItem : NSObject <NSSecureCoding>

@property (nonatomic, copy, readwrite) NSString *category;
@property (nonatomic, copy, readwrite) NSString *is_content;
@property (nonatomic, copy, readwrite) NSString *uniquekey;
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *date;
@property (nonatomic, copy, readwrite) NSString *author_name;
@property (nonatomic, copy, readwrite) NSString *url;
@property (nonatomic, copy, readwrite) NSString *thumbnail_pic_s;
@property (nonatomic, copy, readwrite) NSString *thumbnail_pic_s02;
@property (nonatomic, copy, readwrite) NSString *thumbnail_pic_s03;

- (instancetype)initWithConfig:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
