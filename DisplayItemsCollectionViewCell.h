//
//  DisplayItemsCollectionViewCell.h
//  samens
//
//  Created by All time Support on 11/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayItemsCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UIImageView *displayItemImage;
@property(nonatomic,weak)IBOutlet UILabel *displayItemTextLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceOffLabel;
@property(nonatomic,weak)IBOutlet UILabel *percentageLabel;

@property(nonatomic,weak)IBOutlet UILabel *starRatingLabel;
@property(nonatomic,weak)IBOutlet UIButton *wishListButton;
@property(nonatomic,weak)IBOutlet UILabel *offerLabel;

@end
