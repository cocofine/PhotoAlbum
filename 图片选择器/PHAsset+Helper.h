//
//  PHAsset+Helper.h
//  图片选择器
//
//  Created by ouyangqi on 2019/5/13.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (Helper)

@property (nonatomic, strong) UIImage *thumbimage;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSURL *videoPath;//视频地址
@property (nonatomic, assign) CGFloat cropDuration;//裁剪后的视频时长;
@property (nonatomic, assign) BOOL downloading;//视频是否在下载;

-(NSString *)getFetchImageType;

///是否为GIF
-(BOOL)isGIFImageType;

///是否为HEIC
-(BOOL)isHEICImageType;

@end

NS_ASSUME_NONNULL_END
