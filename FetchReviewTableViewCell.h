//
//  FetchReviewTableViewCell.h
//  samens
//
//  Created by All time Support on 01/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchReviewTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView *reviewPersonImage;
@property(nonatomic,weak)IBOutlet UILabel *reviewTimeDateLabel;
@property(nonatomic,weak)IBOutlet UILabel *reviewStarsLabel;
@property(nonatomic,weak)IBOutlet UILabel *reviewDiscription;


@end
