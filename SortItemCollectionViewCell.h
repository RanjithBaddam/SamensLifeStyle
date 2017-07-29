//
//  SortItemCollectionViewCell.h
//  samens
//
//  Created by All time Support on 19/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortItemCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView *sortItemDisplayImageView;
@property(nonatomic,weak)IBOutlet UILabel *DisplayItemTextLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceOffLabel;
@property(nonatomic,weak)IBOutlet UILabel *StarRatingLabel;
@property(nonatomic,weak)IBOutlet UIButton *WishListButton;
@property(nonatomic,weak)IBOutlet UILabel *offerLabel;
@end
