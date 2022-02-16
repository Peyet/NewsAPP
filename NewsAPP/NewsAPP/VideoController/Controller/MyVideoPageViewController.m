//
//  MyVideoPageViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/13.
//

#import "MyVideoPageViewController.h"
#import "MyVideoCoverView.h"
#import "MyFlowLayout.h"
#import "MyVideoListLoader.h"
#import "MyVideoListItem.h"
#import <MJRefresh/MJRefresh.h>

@interface MyVideoPageViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MyFlowLayoutDelegate>

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite) MyFlowLayout *flowLayout;

@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;

@end

@implementation MyVideoPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 初始化tableView
- (void)setupTableView {
    self.flowLayout = [[MyFlowLayout alloc] init];
    self.flowLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView = collectionView;
    CGSize pageSize = [_channelInfo[@"pageSize"] CGSizeValue];
    self.view.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
    self.collectionView.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);

    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[MyVideoCoverView class] forCellWithReuseIdentifier:@"MyVideoCoverView"];
    __weak typeof(self)wself = self;
    [[MyVideoListLoader sharedMyListLoader] loadListDataWithChannel:self.channelInfo[@"type"] FinishBlock:^(BOOL success, NSArray<MyVideoListItem *> * _Nonnull dataArray) {
        if (success) {
            __strong typeof(wself) strongSelf = wself;
            strongSelf.dataArray = [dataArray mutableCopy];
            [strongSelf.collectionView reloadData];
        } else {
            __strong typeof(wself) strongSelf = wself;
            strongSelf.dataArray = [dataArray mutableCopy];
            [strongSelf.collectionView reloadData];
        }
    }];
    collectionView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    [self setupRefresh];

}

#pragma mark - 创建上下拉刷新
- (void)setupRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewmodels)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoremodels)];
}

#pragma mark - 加载下拉数据
- (void)loadNewmodels {
    __weak typeof(self)wself = self;
    [[MyVideoListLoader sharedMyListLoader] loadListDataWithChannel:@"1655" FinishBlock:^(BOOL success, NSArray<MyVideoListItem *> * _Nonnull dataArray) {
        if (success) {
            __strong typeof(wself) strongSelf = wself;
            strongSelf.dataArray = [dataArray mutableCopy];
            [strongSelf.collectionView.mj_header endRefreshing];
            [strongSelf.collectionView reloadData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.collectionView.mj_header endRefreshing];
                [wself.collectionView reloadData];
            });
        }
    }];
}

#pragma mark - 加载上拉数据
- (void)loadMoremodels {
    __weak typeof(self)wself = self;
    [[MyVideoListLoader sharedMyListLoader] loadListDataWithChannel:@"1655" FinishBlock:^(BOOL success, NSArray<MyVideoListItem *> * _Nonnull dataArray) {
        if (success) {
            __strong typeof(wself) strongSelf = wself;
            [strongSelf.dataArray addObjectsFromArray:dataArray];
            [strongSelf.collectionView.mj_header endRefreshing];
            [strongSelf.collectionView reloadData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.collectionView.mj_header endRefreshing];
                [wself.collectionView reloadData];
            });
        }
    }];
}

#pragma mark - UICollectionViewFlowLayoutDelegate

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return [collectionView cellForItemAtIndexPath:indexPath].frame.size;
//}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyVideoCoverView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyVideoCoverView" forIndexPath:indexPath];
    if ([cell isKindOfClass:[MyVideoCoverView class]]) {
        MyVideoListItem *item = self.dataArray[indexPath.item];
        [cell layoutWithVideoItem:item];
    }
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"-----------------selected item at row : %ld----------", indexPath.item);
}

#pragma mark - MyFlowLayoutDelegate
/// 返回cell高度
- (CGFloat)cellHeightWithIndexPath:(NSIndexPath *)indexPath {
    MyVideoListItem *item = self.dataArray[indexPath.item];
    return item.videoCellHeight;
}

- (NSInteger)cellCount {
    return self.dataArray.count;
}

#pragma mark - setter
- (void)setChannelInfo:(NSMutableDictionary *)channelInfo {
    if (![channelInfo isKindOfClass:[NSMutableDictionary class]]) {
        _channelInfo = [channelInfo mutableCopy];
    } else {
    _channelInfo = channelInfo;
    }
    // 设置初始页
    [_channelInfo setObject:[NSNumber numberWithInt:1] forKey:@"page"];
    self.title = channelInfo[@"title"];
}

@end
