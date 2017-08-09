//
//  FetchFilterViewController.h
//  samens
//
//  Created by All time Support on 24/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "filterItemModel.h"
#import "CategoryModel.h"
#import "IndivisualFilterModel.h"
#import "SortModel.h"
#import "SortDisplayModel.h"

@interface FetchFilterViewController : UIViewController
@property(nonatomic,strong)filterItemModel *filterModel;
@property(nonatomic,strong)CategoryModel *catModel;
@property(nonatomic,weak)IBOutlet UITableView *FilterItemTableview;
@property(nonatomic,strong)IndivisualFilterModel *indivisualFilterModel;
@property(nonatomic,strong)SortModel *sortModel;
@property(nonatomic,strong)NSString *categoryMainId;
@property(nonatomic,strong) NSString *MainSortItemId;
@property(nonatomic,strong)NSString *sort1MainId;
@property(nonatomic,strong)SortDisplayModel *sortDisplayModel;
@end
