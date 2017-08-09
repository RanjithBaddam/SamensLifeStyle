//
//  SortItemDisplayViewController.h
//  samens
//
//  Created by All time Support on 19/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortModel.h"
#import "CategoryModel.h"
#import "SortDisplayModel.h"

@interface SortItemDisplayViewController : UIViewController
//-(void)getSortItemId:(NSString *)str;
-(void)getSortItemName:(NSString *)nameStr;
@property(nonatomic,weak)IBOutlet UICollectionView *sortitemDisplayCollectionView;
-(IBAction)clickOnSort:(id)sender;
-(IBAction)clickOnFilter:(id)sender;
@property(nonatomic,strong)SortModel *sortModel;
@property(nonatomic,weak)IBOutlet UIView *SortpopupView;
@property(nonatomic,weak)IBOutlet UILabel *popupTextLabel;
@property(nonatomic,weak)IBOutlet UITableView *sortTableView;
-(IBAction)ClickOnSortPopUpClose:(id)sender;
@property(nonatomic,strong) NSString *categoryMainId;
@property(nonatomic,strong)NSString *PopUpNameText;
@property(nonatomic,weak)IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong)NSString *ColorCode1;

@property(nonatomic,strong)NSArray *sizeIndexArray;
@property(nonatomic,strong)NSArray *priceIndexArray;
@property(nonatomic,strong)CategoryModel *catModel;
@property(nonatomic,strong)NSString *MainSortItemId;
@property(nonatomic,strong)NSString *sort1MainId;
@property(nonatomic,strong)SortDisplayModel *sortDisplayModel;

@end
