//
//  ProductPriceOfferTableViewCell.h
//  samens
//
//  Created by All time Support on 21/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductPriceOfferTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *itemNameLabel;
@property(nonatomic,weak)IBOutlet UILabel *itemPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceOffLabel;
@property(nonatomic,weak)IBOutlet UILabel *persentageOffLabel;
@property(nonatomic,weak)IBOutlet UILabel *ratingTitle;

@end
