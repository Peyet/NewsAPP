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

@end

@implementation MyNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 300, 50)];
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

    }
    return self ;
}

- (void)layoutTableViewCell {
    self.titleLabel.text = @"NewsTitle";
    

    self.sourceLabel.text = @"NYTime";
    [self.sourceLabel sizeToFit];

    self.timeLabel.text = @"3min ago";
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + 15, self.sourceLabel.frame.origin.y, self.timeLabel.frame.origin.y, self.timeLabel.frame.size.height);


    self.commentLabel.text = @"22comment";
    [self.commentLabel sizeToFit];
    self.commentLabel.frame = CGRectMake(self.timeLabel.frame.origin.x + self.timeLabel.frame.size.width + 15, self.timeLabel.frame.origin.y, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.height);


}

@end
