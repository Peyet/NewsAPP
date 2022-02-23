//
//  ZPJRecommendVC.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import "ZPJRecommendVC.h"
#import "ZPJRecommendLayout.h"
#import "ZPJRecommendCell.h"
#import "MyRecommendListItem.h"
#import "MyRecommendListLoader.h"
#import <MJRefresh/MJRefresh.h>
#import "ZPJHeader.h"
#import "ZPJRecommendDetailView.h"

@interface ZPJRecommendVC ()<UICollectionViewDataSource, UICollectionViewDelegate, ZPJRecommendLayoutDelegate, ZPJRecommendDetailViewDelegate>

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;

@property (nonatomic, strong, readwrite) NSMutableArray<MyRecommendListItem *> *models;
@end

@implementation ZPJRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self loadData];
    [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZPJRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kZPJCellReuseIdentifierRecommendCell forIndexPath:indexPath];
    if ([cell isKindOfClass:[ZPJRecommendCell class] ]) {
        [cell layoutCellWithModel:self.models[indexPath.row]];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyRecommendListItem *model = self.models[indexPath.item];
    ZPJRecommendDetailView *detailView = [[ZPJRecommendDetailView alloc] init];
    [detailView showImageDetailWithModel:model];
    detailView.delegate = self;
    [self.view addSubview:detailView];
    [self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - MyRecommendPageViewFlowLayoutDelegate
/// 计算cell的大小
/// @param indexPath 将要计算cell的model
- (MyRecommendListItem *)cellImageSizeWithIndexPath:(NSIndexPath *)indexPath InFlowLayout:(ZPJRecommendLayout *)myFlowLayout {
    return self.models[indexPath.item];
}
/// 返回cell个数
- (int)cellCountInFlowLayout:(ZPJRecommendLayout *)myFlowLayout {
    return (int)self.models.count;
}

/// 记录当前model对应的大小
/// @param indexPath 对应的model
/// @param cellSize 将要设置的cell的大小
/// @param myFlowLayout 计算cell大小的layout
- (void)setCellImageSizeWithIndexPath:(NSIndexPath *)indexPath cellSize:(NSDictionary *)cellSize InFlowLayout:(ZPJRecommendLayout *)myFlowLayout {
    MyRecommendListItem *model = self.models[indexPath.item];
    model.cellSize = cellSize;
}
#pragma mark - ZPJRecommendDetailViewDelegate
/// 恢复tabbar，不再隐藏
- (void)showTabBar {
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - Life Cycle
/// 初始化collectionView
- (void)setupCollectionView {
    ZPJRecommendLayout *pictureFlowLayout = [[ZPJRecommendLayout alloc] init];
    pictureFlowLayout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 47 + 44, self.view.frame.size.width, self.view.frame.size.height - 47 - 44) collectionViewLayout:pictureFlowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[ZPJRecommendCell class] forCellWithReuseIdentifier:kZPJCellReuseIdentifierRecommendCell];
    [self.view addSubview:_collectionView];
    //分类按钮
    UIView *authorInfoBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kZPJScreenWidth, kZPJScreenStatusBarHeight + kZPJScreenNavigationBarHeight)];
    authorInfoBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:authorInfoBackgroundView];
    UIButton *categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryButton setTitle:@"  全部  " forState:UIControlStateNormal];
    [categoryButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    categoryButton.layer.backgroundColor = [UIColor blackColor].CGColor;
    categoryButton.layer.cornerRadius = 17;
    [categoryButton setTintColor:[UIColor whiteColor]];
    categoryButton.frame = CGRectMake(20, kZPJScreenStatusBarHeight, 65, 35);
    [authorInfoBackgroundView addSubview:categoryButton];


}

/// 加载数据
- (void)loadData {
    __weak typeof(self)wself = self;
    [[MyRecommendListLoader sharedMyListLoader] loadListDataWithChannelInfo:nil FinishBlock:^(BOOL success, NSArray<MyRecommendListItem *> * _Nonnull dataArray) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(wself) strongSelf = wself;
                strongSelf.models = [dataArray mutableCopy];
                // 由于一次加载的数据较少，所以手动添加一些数据
                [strongSelf.models addObjectsFromArray:self.models];
                [strongSelf.models addObjectsFromArray:self.models];
                [strongSelf.collectionView reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.collectionView reloadData];
            });
        }
    }];
}

/// 创建上下拉刷新
- (void)setupRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewmodels)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoremodels)];
}

/// 加载下拉数据
- (void)loadNewmodels {
    __weak typeof(self)wself = self;
    [[MyRecommendListLoader sharedMyListLoader] loadListDataWithChannelInfo:nil FinishBlock:^(BOOL success, NSArray<MyRecommendListItem *> * _Nonnull dataArray) {
        if (success) {
            [wself.collectionView.mj_header endRefreshing];
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(wself) strongSelf = wself;
                strongSelf.models = [dataArray mutableCopy];
                [wself.collectionView reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.collectionView.mj_header endRefreshing];
                [wself.collectionView reloadData];
            });
        }
    }];
}

/// 加载上拉数据
- (void)loadMoremodels {
    __weak typeof(self)wself = self;
    [[MyRecommendListLoader sharedMyListLoader] loadListDataWithChannelInfo:nil FinishBlock:^(BOOL success, NSArray<MyRecommendListItem *> * _Nonnull dataArray) {
        if (success) {
            [wself.collectionView.mj_footer endRefreshing];
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(wself) strongSelf = wself;
                strongSelf.models = [dataArray arrayByAddingObjectsFromArray:dataArray.mutableCopy];
                [wself.collectionView reloadData];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.collectionView.mj_footer endRefreshing];
                [wself.collectionView reloadData];
            });
        }
    }];
}

/// 懒加载
- (NSMutableArray<MyRecommendListItem *> *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
