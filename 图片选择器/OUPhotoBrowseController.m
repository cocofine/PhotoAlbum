//
//  OUPhotoBrowseController.m
//  图片选择器
//
//  Created by ouyangqi on 2019/5/24.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import "OUPhotoBrowseController.h"
#import <Photos/Photos.h>
#import "OUPhotoBrowseCell.h"

#define kWindowWidth        [UIScreen mainScreen].bounds.size.width
#define kWindowHeight       [UIScreen mainScreen].bounds.size.height

@interface OUPhotoBrowseController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation OUPhotoBrowseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionView registerClass:[OUPhotoBrowseCell class] forCellWithReuseIdentifier:@"cells_id"];
    self.collectionView.pagingEnabled = YES;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OUPhotoBrowseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cells_id" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
//    cell.img = 
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kWindowWidth + 50, kWindowHeight);
}



#pragma mark -Getter

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.pagingEnabled = YES;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


@end
