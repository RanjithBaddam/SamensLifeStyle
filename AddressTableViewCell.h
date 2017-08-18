//
//  AddressTableViewCell.h
//  samens
//
//  Created by All time Support on 10/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *CustName;
@property(nonatomic,weak)IBOutlet UILabel *cityName;
@property(nonatomic,weak)IBOutlet UILabel *stateName;
@property(nonatomic,weak)IBOutlet UILabel *address;
@property(nonatomic,weak)IBOutlet UILabel *pincode;
@property(nonatomic,weak)IBOutlet UILabel *custMobile;
@property(nonatomic,weak)IBOutlet UILabel *alternateMobileNumber;
@property(nonatomic,weak)IBOutlet UILabel *homePopUpLabel;
@property(nonatomic,weak)IBOutlet UILabel *officePopUpLabel;
@property(nonatomic,weak)IBOutlet UIButton *defaultSaveButton;
@end
