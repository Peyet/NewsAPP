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

@interface MyVideoPageViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MyFlowLayoutDelegate>

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite) MyFlowLayout *flowLayout;

@property (nonatomic, strong, readwrite) NSMutableArray *dataArray;

@end

@implementation MyVideoPageViewController

- (instancetype)initControllerWithChannel:(NSDictionary *)channel Frame:(CGRect)frame {
    self.title = channel[@"title"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.flowLayout = [[MyFlowLayout alloc] init];
    self.flowLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.flowLayout];
    self.collectionView = collectionView;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[MyVideoCoverView class] forCellWithReuseIdentifier:@"MyVideoCoverView"];
    
    collectionView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1];
    __weak typeof(self)wself = self;
    [[[MyVideoListLoader alloc] init] loadListDataWithChannel:channel[@"type"] FinishBlock:^(BOOL success, NSArray<MyVideoListItem *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = [dataArray mutableCopy];
        [strongSelf.collectionView reloadData];
    }];
    
    [self.view addSubview:collectionView];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
