//
//  AccountViewController.h
//  samens
//
//  Created by All time Support on 16/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginDetailsModel.h"

@interface AccountViewController : UIViewController <UIAlertViewDelegate>
@property(nonatomic,weak)IBOutlet UIScrollView *scrollView;
-(IBAction)clickOnSignIn:(id)sender;
@property(nonatomic,weak)IBOutlet UITableView *AccountTableView;
@property(nonatomic,strong)LoginDetailsModel *loginModel;


@end
