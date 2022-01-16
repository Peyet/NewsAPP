//
//  MyVideoViewController.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import "MyVideoViewController.h"
#import "MyVideoCoverView.h"

@interface MyVideoViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

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
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 16, (self.view.bounds.size.width - 16) * 9 / 16);
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:[MyVideoCoverView class] forCellWithReuseIdentifier:@"MyVideoCoverView"];
    
    [self.view addSubview:collectionView];
}

#pragma mark - UICollectionViewFlowLayoutDelegate

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.item % 3 == 0) {
//        return CGSizeMake(self.view.bounds.size.width, 100);
//    } else {
//        return CGSizeMake((self.view.bounds.size.width - 10) / 2, 300);
//    }
//}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyVideoCoverView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyVideoCoverView" forIndexPath:indexPath];
    if ([cell isKindOfClass:[MyVideoCoverView class]]) {
        [cell layoutWithVideoCoverUrl:@"placeholder_image.png" videoUrl:@"http://ali.cdn.kaiyanapp.com/03ffffeec373a3e8e3aab6863deff1d6_1280x720_854x480.mp4?auth_key=1642348484-0-0-7329003e61ef878a2ea3be998a184ce3"];
    }
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}


@end
