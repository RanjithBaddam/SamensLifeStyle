//
//  ViewController.h
//  samens
//
//  Created by All time Support on 30/05/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Google/SignIn.h>



@interface ViewController : UIViewController<UITextFieldDelegate , UIGestureRecognizerDelegate,GIDSignInUIDelegate>
@property(nonatomic,weak)IBOutlet UICollectionView *adsScrollCollectionView;
@property(nonatomic,weak)IBOutlet UIButton *loginWithFacebook;


-(IBAction)ClickOnForgot:(id)sender;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property(nonatomic,strong)UIButton *facebookButton;

@end

