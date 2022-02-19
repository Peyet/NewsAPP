//
//  MyDeleteCellView.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/15.
//

#import "MyDeleteCellView.h"

@interface MyDeleteCellView()

@property (nonatomic, strong, readwrite) UIView *backgroundView;
@property (nonatomic, strong, readwrite) UIButton *deleteButton;
@property (nonatomic, copy, readwrite) dispatch_block_t deleteBlock;

@property (nonatomic, strong, readwrite) UIView *deleteReasonView;

@end

@implementation MyDeleteCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
     }
    return self;
}

/// 初始化view
- (void)setupView {
    CGRect frame = [UIApplication sharedApplication].keyWindow.bounds;
    [self addSubview:({
        _backgroundView = [[UIView alloc] initWithFrame:frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha  = 0.5;
        [_backgroundView addGestureRecognizer:({
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)];
            tapGesture;
        })];
        _backgroundView;
    })];

    // 删除原因背景View
    [self addSubview:({
        NSInteger deleteReasonNumber = 3;
        CGFloat deleteReasonItemHeight = 80;
        UIEdgeInsets deleteEdge = {(frame.size.height - deleteReasonNumber * deleteReasonItemHeight) / 2, 10, (frame.size.height - deleteReasonNumber * deleteReasonItemHeight) / 2, 10};
        
        _deleteReasonView = [[UIView alloc] initWithFrame:CGRectMake(deleteEdge.left, deleteEdge.top, frame.size.width - deleteEdge.left - deleteEdge.right, 240)];
        _deleteReasonView.backgroundColor = [UIColor whiteColor];
        _deleteReasonView.layer.cornerRadius = 20;
        _deleteReasonView.layer.masksToBounds = YES;
        [_deleteReasonView addGestureRecognizer:({
                        UITapGestureRecognizer *removeView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_clickButton)];
            removeView;
        })];
        _deleteReasonView;
    })];
    
    [self _creatDeleteReasonContentWithFrame:CGRectMake(0, 0, self.deleteReasonView.frame.size.width, 80) Image:@"不感兴趣.png" Content:@"不感兴趣" havesplitLine:YES];
    
    [self _creatDeleteReasonContentWithFrame:CGRectMake(0, 81, self.deleteReasonView.frame.size.width, 80) Image:@"屏蔽.png" Content:@"屏蔽来源" havesplitLine:YES];
    
    [self _creatDeleteReasonContentWithFrame:CGRectMake(0, 160, self.deleteReasonView.frame.size.width, 80) Image:@"举报.png" Content:@"举报内容" havesplitLine:YES];

    self.clipsToBounds = YES;
}

/// 创建屏蔽原因
/// @param frame 创建的位置
/// @param imageName 屏蔽图标
/// @param content 屏蔽原因
/// @param haveSplitLine 是否有分割线
- (void)_creatDeleteReasonContentWithFrame:(CGRect)frame Image:(NSString *)imageName Content:(NSString *)content havesplitLine:(BOOL)haveSplitLine{
    // 标题字体大小
    UIFont *titleFontSize = [UIFont systemFontOfSize:24];
    CGFloat rowX = frame.origin.x, rowY = frame.origin.y, rowWidth = frame.size.width, rowHeight = frame.size.height;
    UIEdgeInsets rowEdgeInset = UIEdgeInsetsMake(30, 30, 0, 30);
    CGFloat labelMargin = 20;
    
    // 图标
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(rowX +rowEdgeInset.left, rowY +((rowHeight - 30) / 2), 30, 30)];
        iconImageView.image  = [UIImage imageNamed:imageName];
    [self.deleteReasonView addSubview:iconImageView];
    
    // 不感兴趣Label
    UILabel *notInterestedLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.frame.origin.x + iconImageView.frame.size.width + labelMargin, iconImageView.frame.origin.y, rowWidth, 30)];
    notInterestedLabel.text = content;
    notInterestedLabel.font = titleFontSize;
    [self.deleteReasonView addSubview:notInterestedLabel];
    
    // 分割线
    if (haveSplitLine) {
        UIView *splitLine = [[UIView alloc] initWithFrame:CGRectMake(rowEdgeInset.left, rowY + rowHeight - 1, rowWidth - rowEdgeInset.left - rowEdgeInset.right, 1)];
        splitLine.backgroundColor = [UIColor lightGrayColor];
        [self.deleteReasonView addSubview:splitLine];
    }
}

/// 显示删除的原因
/// @param point 点击删除按钮的位置
/// @param clickBlock 回调
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock {

    _deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    _deleteBlock = [clickBlock copy];
    self.deleteReasonView.frame = CGRectMake(point.x, point.y, 0, 0);
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         self.deleteButton.frame = CGRectMake((self.bounds.size.width - 100) / 2, (self.bounds.size.height - 50) / 2, 100, 50);
        NSInteger deleteReasonNumber = 3;
        CGFloat deleteReasonItemHeight = 80;
        UIEdgeInsets deleteEdge = {(self.frame.size.height - deleteReasonNumber * deleteReasonItemHeight) / 2, 10, (self.frame.size.height - deleteReasonNumber * deleteReasonItemHeight) / 2, 10};
        self.deleteReasonView.frame = CGRectMake(deleteEdge.left, deleteEdge.top, self.frame.size.width - deleteEdge.left - deleteEdge.right, 240);
     } completion:^(BOOL finished) {
         //动画结束
     }];
}

/// 关闭删除原因界面
- (void)dismissDeleteView {
    [self removeFromSuperview];
}

/// 点击删除按钮
- (void)_clickButton {
    if (_deleteBlock) {
        _deleteBlock();
    }
    [self removeFromSuperview];
}

@end
