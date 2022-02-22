//
//  MyRecommendPageViewFlowLayout.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/19.
//

#import "ZPJRecommendLayout.h"
#import "MyRecommendListItem.h"
#import "NSString+LabelSizeCalculator.h"
#import "ZPJHeader.h"

@interface ZPJRecommendLayout()

@property (nonatomic, strong, readwrite) NSMutableArray<UICollectionViewLayoutAttributes *> *attrisArray;
@property (nonatomic, strong, readwrite) NSMutableArray<NSNumber *> *columnHeights;

@end

@implementation ZPJRecommendLayout

#pragma mark - 默认参数
static const int kDefaultItemCount = 20;                           ///< 默认models个数
static const CGFloat kDefaultColumnCount = 2;                           ///< 默认列数
static const CGFloat kDefaultColumnMargin = 10;                         ///< 默认列边距
static const CGFloat kDefaultRowMargin = 10;                            ///< 默认行边距
static const UIEdgeInsets kDefaultUIEdgeInsets = {10, 10, 10, 10};      ///< 默认collectionView边距
static const CGFloat kDefaultCellHeight = 100;
static const CGFloat kDefaultCellWidth = 100;

#pragma mark - 布局计算
- (void)prepareLayout {
    [super prepareLayout];
    // 第一行计算，每一列的基础高度加上collection的边框的top值
    for (NSInteger i = 0; i < kDefaultColumnCount; i++) {
        self.columnHeights[i] = @(kDefaultUIEdgeInsets.top);
    }
    // 遍历所有的cell，计算所有cell的布局
    int itemCount = kDefaultItemCount;
    if ([self.delegate respondsToSelector:@selector(cellCountInFlowLayout:)]) {
        itemCount = [self.delegate cellCountInFlowLayout:self];
    }
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        // 计算布局属性并将结果添加到布局属性数组中
        [self.attrisArray addObject:attribute];
    }
}

/// 特定cell的布局
/// @param indexPath cell的位置
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

/// 返回布局属性，一个UICollectionViewLayoutAttributes对象数组
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrisArray;
}

//
/// 返回collectionView的ContentSize
- (CGSize)collectionViewContentSize {
    // collectionView的contentSize的高度等于所有列高度中最大的值
    CGFloat maxColumnHeight = [self.columnHeights[0] floatValue];
    for (NSInteger i = 1; i < kDefaultColumnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] floatValue];
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, maxColumnHeight + kDefaultUIEdgeInsets.bottom);
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

- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
        for (NSInteger i = 0; i < kDefaultColumnCount; i++) {
            // 初始化每列的高度为屏幕边缘的高度
            [_columnHeights addObject:@(kDefaultUIEdgeInsets.top)];
        }
    }
    return _columnHeights;
}

@end
