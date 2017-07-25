//
//  DetailsTableViewCell.h
//  samens
//
//  Created by All time Support on 11/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *PriceAmountLabel;
@property(nonatomic,weak)IBOutlet UILabel *DeliveryLabel;
@property(nonatomic,weak)IBOutlet UILabel *AmountPayableLabel;



@end
