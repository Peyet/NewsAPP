//
//  MyNormalTableViewCell.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/1/14.
//

#import "MyNormalTableViewCell.h"

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
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 270, 60)];
//            self.titleLabel.backgroundColor = [UIColor redColor];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel;
        })];
        
        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 20)];
//            self.sourceLabel.backgroundColor = [UIColor redColor];
            self.sourceLabel.textColor = [UIColor grayColor];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel;
        })];

        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 50, 20)];
//            self.commentLabel.backgroundColor = [UIColor redColor];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel;
        })];

        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 80, 50, 20)];
//            self.timeLabel.backgroundColor = [UIColor redColor];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel;
        })];
        
        [self.contentView addSubview:({
            self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(295, 15, 125, 80)];
            self.rightImageView.backgroundColor = [UIColor redColor];
            self.rightImageView;
        })];
        
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
    return self ;
}

- (void)layoutTableViewCell {
    self.titleLabel.text = @"NewsTitle";
    
    self.sourceLabel.text = @"NYTime";
    [self.sourceLabel sizeToFit];

    self.timeLabel.text = @"3min ago";
    self.timeLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15, self.sourceLabel.frame.origin.y, self.timeLabel.frame.origin.y, self.timeLabel.frame.size.height);
    [self.timeLabel sizeToFit];


    self.commentLabel.text = @"22comment";
    self.commentLabel.frame = CGRectMake(self.timeLabel.frame.origin.x + self.timeLabel.frame.size.width + 15, self.timeLabel.frame.origin.y, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.height);
    [self.commentLabel sizeToFit];

    self.rightImageView.image = [UIImage imageNamed:@"aaa.png"];

}

- (void)deleteButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteButton:)]) {
        [self.delegate tableViewCell:self clickDeleteButton:self.deleteButton];
    }
}

@end
