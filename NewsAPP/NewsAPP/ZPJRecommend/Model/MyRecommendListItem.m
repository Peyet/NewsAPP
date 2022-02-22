//
//  MyRecommendListItem.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import "MyRecommendListItem.h"

@implementation MyRecommendListItem

#pragma mark - public method
/// 创建model对象
/// @param dictionary 初始化model的字典
- (instancetype)initWithConfig:(NSDictionary *)dictionary {
    [self setValuesForKeysWithDictionary:dictionary];
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
