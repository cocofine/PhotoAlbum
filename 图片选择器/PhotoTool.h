//
//  PhotoTool.h
//  图片选择器
//
//  Created by ouyangqi on 2019/5/9.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoAblum : NSObject

@property (nonatomic, copy) NSString *title; //相册名字
@property (nonatomic, assign) NSInteger count; //该相册内相片数量
@property (nonatomic, strong) PHAsset *headImageAsset; //相册第一张图片缩略图
@property (nonatomic, strong) PHAssetCollection *assetCollection; //相册集，通过该属性获取该相册集下所有照片

@end

@interface PhotoTool : NSObject

+ (instancetype)sharePhotoTool;

//获取所有的相册
- (NSArray *)getAblumList;

//获取某个相册的图片
- (NSArray<PHAsset *> *)enumerateAblumInAssetCollection:(PHAssetCollection *)assetCollection;

@end

NS_ASSUME_NONNULL_END
