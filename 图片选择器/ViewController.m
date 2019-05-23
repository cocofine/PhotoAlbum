//
//  ViewController.m
//  图片选择器
//
//  Created by ouyangqi on 2019/4/28.
//  Copyright © 2019 ouyangqi. All rights reserved.
//

#import "ViewController.h"
#import "SelectImgController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    


}

- (IBAction)btnAction:(id)sender
{
    SelectImgController *vc = [[SelectImgController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}









@end
