//
//  customProductCollectionViewCell.h
//  samens
//
//  Created by All time Support on 10/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customProductCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak)IBOutlet UILabel *productImageNameLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceOffLabel;
@property(nonatomic,weak)IBOutlet UIButton *indianPriceSimbolBtn;
@property(nonatomic,weak)IBOutlet UILabel *offPersentageLabel;
@end
