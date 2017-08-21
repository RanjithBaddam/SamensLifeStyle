//
//  PaymentAddressViewController.h
//  samens
//
//  Created by All time Support on 07/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentAddressViewController : UIViewController
@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;
@property(nonatomic,weak)IBOutlet UIButton *LocationAccessBtn;
-(IBAction)clickOnLocatinAccess:(UIButton *)sender;
@property(nonatomic,weak)IBOutlet UIView *fullView;
@end
