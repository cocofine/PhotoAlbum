//
//  PHAsset+Helper.m
//  图片选择器
//
//  Created by ouyangqi on 2019/5/13.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import "PHAsset+Helper.h"
#import <objc/runtime.h>

@implementation PHAsset (Helper)


- (UIImage *)thumbimage
{
    return objc_getAssociatedObject(self, @selector(thumbimage));
}

- (void)setThumbimage:(UIImage *)thumbimage
{
    objc_setAssociatedObject(self, @selector(thumbimage), thumbimage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)image
{
    return objc_getAssociatedObject(self, @selector(image));
}

- (void)setImage:(UIImage *)image
{
    objc_setAssociatedObject(self, @selector(image), image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)videoPath
{
    return objc_getAssociatedObject(self, @selector(videoPath));
}

- (void)setVideoPath:(NSURL *)videoPath
{
    objc_setAssociatedObject(self, @selector(videoPath), videoPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cropDuration
{
    return [objc_getAssociatedObject(self, @selector(cropDuration)) floatValue];
}

- (void)setCropDuration:(CGFloat)cropDuration
{
    objc_setAssociatedObject(self, @selector(cropDuration), @(cropDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)downloading
{
    return [objc_getAssociatedObject(self, @selector(downloading)) boolValue];
}

- (void)setDownloading:(BOOL)downloading
{
    objc_setAssociatedObject(self, @selector(downloading), @(downloading), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- getFetchImageType;
{
    
    if ([[UIDevice currentDevice] systemVersion].floatValue>=9.0)
    {
        NSArray *resources = [PHAssetResource assetResourcesForAsset:self];
        if (resources.count>0)
        {
            NSString *UTI = ((PHAssetResource*)resources[0]).uniformTypeIdentifier;
            NSArray * array = [UTI componentsSeparatedByString:@"."];
            return array.lastObject;
        }
        return nil;
        
    }else
    {
        return nil;
    }
    
}

-(BOOL)isGIFImageType
{
    if ([[self getFetchImageType] isEqualToString:@"gif"])
    {
        return YES;
    }else
    {
        return NO;
    }
}

-(BOOL)isHEICImageType
{
    NSString * type = [self getFetchImageType];
    
    if ([type isEqualToString:@"heif"]||[type isEqualToString:@"heic"])
    {
        return YES;
    }else
    {
        return NO;
    }
}

@end
