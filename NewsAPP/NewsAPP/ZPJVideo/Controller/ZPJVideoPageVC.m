//
//  ZPJVideoPageVC.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/13.
//

#import "ZPJVideoPageVC.h"
#import "ZPJVideoCell.h"
#import "ZPJFlowLayout.h"
#import "ZPJVideoListLoader.h"
#import "ZPJVideoListItem.h"
#import <MJRefresh/MJRefresh.h>
#import "ZPJHeader.h"

@interface ZPJVideoPageVC () <UICollectionViewDelegate, UICollectionViewDataSource, ZPJFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZPJFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong, readwrite) NSDictionary *channelInfo;

@end

@implementation ZPJVideoPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZPJVideoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kZPJCellReuseIdentifierVideoCell forIndexPath:indexPath];
    if ([cell isKindOfClass:[ZPJVideoCell class]]) {
        ZPJVideoListItem *item = self.dataArray[indexPath.item];
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
    ZPJVideoListItem *item = self.dataArray[indexPath.item];
    return item.videoCellHeight;
}

- (NSInteger)cellCount {
    return self.dataArray.count;
}

#pragma mark - Life Cycle
/// 初始化tableView
- (void)setupTableView {
    self.flowLayout = [[ZPJFlowLayout alloc] init];
    self.flowLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    self.collectionView = collectionView;
    CGSize pageSize = CGSizeMake(kZPJScreenWidth, kZPJScreenHeight - kZPJScreenNavigationBarHeight);
    self.view.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);
    self.collectionView.frame = CGRectMake(0, 0, pageSize.width, pageSize.height);

    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[ZPJVideoCell class] forCellWithReuseIdentifier:kZPJCellReuseIdentifierVideoCell];
    [[ZPJVideoListLoader sharedMyListLoader] loadListDataWithChannel:self.channelInfo[kZPJModelKeyVideoChannelType] FinishBlock:^(BOOL success, NSArray<ZPJVideoListItem *> * _Nonnull dataArray) {
        if (success) {
            self.dataArray = [dataArray mutableCopy];
            [self.collectionView reloadData];
        } else {
            self.dataArray = [dataArray mutableCopy];
            [self.collectionView reloadData];
        }
    }];
    collectionView.backgroundColor = kZPJ_COLOR_VIDEOPAGE;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    [self setupRefresh];

}

/// 创建上下拉刷新
- (void)setupRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewmodels)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoremodels)];
}

/// 加载下拉数据
- (void)loadNewmodels {
    [[ZPJVideoListLoader sharedMyListLoader] loadListDataWithChannel:@"1655" FinishBlock:^(BOOL success, NSArray<ZPJVideoListItem *> * _Nonnull dataArray) {
        if (success) {
            self.dataArray = [dataArray mutableCopy];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
            });
        }
    }];
}

/// 加载上拉数据
- (void)loadMoremodels {
    [[ZPJVideoListLoader sharedMyListLoader] loadListDataWithChannel:@"1655" FinishBlock:^(BOOL success, NSArray<ZPJVideoListItem *> * _Nonnull dataArray) {
        if (success) {
            [self.dataArray addObjectsFromArray:dataArray];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView reloadData];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];
            });
        }
    }];
}

- (void)setPageChannleInfo:(NSDictionary *)channelInfo {
    self.channelInfo = channelInfo;
    self.title = channelInfo[kZPJModelKeyVideoChannelTitle];

}

@end
