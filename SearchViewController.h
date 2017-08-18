//
//  SearchViewController.h
//  samens
//
//  Created by All time Support on 28/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
#import "CatProductModel.h"
@interface SearchViewController : UIViewController
@property(nonatomic,weak)IBOutlet UISearchBar *searchBar;
@property(nonatomic,weak)IBOutlet UITableView *searchTableView;
@property(nonatomic,strong)CategoryModel *catModel;
@property(nonatomic,strong)NSString *categoryMainId;
@end
