//
//  AllReviewsViewController.h
//  samens
//
//  Created by All time Support on 30/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewFetchModel.h"

@interface AllReviewsViewController : UIViewController
@property(nonatomic,strong)ReviewFetchModel *ReviewModel;
@property(nonatomic,strong)NSMutableArray *ReviewsMainArray;
@property(nonatomic,weak)IBOutlet UITableView *allReviewsTableView;

@end
