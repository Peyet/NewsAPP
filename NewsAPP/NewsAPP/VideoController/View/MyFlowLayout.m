//
//  MyFlowLayout.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/20.
//

#import "MyFlowLayout.h"

@interface MyFlowLayout()

@property (nonatomic, strong, readwrite) NSMutableArray<UICollectionViewLayoutAttributes *> *attrisArray;
@property (nonatomic, assign) CGFloat columnHeight;

@end

@implementation MyFlowLayout

#pragma mark - 默认参数
static const CGFloat DefaultRowMargin = 10;
static const UIEdgeInsets DefaultUIEdgeInsets = {10, 8, 10, 8};

#pragma mark -  布局计算
/// 初始化布局
- (void)prepareLayout {
    [super prepareLayout];
    
    self.columnHeight = 0;
    if ([self.delegate respondsToSelector:@selector(cellCount)]) {
        for (NSInteger i = 0; i < [self.delegate cellCount]; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrisArray addObject:attribute];
        }
    }
}

/// 特定cell的布局
/// @param indexPath cell的位置
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 计算cell的frame
    CGFloat cellX = 0, cellY = 0, cellWidth = 0, cellHeight = 0;
    cellX = DefaultUIEdgeInsets.left;
    if (!indexPath.item) {
        cellY += DefaultUIEdgeInsets.top;
    } else {
        cellY = self.columnHeight + DefaultRowMargin;
    }
    cellWidth = self.collectionView.frame.size.width - DefaultUIEdgeInsets.left - DefaultUIEdgeInsets.right;
    if ([self.delegate respondsToSelector:@selector(cellHeightWithIndexPath:)]) {
        cellHeight = [self.delegate cellHeightWithIndexPath:indexPath];
    }
    // 保存列表的高度
    self.columnHeight += cellHeight + DefaultRowMargin;
    attribute.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
    return attribute;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrisArray;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.columnHeight);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

#pragma mark - 懒加载
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attrisArray {
    if (!_attrisArray) {
        _attrisArray = [NSMutableArray new];
    }
    return _attrisArray;
}

@end
