//
//  ZPJHeader.h
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Screen
UIKIT_EXTERN  const CGFloat kZPJScreenHeight;
UIKIT_EXTERN  const CGFloat kZPJScreenWidth;

UIKIT_EXTERN  const CGFloat kZPJScreenStatusBarHeight;
UIKIT_EXTERN  const CGFloat kZPJScreenNavigationBarHeight;

UIKIT_EXTERN  const CGFloat kZPJScreenTabBarHeight;
UIKIT_EXTERN  const CGFloat kZPJScreenBottomMargin;


#pragma mark - Network
UIKIT_EXTERN NSString *const kZPJNetworkNewsURL;                            // 新闻列表请求地址
UIKIT_EXTERN NSString *const kZPJNetworkVideoURL;                           // 视频列表请求地址
UIKIT_EXTERN NSString *const kZPJNetworkRecommendURL;                       // 推荐列表请求地址
UIKIT_EXTERN NSString *const kZPJNetworkRecommendDetailURL;                 // 推荐详情请求地址


#pragma mark - LocalCache
UIKIT_EXTERN NSString *const kZPJLocalCachePath;                            // 缓存文件本地目录

UIKIT_EXTERN NSString *const kZPJLocalCacheNewsPath;                        // 新闻缓存本地目录
UIKIT_EXTERN NSString *const kZPJLocalCacheNewsFileName;                    // 新闻缓存文件名字

UIKIT_EXTERN NSString *const kZPJLocalCacheVideoPath;                       // 视频缓存本地目录
UIKIT_EXTERN NSString *const kZPJLocalCacheVideoFileName;                   // 视频缓存文件名字

UIKIT_EXTERN NSString *const kZPJLocalCacheRecommendPath;                   // 推荐缓存本地目录
UIKIT_EXTERN NSString *const kZPJLocalCacheRecommendFileName;               // 推荐缓存文件名字


#pragma mark - Color
#define kZPJ_COLOR_NAVIGATIONBAR     [UIColor redColor]
#define kZPJ_COLOR_TABBAR            [UIColor colorWithRed:0.97f green:0.97f blue:0.95f alpha:1.0f]
#define kZPJ_COLOR_VIDEOPAGE         [UIColor colorWithRed:0.92f green:0.92f blue:0.95f alpha:1.0f]


#pragma mark - CellReuseIdentifier
UIKIT_EXTERN NSString *const kZPJCellReuseIdentifierNewsCell;               // 新闻单图cell重用ID
UIKIT_EXTERN NSString *const kZPJCellReuseIdentifierNewsMultiPicCell;       // 新闻多图cell重用ID
UIKIT_EXTERN NSString *const kZPJCellReuseIdentifierVideoCell;              // 视频cell重用ID
UIKIT_EXTERN NSString *const kZPJCellReuseIdentifierRecommendCell;          // 推荐cell重用ID


#pragma mark - Model Dictionary Key
// News mdoel
UIKIT_EXTERN NSString *const kZPJModelKeyNewsRespondResult;                 // 判断返回是否结果为空
UIKIT_EXTERN NSString *const kZPJModelKeyNewsGetData;                       // 获取新闻模型数组
UIKIT_EXTERN NSString *const kZPJModelKeyNewsChannelTitle;                  // 子频道标题
UIKIT_EXTERN NSString *const kZPJModelKeyNewsChannelType;                   // 子频道类型
UIKIT_EXTERN NSString *const kZPJModelKeyNewsChannelPageSize;               // 子频道视图大小
UIKIT_EXTERN NSString *const kZPJModelKeyNewsChannelPage;                   // 子频道中控制翻页
// Video mdoel
UIKIT_EXTERN NSString *const kZPJModelKeyVideoGetData;                      // 获取视频模型数组
UIKIT_EXTERN NSString *const kZPJModelKeyVideoChannelPageSize;              // 子频道视图大小
UIKIT_EXTERN NSString *const kZPJModelKeyVideoChannelTitle;                 // 子频道标题
UIKIT_EXTERN NSString *const kZPJModelKeyVideoChannelType;                  // 子频道类型
// Recommend mdoel
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendGetData;                  // 获取图片模型数组
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendImageUserID;              // 作者ID
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendImageImageID;             // 图片ID
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendImageHeight;              // 图片高度
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendImageWidth;               // 图片宽度

UIKIT_EXTERN NSString *const kZPJModelKeyRecommendAuthorIcon;               // 作者头像
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendAuthorName;               // 作者名
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendAuthorURL;                // 作者主页
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendAuthorDescription;        // 作者个签
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendAuthorFollowers;          // 作者粉丝数量

UIKIT_EXTERN NSString *const kZPJModelKeyRecommendPictureSize;              // 图片View大小
UIKIT_EXTERN NSString *const kZPJModelKeyRecommendExcerptSize;              // 图片说明view大小


#pragma  mark - Image
UIKIT_EXTERN NSString *const kZPJImagePlaceHolder;                          // 占位图片



