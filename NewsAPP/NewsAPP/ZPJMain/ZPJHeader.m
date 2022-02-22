//
//  ZPJHeader.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/21.
//

#import "ZPJHeader.h"

NSString *const ZPJStringConstant = @"EOCStringConstant";

#pragma mark - Screen
const CGFloat kZPJScreenHeight = 926;
const CGFloat kZPJScreenWidth = 428;
const CGFloat kZPJScreenStatusBarHeight = 47;
const CGFloat kZPJScreenNavigationBarHeight = 44;
const CGFloat kZPJScreenTabBarHeight = 49;
const CGFloat kZPJScreenBottomMargin = 34;


#pragma mark - Network
NSString *const kZPJNetworkNewsURL = @"http://v.juhe.cn/toutiao/index?type=%@&key=d268884b9b07c0eb9d6093dc54116018&page=%@";
NSString *const kZPJNetworkVideoURL =  @"http://baobab.kaiyanapp.com/api/v4/tabs/selected?date=%@718800000&page=2";
NSString *const kZPJNetworkRecommendURL =  @"https://api.tuchong.com/feed-app";
NSString *const kZPJNetworkRecommendDetailURL =  @"https://photo.tuchong.com/%@/f/%@.jpg";


#pragma mark - LocalCache
NSString *const kZPJLocalCachePath =  @"ZPJData";

NSString *const kZPJLocalCacheNewsPath =  @"ZPJData/newsList";
NSString *const kZPJLocalCacheNewsFileName =  @"newsList";

NSString *const kZPJLocalCacheVideoPath =  @"ZPJData/videoList";
NSString *const kZPJLocalCacheVideoFileName =  @"videoList";

NSString *const kZPJLocalCacheRecommendPath =  @"ZPJData/recommendList";
NSString *const kZPJLocalCacheRecommendFileName =  @"recommendList";


#pragma mark - CellReuseIdentifier

NSString *const kZPJCellReuseIdentifierNewsCell =  @"ZPJNewsNormalCell";
NSString *const kZPJCellReuseIdentifierVideoCell =  @"ZPJVideoCell";
NSString *const kZPJCellReuseIdentifierRecommendCell =  @"ZPJRecommendCell";


#pragma mark - Model Dictionary Key
// News mdoel
NSString *const kZPJModelKeyNewsRespondResult = @"result";
NSString *const kZPJModelKeyNewsGetData = @"data";
NSString *const kZPJModelKeyNewsChannelPageSize = @"pageSize";
NSString *const kZPJModelKeyNewsChannelTitle = @"title";
NSString *const kZPJModelKeyNewsChannelType = @"type";
NSString *const kZPJModelKeyNewsChannelPage = @"page";

// Video mdoel
NSString *const kZPJModelKeyVideoGetData = @"itemList";
NSString *const kZPJModelKeyVideoChannelPageSize = @"pageSize";
NSString *const kZPJModelKeyVideoChannelType = @"type";
NSString *const kZPJModelKeyVideoChannelTitle = @"title";


// Recommend mdoel
NSString *const kZPJModelKeyRecommendGetData =  @"feedList";
NSString *const kZPJModelKeyRecommendImageUserID = @"user_id";
NSString *const kZPJModelKeyRecommendImageImageID = @"img_id";
NSString *const kZPJModelKeyRecommendImageHeight = @"height";
NSString *const kZPJModelKeyRecommendImageWidth = @"width";

NSString *const kZPJModelKeyRecommendAuthorIcon = @"icon";
NSString *const kZPJModelKeyRecommendAuthorName = @"name";
NSString *const kZPJModelKeyRecommendAuthorURL = @"url";
NSString *const kZPJModelKeyRecommendAuthorDescription = @"description";
NSString *const kZPJModelKeyRecommendAuthorFollowers = @"followers";

NSString *const kZPJModelKeyRecommendPictureSize = @"pictureSize";
NSString *const kZPJModelKeyRecommendExcerptSize = @"excerptSize";


#pragma  mark - Image
NSString *const kZPJImagePlaceHolder =  @"placeholder_image.png";
