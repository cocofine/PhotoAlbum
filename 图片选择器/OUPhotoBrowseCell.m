//
//  OUPhotoBrowseCell.m
//  图片选择器
//
//  Created by ouyangqi on 2019/5/24.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import "OUPhotoBrowseCell.h"

@interface OUPhotoBrowseCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation OUPhotoBrowseCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imgView.hidden = NO;
    }
    return self;
}

-(void)setImg:(UIImage *)img
{
    _img = img;
    
//    self.imgView.image = img;
    
    
}

-(UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _imgView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_imgView];
    }
    return _imgView;
}

@end
