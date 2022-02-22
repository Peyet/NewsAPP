//
//  MyRecommendListItem.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 推荐界面的model
@interface MyRecommendListItem : NSObject

@property (nonatomic, copy, readwrite) NSString *type; // 返回数据的类型 组图：multi-photo 文字文章：text

@property (nonatomic, copy, readwrite) NSString *title_image; // 文字文章的标题

@property (nonatomic, copy, readwrite) NSString *title; // 图片标题
@property (nonatomic, copy, readwrite) NSString *excerpt; // 图片文字简介
@property (nonatomic, copy, readwrite) NSString *published_at; // 发布时间


@property (nonatomic, copy, readwrite) NSArray *images; //图片宽高等信息 存放字典数组

@property (nonatomic, copy, readwrite) NSDictionary *site; // 作者信息 字典

@property (nonatomic, copy, readwrite) NSNumber *favorites; // 点赞数
@property (nonatomic, copy, readwrite) NSNumber *comments; // 评论数
@property (nonatomic, copy, readwrite) NSNumber *views; // 浏览次数
@property (nonatomic, copy, readwrite) NSNumber *shares; //分享次数
@property (nonatomic, copy, readwrite) NSString *url;// 网页链接

@property (nonatomic, copy, readwrite) NSDictionary *cellSize; // 显示图片的cell大小

/// 创建model对象
/// @param dictionary 初始化model的字典
- (instancetype)initWithConfig:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
