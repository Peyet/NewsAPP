//
//  ZPJMultiPicNewsCell.m
//  NewsAPP
//
//  Created by PeyetZhao on 2022/2/22.
//

#import "ZPJMultiPicNewsCell.h"
#import "ZPJListItem.h"
#import "ZPJHeader.h"
#import <SDWebImage/SDWebImage.h>

@interface ZPJMultiPicNewsCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewMiddle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRight;


@end

@implementation ZPJMultiPicNewsCell

/// 显示cell内容
- (void)layoutTableViewCellWithItem:(ZPJListItem *)item {
    _titleLabel.text = item.title;
    [_imageViewLeft sd_setImageWithURL:[NSURL URLWithString:item.thumbnail_pic_s] placeholderImage:[UIImage imageNamed:kZPJImagePlaceHolder]];
    [_imageViewMiddle sd_setImageWithURL:[NSURL URLWithString:item.thumbnail_pic_s02] placeholderImage:[UIImage imageNamed:kZPJImagePlaceHolder]];
    [_imageViewRight sd_setImageWithURL:[NSURL URLWithString:item.thumbnail_pic_s03] placeholderImage:[UIImage imageNamed:kZPJImagePlaceHolder]];
}

@end
