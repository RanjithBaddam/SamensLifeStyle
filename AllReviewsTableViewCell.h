//
//  AllReviewsTableViewCell.h
//  samens
//
//  Created by All time Support on 03/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllReviewsTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView *reviewPersonImage;
@property(nonatomic,weak)IBOutlet UILabel *starsLabel;
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UILabel *DiscriptionLabel;
@property(nonatomic,weak)IBOutlet UILabel *customerNameLabel;
@property(nonatomic,weak)IBOutlet UILabel *dateLabel;

@end
