//
//  MovieViewCell.m
//  JavaScriptCoreOC
//
//  Created by wangliang on 2017/12/28.
//  Copyright © 2017年 wangliang. All rights reserved.
//

#import "MovieViewCell.h"
#import "Movie.h"
#import <UIImageView+WebCache.h>

@interface MovieViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation MovieViewCell

-(void)setMovie:(Movie *)movie
{
    _movie=movie;
    
    _nameLabel.text=movie.title;
    _priceLabel.text=movie.price;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:movie.imageUrl]];
}

@end
