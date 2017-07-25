//
//  SortItemDisplayViewController.h
//  samens
//
//  Created by All time Support on 19/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortItemDisplayViewController : UIViewController
-(void)getSortItemId:(NSString *)str;
-(void)getSortItemName:(NSString *)nameStr;
@property(nonatomic,weak)IBOutlet UICollectionView *sortitemDisplayCollectionView;
@property(nonatomic,weak)IBOutlet UILabel *sortNameLabel;

@end
