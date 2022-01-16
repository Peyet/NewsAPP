//
//  MyListItem.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/16.
//

#import "MyListItem.h"

@implementation MyListItem

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
