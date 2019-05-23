//
//  SelectImgCell.m
//  图片选择器
//
//  Created by ouyangqi on 2019/5/9.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import "SelectImgCell.h"
#import "PHAsset+Helper.h"

@interface SelectImgCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation SelectImgCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imgView];
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setAsset:(PHAsset *)asset
{
    _asset = asset;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    options.networkAccessAllowed = YES;
    
    [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(150, 150) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        asset.thumbimage = result;
        
        if (self.asset == asset) {
            self.imgView.image = asset.thumbimage;
        }
        
    }];
}




@end
