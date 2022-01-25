//
//  MyVideoViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import "MyVideoViewController.h"
#import "MyVideoCoverView.h"
#import "MyFlowLayout.h"
#import "MyVideoListLoader.h"
#import "MyVideoListItem.h"

@interface MyVideoViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MyFlowLayoutDelegate>

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite) MyFlowLayout *flowLayout;

@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;

@end

@implementation MyVideoViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"video@2x_selected.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.flowLayout = [[MyFlowLayout alloc] init];
    self.flowLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    self.collectionView = collectionView;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[MyVideoCoverView class] forCellWithReuseIdentifier:@"MyVideoCoverView"];
    
    collectionView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1];
    __weak typeof(self)wself = self;
    [[[MyVideoListLoader alloc] init] loadListDataWithFinishBlock:^(BOOL success, NSArray<MyVideoListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.collectionView reloadData];
    }];
    
    [self.view addSubview:collectionView];
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

@end
