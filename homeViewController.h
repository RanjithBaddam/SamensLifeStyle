//
//  homeViewController.h
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDetailsModel.h"
#import "CatProductModel.h"
#import "CategoryModel.h"

@interface homeViewController : UIViewController <UITabBarDelegate,UITabBarControllerDelegate>
@property(nonatomic,weak)IBOutlet UIScrollView *scrollView;
@property(nonatomic,weak)IBOutlet UICollectionView *collectionView;
@property(nonatomic,weak)IBOutlet UICollectionView *pageCollectionView;
@property(nonatomic,weak)IBOutlet UITableView *catogorysTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *catogorysTblHeight;
@property(nonatomic,strong)NSMutableArray *mainArray;
@property(nonatomic,strong)NSMutableArray *productMainArray;
-(void)getCategoryId:(NSString *)categoryId;

@property(nonatomic,strong)NSMutableArray *loginDetailsArray;
@property(nonatomic,strong)LoginDetailsModel *loginModel;
@property(nonatomic,strong)CatProductModel *Catmodel;


@end
