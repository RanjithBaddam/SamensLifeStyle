//
//  WishlistTableViewCell.h
//  samens
//
//  Created by All time Support on 04/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishlistTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView *productImage;
@property(nonatomic,weak)IBOutlet UILabel *NameLabel;
@property(nonatomic,weak)IBOutlet UILabel *ratingLabel;
@property(nonatomic,weak)IBOutlet UILabel *quantityLabel;
@property(nonatomic,weak)IBOutlet UILabel *rateLabel;
@property(nonatomic,weak)IBOutlet UIButton *RemoveButton;

@end
