//
//  SelectImgCell.h
//  图片选择器
//
//  Created by ouyangqi on 2019/5/9.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectImgCell : UICollectionViewCell

@property (nonatomic, strong) PHAsset *asset;

@end

NS_ASSUME_NONNULL_END
