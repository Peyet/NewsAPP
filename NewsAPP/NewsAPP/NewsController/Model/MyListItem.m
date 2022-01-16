//
//  MyListItem.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import "MyListItem.h"

@implementation MyListItem

#pragma mark - NSSecureCoding
/// 编解码
/// @param coder coder description
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.category forKey:@"category"];
    [coder encodeObject:self.is_content forKey:@"is_content"];
    [coder encodeObject:self.uniquekey forKey:@"uniquekey"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.author_name forKey:@"author_name"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.thumbnail_pic_s forKey:@"thumbnail_pic_s"];
    [coder encodeObject:self.thumbnail_pic_s02 forKey:@"thumbnail_pic_s02"];
    [coder encodeObject:self.thumbnail_pic_s03 forKey:@"thumbnail_pic_s03"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.category = [coder decodeObjectForKey:@"category"];
        self.is_content = [coder decodeObjectForKey:@"is_content"];
        self.uniquekey = [coder decodeObjectForKey:@"uniquekey"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.date = [coder decodeObjectForKey:@"date"];
        self.author_name = [coder decodeObjectForKey:@"author_name"];
        self.url = [coder decodeObjectForKey:@"url"];
        self.thumbnail_pic_s = [coder decodeObjectForKey:@"thumbnail_pic_s"];
        self.thumbnail_pic_s02 = [coder decodeObjectForKey:@"thumbnail_pic_s02"];
        self.thumbnail_pic_s03 = [coder decodeObjectForKey:@"thumbnail_pic_s03"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma mark - public method
/// 给listItem的属性设置网络数据
/// @param dictionary dictionary description
- (instancetype)initWithConfig:(NSDictionary *)dictionary {
    [self setValuesForKeysWithDictionary:dictionary];
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"category:%@,/n is_content:%@,/n uniquekey:%@,/n title:%@,/n date:%@,/n author_name:%@,/n url:%@,/n thumbnail_pic_s:%@,/n thumbnail_pic_s02:%@,/n thumbnail_pic_s03:%@\n ",
    self.category,
    self.is_content,
    self.uniquekey,
    self.title,
    self.date,
    self.author_name,
    self.url,
    self.thumbnail_pic_s,
    self.thumbnail_pic_s02,
     self.thumbnail_pic_s03];
}

@end
