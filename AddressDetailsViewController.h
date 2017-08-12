//
//  AddressDetailsViewController.h
//  samens
//
//  Created by All time Support on 09/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressDetailsViewController : UIViewController

-(IBAction)clickOnRemove:(UIButton *)sender;

@property(nonatomic,weak)IBOutlet UIButton *editButton;
@property(nonatomic,weak)IBOutlet UIButton *removeButton;
@property(nonatomic,strong)UIButton *homeBtn;
@property(nonatomic,strong)UIButton *workBtn;

@property(nonatomic,weak)IBOutlet UITableView *AddressTableview;
@end
