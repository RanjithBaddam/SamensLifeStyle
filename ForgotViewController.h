//
//  ForgotViewController.h
//  samens
//
//  Created by All time Support on 27/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotViewController : UIViewController
-(IBAction)ClickOnNext:(UIButton *)sender;
@property(nonatomic,weak)IBOutlet UITextField *numberTextField;
-(IBAction)ClickOnNewNext:(UIButton *)sender;
@property(nonatomic,weak)IBOutlet UITextField *newpasswordTextField;
@property(nonatomic,weak)IBOutlet UITextField *confirmPassword;
@property(nonatomic,weak)IBOutlet UIView *popUpView;
@property(nonatomic,weak)IBOutlet UIView *popUpView1;

@end
