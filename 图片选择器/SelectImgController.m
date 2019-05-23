//
//  SelectImgController.m
//  图片选择器
//
//  Created by ouyangqi on 2019/5/9.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import "SelectImgController.h"
#import "SelectImgCell.h"
#import "PhotoTool.h"
#import "PHAsset+Helper.h"

#define kWindowWidth        [UIScreen mainScreen].bounds.size.width
#define kWindowHeight       [UIScreen mainScreen].bounds.size.height

@interface SelectImgController () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UIButton *titleBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@property (nonatomic, strong) NSMutableArray *ambleArray;

@end

@implementation SelectImgController

- (void)viewDidLoad {
    [super viewDidLoad];

    //获取权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status)
     {
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            switch (status)
                            {
                                case PHAuthorizationStatusNotDetermined:
                                {
                                    break;
                                }
                                case PHAuthorizationStatusAuthorized:
                                {
                                    [self.ambleArray addObjectsFromArray:[[PhotoTool sharePhotoTool] getAblumList]];
                                    PhotoAblum *ablum  = [self.ambleArray firstObject];
                                    [self.titleBtn setTitle:ablum.title forState:UIControlStateNormal];
                                    NSArray *arr = [[PhotoTool sharePhotoTool] enumerateAblumInAssetCollection:ablum.assetCollection];
                                    [self.dataArray addObjectsFromArray:arr];

                                    break;
                                }
                                case PHAuthorizationStatusDenied:
                                case PHAuthorizationStatusRestricted:
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请在「设置-隐私-照片」中\n允许 xx 访问照片" delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"好", nil];
                                    [alert show];
                                    break;
                                }
                            }
                        });
     }];

    [self.collectionView registerClass:[SelectImgCell class] forCellWithReuseIdentifier:@"cell_id"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    
    self.tableViewHeight.constant = 0;
}

#pragma mark- collectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = self.dataArray[indexPath.row];
    SelectImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    cell.asset = asset;
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kWindowWidth-3)/4.0, (kWindowWidth-3)/4.0);
}

#pragma mark- tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ambleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoAblum *ablum = self.ambleArray[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    cell.textLabel.text = ablum.title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoAblum *ablum = self.ambleArray[indexPath.row];
    
    [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:[[PhotoTool sharePhotoTool] enumerateAblumInAssetCollection:ablum.assetCollection]];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableViewHeight.constant = 0;
        [self.view layoutIfNeeded];
    }];
    
    [self.titleBtn setTitle:ablum.title forState:UIControlStateNormal];
    
    [self.collectionView reloadData];
}


- (IBAction)titleAction:(UIButton *)sender
{
    if (self.tableViewHeight.constant == 0)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.tableViewHeight.constant = kWindowHeight - 64;
            [self.view layoutIfNeeded];
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.tableViewHeight.constant = 0;
            [self.view layoutIfNeeded];
        }];
    }
    
    
}



#pragma mark -Getter

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)ambleArray
{
    if (!_ambleArray) {
        _ambleArray = [NSMutableArray array];
    }
    return _ambleArray;
}

@end
