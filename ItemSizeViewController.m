//
//  ItemSizeViewController.m
//  samens
//
//  Created by All time Support on 20/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "ItemSizeViewController.h"
#import "SizeModel.h"
#import "itemSizeCollectionViewCell.h"

@interface ItemSizeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSString *ProductId;

}

@end

@implementation ItemSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getSizeData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)GetProductid:(NSString *)productid{
    ProductId = productid;
}
-(void)getSizeData{
    [self GetProductid:ProductId];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
