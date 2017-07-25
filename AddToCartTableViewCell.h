//
//  AddToCartTableViewCell.h
//  samens
//
//  Created by All time Support on 30/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddToCartTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *ProductNameLabel;
@property(nonatomic,weak)IBOutlet UILabel *PriceLabel;
@property(nonatomic,weak)IBOutlet UILabel *SizeLabel;
@property(nonatomic,weak)IBOutlet UIImageView *ProductImage;
@property(nonatomic,weak)IBOutlet UILabel *colorLabel;
@property(nonatomic,weak)IBOutlet UIButton *moveToWishListButton;
@property(nonatomic,weak)IBOutlet UIButton *removeButton;

@property(nonatomic,weak)IBOutlet UIStepper *quantityStepper;
@property(nonatomic,weak)IBOutlet UILabel *stepperQuantityLabel;

@end
