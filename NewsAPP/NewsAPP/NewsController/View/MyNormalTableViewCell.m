//
//  MyNormalTableViewCell.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import "MyNormalTableViewCell.h"
#import "MyListItem.h"
#import <SDWebImage.h>

@interface MyNormalTableViewCell ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *sourceLabel;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;
@property (nonatomic, strong, readwrite) UILabel *timeLabel;

@property (nonatomic, strong, readwrite) UIImageView *rightImageView;

@property (nonatomic, strong, readwrite) UIButton *deleteButton;

@end

@implementation MyNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self ;
}

/// 初始化view
- (void)setupView {
    // 新闻标题label
    [self.contentView addSubview:({
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 270, 60)];
//            self.titleLabel.backgroundColor = [UIColor redColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel;
    })];
    
    // 新闻来源label
    [self.contentView addSubview:({
        self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)];
//            self.sourceLabel.backgroundColor = [UIColor redColor];
        self.sourceLabel.textColor = [UIColor grayColor];
        self.sourceLabel.font = [UIFont systemFontOfSize:12];
        self.sourceLabel;
    })];

    // 评论label
    [self.contentView addSubview:({
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 50, 20)];
//            self.commentLabel.backgroundColor = [UIColor redColor];
        self.commentLabel.textColor = [UIColor grayColor];
        self.commentLabel.font = [UIFont systemFontOfSize:12];
        self.commentLabel;
    })];

    // 时间label
    [self.contentView addSubview:({
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 50, 20)];
//            self.timeLabel.backgroundColor = [UIColor redColor];
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel;
    })];
    
    // 图片label
    [self.contentView addSubview:({
        self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(295, 15, 125, 80)];
//            self.rightImageView.backgroundColor = [UIColor redColor];
        self.rightImageView;
    })];
    
    // 删除按钮
    [self.contentView addSubview:({
        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 80, 30, 20)];
        [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
//            self.deleteButton.backgroundColor = [UIColor redColor];
        [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        // 设置按钮样式
        [self.deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.deleteButton.layer.cornerRadius = 10;
        self.deleteButton.layer.masksToBounds = YES;
        self.deleteButton.layer.borderWidth = 2;
        self.deleteButton.layer.borderColor = [UIColor grayColor].CGColor;
        self.deleteButton;
    })];
}

/// cell重新布局
- (void)layoutTableViewCellWithItem:(MyListItem *)item {
    self.titleLabel.text = item.title;
    
    self.sourceLabel.text = item.author_name;
    [self.sourceLabel sizeToFit];

    self.timeLabel.text = item.date;
    self.timeLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15, self.sourceLabel.frame.origin.y, self.timeLabel.frame.origin.y, self.timeLabel.frame.size.height);
    [self.timeLabel sizeToFit];


    self.commentLabel.text = item.category;
    self.commentLabel.frame = CGRectMake(self.timeLabel.frame.origin.x + self.timeLabel.frame.size.width + 15, self.timeLabel.frame.origin.y, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.height);
    [self.commentLabel sizeToFit];
    
    // 已读标记
    BOOL hasRead = [[NSUserDefaults standardUserDefaults] boolForKey:item.uniquekey];
    if (hasRead) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:item.thumbnail_pic_s] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
}

/// 按钮点击事件
- (void)deleteButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteButton:)]) {
        [self.delegate tableViewCell:self clickDeleteButton:self.deleteButton];
    }
}

@end
