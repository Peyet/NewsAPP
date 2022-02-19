//
//  MyRecommendPageViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import "MyRecommendPageViewController.h"
#import "MyRecommendPageViewFlowLayout.h"
#import "MyRecommendPageViewCellCollectionViewCell.h"
#import "MyRecommendListItem.h"
#import "MyRecommendListLoader.h"
#import <MJRefresh/MJRefresh.h>

@interface MyRecommendPageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, MyRecommendPageViewFlowLayoutDelegate>

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;

@property (nonatomic, strong, readwrite) NSMutableArray<MyRecommendListItem *> *models;
@end

@implementation MyRecommendPageViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"like@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"like@2x_selected.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
    [self loadData];
    [self setupRefresh];
}

-(void)viewWillAppear:(BOOL)animated {
    [self setupNavigationBar];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyRecommendPageViewCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyRecommendPageViewCellCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyRecommendPageViewCellCollectionViewCell alloc] init];
    }
    if ([cell isKindOfClass:[MyRecommendPageViewCellCollectionViewCell class] ]) {
        [cell layoutCellWithModel:self.models[indexPath.row]];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - MyRecommendPageViewFlowLayoutDelegate
/// 计算cell的大小
/// @param indexPath 将要计算cell的model
- (MyRecommendListItem *)cellImageSizeWithIndexPath:(NSIndexPath *)indexPath InFlowLayout:(MyRecommendPageViewFlowLayout *)myFlowLayout {
    return self.models[indexPath.item];
}
/// 返回cell个数
- (int)cellCountInFlowLayout:(MyRecommendPageViewFlowLayout *)myFlowLayout {
    return (int)self.models.count;
}

/// 记录当前model对应的大小
/// @param indexPath 对应的model
/// @param cellSize 将要设置的cell的大小
/// @param myFlowLayout 计算cell大小的layout
- (void)setCellImageSizeWithIndexPath:(NSIndexPath *)indexPath cellSize:(NSDictionary *)cellSize InFlowLayout:(MyRecommendPageViewFlowLayout *)myFlowLayout {
    MyRecommendListItem *model = self.models[indexPath.item];
    model.cellSize = cellSize;
}

#pragma mark - Life Cycle
/// 初始化collectionView
- (void)setupCollectionView {
    MyRecommendPageViewFlowLayout *pictureFlowLayout = [[MyRecommendPageViewFlowLayout alloc] init];
    pictureFlowLayout.delegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 47 + 44, self.view.frame.size.width, self.view.frame.size.height - 47 - 44) collectionViewLayout:pictureFlowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MyRecommendPageViewCellCollectionViewCell class] forCellWithReuseIdentifier:@"MyRecommendPageViewCellCollectionViewCell"];
    [self.view addSubview:_collectionView];
}

/// 加载数据
- (void)loadData {
    __weak typeof(self)wself = self;
    [[MyRecommendListLoader sharedMyListLoader] loadListDataWithRequstBlock:^NSString * _Nonnull{
        return @"https://api.tuchong.com/feed-app";
    } FinishBlock:^(BOOL success, NSArray<MyRecommendListItem *> * _Nonnull dataArray) {
        if (success) {
            __strong typeof(wself) strongSelf = wself;
            strongSelf.models = [dataArray mutableCopy];
            // 由于一次加载的数据较少，所以手动添加一些数据
            [strongSelf.models addObjectsFromArray:self.models];
            [strongSelf.models addObjectsFromArray:self.models];
            [strongSelf.collectionView reloadData];
//            dispatch_async(dispatch_get_main_queue(), ^{
//            });

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
    [[MyRecommendListLoader sharedMyListLoader] loadListDataWithRequstBlock:^NSString * _Nonnull{
        return @"https://api.tuchong.com/feed-app";
    } FinishBlock:^(BOOL success, NSArray<MyRecommendListItem *> * _Nonnull dataArray) {
        if (success) {
            __strong typeof(wself) strongSelf = wself;
            strongSelf.models = [dataArray mutableCopy];
            [strongSelf.collectionView.mj_header endRefreshing];
            [strongSelf.collectionView reloadData];
//            dispatch_async(dispatch_get_main_queue(), ^{
//            });
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
    [[MyRecommendListLoader sharedMyListLoader] loadListDataWithRequstBlock:^NSString * _Nonnull{
        return @"https://api.tuchong.com/feed-app";
    } FinishBlock:^(BOOL success, NSArray<MyRecommendListItem *> * _Nonnull dataArray) {
        if (success) {
            __strong typeof(wself) strongSelf = wself;
            strongSelf.models = [dataArray mutableCopy];
            [wself.collectionView.mj_footer endRefreshing];
            [wself.collectionView reloadData];
//            dispatch_async(dispatch_get_main_queue(), ^{
//            });
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

/// 设置navigationbar
- (void)setupNavigationBar {
    UIButton *categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryButton setTitle:@"  全部  " forState:UIControlStateNormal];
    [categoryButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    categoryButton.layer.backgroundColor = [UIColor blackColor].CGColor;
    categoryButton.layer.cornerRadius = 17;
    [categoryButton setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *categoryBarButton = [[UIBarButtonItem alloc] initWithCustomView:categoryButton];
    self.tabBarController.navigationItem.leftBarButtonItem = categoryBarButton;
    [self.tabBarController.navigationItem setTitleView:({
        [[UIView alloc] init];
    })];
}

@end
