//
//  ItemsDisplayViewController.h
//  samens
//
//  Created by All time Support on 10/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
#import "homeViewController.h"
#import "LoginDetailsModel.h"
#import "SubCategoryModel.h"
#import "CatProductModel.h"
#import "IndivisualFilterModel.h"
#import "FetchFilterSizeItemModel.h"
#import "SortModel.h"

@interface ItemsDisplayViewController : UIViewController
@property(nonatomic,weak)IBOutlet UICollectionView *DisplayItemsCollectionView;
-(void)getId:(NSString *)CategoryId;
-(void)getName:(NSString *)CategoryName;
-(void)getPopUpName:(NSString *)popUpName;
@property(nonatomic,weak)IBOutlet UITableView *sortTableView;
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)NSMutableArray *subCatMainData;
@property(nonatomic,strong)NSMutableArray *subimageMainData;
@property(nonatomic,weak)IBOutlet UIView *sortPopUpView;
-(void)getSortId:(NSString *)SortItemId;
@property(nonatomic,weak)IBOutlet UILabel *popUpTextLabel;
-(void)getPrice:(NSString *)price;
-(void)getPid:(NSString *)Pid;


-(IBAction)ClickOnFilter1:(id)sender;

@property(nonatomic,strong)NSMutableArray *loginDetailsArray;
@property(nonatomic,strong)LoginDetailsModel *loginModel;
@property(nonatomic,strong)SubCategoryModel *subModel;

@property(nonatomic,strong)CategoryModel *CatModel;
@property(nonatomic,strong) NSString *categoryMainId;
@property(nonatomic,strong)NSString *colorCode;
@property(nonatomic,strong)NSString *ColorCode1;
@property(nonatomic,strong)NSString *size;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)IndivisualFilterModel *indivisualFilterModel;
@property(nonatomic,strong)NSArray *sizeIndexArray;
@property(nonatomic,strong)NSArray *priceIndexArray;

@property(nonatomic,strong)FetchFilterSizeItemModel *fetchFilterSizeModel;
@property(nonatomic,strong)SortModel *sortModel;
@property(nonatomic,strong) NSString *categoryMainName;
@property(nonatomic,strong)NSString *searchName;
@property(nonatomic,strong)NSArray *dammyArray;
@property(nonatomic,strong)    NSString *PopUpNameText;
@property(nonatomic,weak)IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong) NSString *MainSortItemId;



@end
