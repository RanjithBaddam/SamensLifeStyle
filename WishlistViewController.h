//
//  WishlistViewController.h
//  samens
//
//  Created by All time Support on 04/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDetailsModel.h"
#import "SubCategoryModel.h"

@interface WishlistViewController : UIViewController
@property(nonatomic,strong)LoginDetailsModel *loginModel;
@property(nonatomic,weak)IBOutlet UITableView *wishlistTableView;
@property(nonatomic,strong)SubCategoryModel *subModel;
@end
