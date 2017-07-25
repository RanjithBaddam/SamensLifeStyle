//
//  SearchBarViewController.h
//  samens
//
//  Created by All time Support on 15/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface SearchBarViewController : UIViewController
@property(nonatomic,weak)IBOutlet UISearchBar *searchBar;
@property(nonatomic,weak)IBOutlet UITableView *searchTableView;
@property(nonatomic,strong)CategoryModel *itemModel;

@end
