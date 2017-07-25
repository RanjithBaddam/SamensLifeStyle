//
//  ViewController.h
//  samens
//
//  Created by All time Support on 30/05/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITextFieldDelegate , UIGestureRecognizerDelegate>
@property(nonatomic,weak)IBOutlet UICollectionView *adsScrollCollectionView;
@property(nonatomic,weak)IBOutlet UIButton *loginWithFacebook;

@property(nonatomic,weak)IBOutlet UIButton *loginWithGoogle;

-(IBAction)ClickOnForgot:(id)sender;


@end

