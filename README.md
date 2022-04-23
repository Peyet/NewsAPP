<p align="center">
<img src="http://img.cdn.peyet.org/img/NewsAPP/TitleImage.png" alt="NewsAPP" title="NewsAPP" width="557"/>
</p>
<p align="center">
<img src="https://img.shields.io/badge/platform-iOS-blue" alt="platform">
<img src="https://img.shields.io/tokei/lines/github/peyet/NewsAPP" alt="Lines of code">
<img src="https://img.shields.io/github/last-commit/peyet/NewsAPP" alt="GitHub last commit">
<img src="https://img.shields.io/github/v/release/peyet/NewsAPP?include_prereleases" alt="GitHub releases">
<img src="https://img.shields.io/github/license/peyet/NewsAPP" alt="License">  
<a href="https://twitter.com/PeyetZh"><img src="https://img.shields.io/twitter/follow/peyetzh?style=social" alt="Twitter Follow"></a>
</p>



# NewsAPP

一款新闻与娱乐的聚合iOS应用。

<table border="1" style = "center">
    <tr>
        <td>开发平台</td>
        <td>Xcode 13.1</td>
        <td>iOS 15.0</td>
    </tr>
</table>

## 应用演示
<a href="http://img.cdn.peyet.org/img/NewsAPP/Splash.gif" target="_blank"><img src="http://img.cdn.peyet.org/img/NewsAPP/Splash.gif" alt="Splash" style="zoom:25%;" /></a><a href="http://img.cdn.peyet.org/img/NewsAPP/News.gif" target="_blank"><img src="http://img.cdn.peyet.org/img/NewsAPP/News.gif" alt="News" style="zoom:25%;" /></a><a href="http://img.cdn.peyet.org/img/NewsAPP/Video.gif" target="_blank"><img src="http://img.cdn.peyet.org/img/NewsAPP/Video.gif" alt="Video" style="zoom:25%;" /></a><a href="http://img.cdn.peyet.org/img/NewsAPP/Recommend.gif" target="_blank"><img src="http://img.cdn.peyet.org/img/NewsAPP/Recommend.gif" alt="Recommend" style="zoom:25%;" /></a>


如果不能正常显示，请点击加载失败的图片跳转查看						

## TODO List

- [x] **推送通知**

- [x] **开屏广告**

- [x] **加载新闻、视频、图片列表**

- [x] **查看新闻、图片详情**

- [x] **已读新闻标记**

- [x] **删除页面内容**

- [x] **离线缓存**

- [ ] 分享功能

- [ ] 优化离线缓存

- [ ] 个人中心（使用后端云服务存储用户数据）

## API

[新闻](https://www.free-api.com/doc/66)	[视频](https://www.free-api.com/doc/515)	[图片](https://github.com/huanghui0906/API/blob/master/Tuchong.md)

## 技术实现

- 开屏广告

  ​	iOS系统在App启动前，也就是AppDelegate的`- application: didFinishLaunchingWithOptions:` 前，会加载一个从LaunchScreen中提前准备好的启动图片，在加载完成App UI后，这张图片就会消失。由于现在手机手机处理器速度很快，这张图片的展示事件非常短，所以需要在展示完系统启动图后衔接一个和系统启动图一样的界面。

  ​	这里选择了在SceneDelegate中 `- scene: willConnectToSession options:` 即将把Scene绑定到UIWindow的时候，配置我们的自定义广告界面。这样就实现了无缝切换 。

- 标题栏

  ![CMPageTitleView](http://img.cdn.peyet.org/img/NewsAPP/CMPageTitleView.png)

  ​    标题栏采用了GitHub上现有的轮子:[CMPageTitleView](https://github.com/CrabMen/CMPageTitleView), 这里自定义了选中状态下的标题的样式。

- 网络请求

  ​	网络请求使用了AFNetWorking框架，并进行了一定的封装。请求回正确的数据后开启新的线程处理数据。

```objective-c
    __weak typeof(self) weakSelf = self;
    [[AFHTTPSessionManager manager] GET:requestURL parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            // 请求数据失败，返回缓存数据
            if ([responseObject[kZPJModelKeyNewsRespondResult] isKindOfClass:[NSNull class]]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finishBlock) {
                        finishBlock(YES, listData);
                    }
                });
                return;
            }
            // 请求成功，返回网络数据
            NSArray *dataArray = [(responseObject[kZPJModelKeyNewsRespondResult]) objectForKey:kZPJModelKeyNewsGetData];
            NSMutableArray *listItemArray = [NSMutableArray arrayWithCapacity:30];
            for (NSDictionary *info in dataArray) {
                ZPJListItem *listItem = [[ZPJListItem alloc] initWithConfig:info];
                [listItemArray addObject:listItem];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock(YES, listItemArray);
                }
            });
            // 缓存数据
            [strongSelf _archiveListDataWithArray:listItemArray.copy];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求数据失败
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock) {
                    finishBlock(NO, listData);
                }
            });
        }];
```

- 读取/缓存 新闻数据

  缓存新闻数据

```objective-c
- (void)_archiveListDataWithArray:(NSArray<ZPJListItem *> *)array {
    NSArray *pathArray =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 初始化文件
    NSString *dataPath = [cachePath stringByAppendingPathComponent:kZPJLocalCachePath];
    if (![fileManager fileExistsAtPath:dataPath]) {
        NSError *createError;
        [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    }
    
    // 缓存新闻数据
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:kZPJLocalCacheNewsFileName];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:NULL];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
}    
```

​		读取新闻数据

```objective-c
- (NSArray<ZPJListItem *> *)_readDataFromLocal{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:kZPJLocalCacheNewsPath];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSData *readListData = [fileManager contentsAtPath:listDataPath];

    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[ZPJListItem class], nil]  fromData:readListData error:nil];
    
    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<ZPJListItem *> *)unarchiveObj;
    }
    return nil;;
}
```


- 加载上下拉数据

  ​	使用了MJRefresh框架来实现。

  ```objective-c
  - (void)loadNewmodels {
      __weak typeof(self)wself = self;
      [self.listLoader loadListDataWithChannelInfo:self.channelInfo FinishBlock:^(BOOL success, NSArray<ZPJListItem *> * _Nonnull dataArray) {
          __strong typeof(wself) strongSelf = wself;
          if (success) {
              strongSelf.dataArray = [dataArray mutableCopy];
              [strongSelf.tableView.mj_header endRefreshing];
              [strongSelf.tableView reloadData];
          } else {
              dispatch_async(dispatch_get_main_queue(), ^{
                  [strongSelf.tableView.mj_header endRefreshing];
                  [strongSelf.tableView reloadData];
              });
          }
      }];
  }
  ```

- 视频播放器使用AVFoundation类库实现。

  ```objective-c
  - (void)playVideoWithvideoUrl:(NSString *)videoUrl attachView:(UIView *)attachView {
      // 停止上次播放
      [self _stopPlay];
      
      AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:videoUrl]];
      _videoItem = [AVPlayerItem playerItemWithAsset:asset];
      
      // 监听视频资源状态、缓冲进度
      [_videoItem addObserver:self forKeyPath:kVideoObserverStatus options:NSKeyValueObservingOptionNew context:nil];
      [_videoItem addObserver:self forKeyPath:kVideoObserverTimeRanges options:NSKeyValueObservingOptionNew context:nil];
      
      CMTime duration = _videoItem.duration;
      CGFloat videoDuration = CMTimeGetSeconds(duration);
      
      // 创建播放器
      _avPlayer = [AVPlayer playerWithPlayerItem:_videoItem];
      [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
          NSLog(@"播放进度：%@", @(CMTimeGetSeconds(time)));
      }];
      
      // 展示播放画面
      _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
      _playerLayer.frame = attachView.bounds;
      [attachView.layer addSublayer:_playerLayer];
      
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
  
  }
  ```

- 推荐界面瀑布流

  ​	用继承自UICollectionViewFlowLayout的ZPJRecommendLayout来实现瀑布流样式。

  ```objective-c
  - (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
      UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
      // 计算cell的frame
      CGFloat cellX = 0, cellY = 0, cellWidth = 0, cellHeight = 0;
      // cell的宽度
      cellWidth = (self.collectionView.frame.size.width - kDefaultUIEdgeInsets.left - kDefaultUIEdgeInsets.right - kDefaultColumnMargin) / kDefaultColumnCount;
      // cell的高度
      cellHeight = kDefaultCellHeight;
      CGFloat cellPictureHeight;
      CGFloat cellExcerptHeight;
      if ([self.delegate respondsToSelector:@selector(cellImageSizeWithIndexPath:InFlowLayout:)]) {
          MyRecommendListItem *model = [self.delegate cellImageSizeWithIndexPath:indexPath InFlowLayout:self];
          // 默认字体大小配置
          CGFloat excerptFontSize = 15;
          UIFont *excerptFont = [UIFont systemFontOfSize:excerptFontSize];
          cellPictureHeight = cellWidth * [[model.images firstObject][kZPJModelKeyRecommendImageHeight] floatValue] / [[model.images firstObject][kZPJModelKeyRecommendImageWidth] floatValue];
          cellExcerptHeight = [model.excerpt sizeOfTextWithMaxSize:CGSizeMake(cellWidth, 36) Font:excerptFont].height;
          cellHeight = cellPictureHeight + cellExcerptHeight + 5 ;
      }
      
      // cell应该拼接到第几列
      NSInteger destColumn = 0;
      // 高度最小的列数高度
      CGFloat minColumnHeight = [self.columnHeights[0] floatValue];
      // 获取高度最小的列数
      for (int i = 0; i < kDefaultColumnCount; i++) {
          CGFloat columnHeight = [self.columnHeights[i] floatValue];
          if (minColumnHeight > columnHeight) {
              minColumnHeight = columnHeight;
              destColumn = i;
          }
      }
      
      // 计算cell的x
      cellX = kDefaultUIEdgeInsets.left + destColumn * (cellWidth + kDefaultColumnMargin);
      // 计算cell的y
      cellY = minColumnHeight;
      if (cellY != kDefaultUIEdgeInsets.top) {
          cellY += kDefaultRowMargin;
      }
  
      // 保存列表的高度
      if ([self.delegate respondsToSelector:@selector(setCellImageSizeWithIndexPath:cellSize:InFlowLayout:)]) {
          NSValue *pictureSize = [NSValue valueWithCGSize:CGSizeMake(cellWidth, cellPictureHeight)];
          NSValue *excerptSize = [NSValue valueWithCGSize:CGSizeMake(cellWidth - 15, cellExcerptHeight)];
          NSDictionary *cellSize = @{kZPJModelKeyRecommendPictureSize:pictureSize, kZPJModelKeyRecommendExcerptSize:excerptSize};
          [self.delegate setCellImageSizeWithIndexPath:indexPath cellSize:cellSize InFlowLayout:self];
      }
      attribute.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
      self.columnHeights[destColumn] = @(CGRectGetMaxY(attribute.frame));
      return attribute;
  }
  ```
  