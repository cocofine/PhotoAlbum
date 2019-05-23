//
//  PhotoTool.m
//  图片选择器
//
//  Created by ouyangqi on 2019/5/9.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import "PhotoTool.h"
#import "PHAsset+Helper.h"

@implementation PhotoAblum

@end

@interface PhotoTool ()

@property (nonatomic, assign) PHImageRequestID requestID;

@end

@implementation PhotoTool

static PhotoTool *sharePhotoTool = nil;
+ (instancetype)sharePhotoTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharePhotoTool = [[self alloc] init];
    });
    return sharePhotoTool;
}


- (NSArray *)getAblumList
{
    NSMutableArray *photoAblumList = [NSMutableArray array];
    
    //     获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:cameraRoll options:nil];
    if (assets.count > 0)
    {
        PhotoAblum *ablum = [[PhotoAblum alloc] init];
        ablum.title = cameraRoll.localizedTitle;
        ablum.count = assets.count;
        ablum.headImageAsset = assets.firstObject;
        ablum.assetCollection = cameraRoll;
        [photoAblumList addObject:ablum];
    }

    //智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in smartAlbums)
    {
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        if (assets.count > 0 && assetCollection.assetCollectionSubtype < 212)
        {
            NSLog(@"%@",assetCollection.localizedTitle);
            PhotoAblum *ablum = [[PhotoAblum alloc] init];
            ablum.title = assetCollection.localizedTitle;
            ablum.count = assets.count;
            ablum.headImageAsset = assets.firstObject;
            ablum.assetCollection = assetCollection;
            [photoAblumList addObject:ablum];
        }
    }
    
    
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    for (PHAssetCollection *assetCollection in assetCollections)
    {
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
        if (assets.count > 0)
        {
            NSLog(@"%@",assetCollection.localizedTitle);
            PhotoAblum *ablum = [[PhotoAblum alloc] init];
            ablum.title = assetCollection.localizedTitle;
            ablum.count = assets.count;
            ablum.headImageAsset = assets.firstObject;
            ablum.assetCollection = assetCollection;
            [photoAblumList addObject:ablum];
        }
    }
    
    
    return photoAblumList;
}


//获取某个相册的全部图片
- (NSArray<PHAsset *> *)enumerateAblumInAssetCollection:(PHAssetCollection *)assetCollection
{
    NSMutableArray<PHAsset *> *array = [NSMutableArray array];
    

    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (NSInteger i = assets.count-1; i >= 0; i--) {
        PHAsset *asset = assets[i];
        [array addObject:asset];
    }
    
    return array;
}

//- (void)requestImageAndDataForAsset:(PHAsset *)asset completion:(void (^)(UIImage *image,NSData *imageData, NSDictionary *info))completion
//{
////    self.icloudView.backgroundColor = [UIColor clearColor];
//
//    [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info)
//     {
//         NSLog(@"%@",info);
//         if ([[info objectForKey:PHImageResultIsInCloudKey] integerValue] == 1)
//         {
////             MJWeakSelf;
////             self.icloudView.block = ^{
////                 [[PHCachingImageManager defaultManager] cancelImageRequest:weakSelf.requestID];
////             };
//
//             PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
//             option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;//控制照片质量
//             option.networkAccessAllowed = YES;
//             option.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
//                 NSLog(@"%f",progress);
////                 self.icloudView.progressValue = progress;
//             };
//
//             self.requestID = [[PHCachingImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info)
//               {
//                   [self imageCompleteForAsset:asset imageData:imageData info:info orientation:orientation completion:completion];
//               }];
//         }
//         else
//         {
//             [self imageCompleteForAsset:asset imageData:imageData info:info orientation:orientation completion:completion];
//         }
//     }];
//}
//
//- (void)imageCompleteForAsset:(PHAsset *)asset imageData:(NSData *)imageData info:(NSDictionary *)info orientation:(UIImageOrientation) orientation completion:(void (^)(UIImage *image,NSData *imageData, NSDictionary *info))completion
//{
//    BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey];
//
//    if (downloadFinined && completion)
//    {
//        UIImage *image = [UIImage imageWithData:imageData];
////        image.imageData = [asset isHEICImageType] ? UIImageJPEGRepresentation(image, 1) : imageData;
////        switch (orientation)
////        {
////            case UIImageOrientationUp:
////            {
////                image.rotationAngle = 0;
////                break;
////            }
////            case UIImageOrientationDown:
////            {
////                image.rotationAngle = 180;
////                break;
////            }
////            case UIImageOrientationLeft:
////            {
////                image.rotationAngle = -90;
////                break;
////            }
////            case UIImageOrientationRight:
////            {
////                image.rotationAngle = 90;
////                break;
////            }
////            default:
////                break;
////        }
//        completion(image,imageData,info);
//    }
//}



@end
