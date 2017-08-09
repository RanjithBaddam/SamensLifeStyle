//
//  PaymentAddressViewController.m
//  samens
//
//  Created by All time Support on 07/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "PaymentAddressViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AddressDetailsViewController.h"

@interface PaymentAddressViewController (){
   IBOutlet UITextField *CityTextField;
   IBOutlet UITextField *PincodeTextField;
   IBOutlet UITextField *StateTextField;
   IBOutlet UITextField *LocalityTextField;
   IBOutlet UITextField *LandMarktextField;
   IBOutlet UITextField *NameTextField;
   IBOutlet UITextField *PhnoneNumberTextField;
   IBOutlet UITextField *AlternatePhoneNumberTextField;
   IBOutlet UILabel *HomeDeliveryLabel;
   IBOutlet UILabel *WorkDeliveryLabel;
   IBOutlet UIButton *HomeDeliveryButton;
   IBOutlet UIButton *WorkDeliveryButton;
    
    
}

@end

@implementation PaymentAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        UIImage *img = [UIImage imageNamed:@"NavigationImage"];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        [imgView setImage:img];
        // setContent mode aspect fit
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        self.navigationItem.titleView = imgView;
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 900);
        CALayer *border = [CALayer layer];
        CGFloat borderWidth = 2;
        border.borderColor = [UIColor darkGrayColor].CGColor;
        border.frame = CGRectMake(0, CityTextField.frame.size.height - borderWidth, CityTextField.frame.size.width, CityTextField.frame.size.height);
        border.borderWidth = borderWidth;
        [CityTextField.layer addSublayer:border];
        CityTextField.layer.masksToBounds = YES;
        
        CALayer *border1 = [CALayer layer];
        CGFloat borderWidth1 = 2;
        border1.borderColor = [UIColor darkGrayColor].CGColor;
        border1.frame = CGRectMake(0, PincodeTextField.frame.size.height - borderWidth1, PincodeTextField.frame.size.width, PincodeTextField.frame.size.height);
        border1.borderWidth = borderWidth1;
        [PincodeTextField.layer addSublayer:border1];
        PincodeTextField.layer.masksToBounds = YES;
        
        CALayer *border2 = [CALayer layer];
        CGFloat borderWidth2 = 2;
        border2.borderColor = [UIColor darkGrayColor].CGColor;
        border2.frame = CGRectMake(0, StateTextField.frame.size.height - borderWidth2, StateTextField.frame.size.width, StateTextField.frame.size.height);
        border2.borderWidth = borderWidth2;
        [StateTextField.layer addSublayer:border2];
        StateTextField.layer.masksToBounds = YES;
        
        CALayer *border3 = [CALayer layer];
        CGFloat borderWidth3 = 2;
        border3.borderColor = [UIColor darkGrayColor].CGColor;
        border3.frame = CGRectMake(0, LocalityTextField.frame.size.height - borderWidth3, LocalityTextField.frame.size.width, LocalityTextField.frame.size.height);
        border3.borderWidth = borderWidth3;
        [LocalityTextField.layer addSublayer:border3];
        LocalityTextField.layer.masksToBounds = YES;
        
        CALayer *border4 = [CALayer layer];
        CGFloat borderWidth4 = 2;
        border4.borderColor = [UIColor darkGrayColor].CGColor;
        border4.frame = CGRectMake(0, NameTextField.frame.size.height - borderWidth4, NameTextField.frame.size.width, NameTextField.frame.size.height);
        border4.borderWidth = borderWidth4;
        [NameTextField.layer addSublayer:border4];
        NameTextField.layer.masksToBounds = YES;
        
        CALayer *border5 = [CALayer layer];
        CGFloat borderWidth5 = 2;
        border5.borderColor = [UIColor darkGrayColor].CGColor;
        border5.frame = CGRectMake(0, PhnoneNumberTextField.frame.size.height - borderWidth5, PhnoneNumberTextField.frame.size.width, PhnoneNumberTextField.frame.size.height);
        border5.borderWidth = borderWidth5;
        [PhnoneNumberTextField.layer addSublayer:border5];
        PhnoneNumberTextField.layer.masksToBounds = YES;
        
        CALayer *border6 = [CALayer layer];
        CGFloat borderWidth6 = 2;
        border6.borderColor = [UIColor darkGrayColor].CGColor;
        border6.frame = CGRectMake(0, AlternatePhoneNumberTextField.frame.size.height - borderWidth6, AlternatePhoneNumberTextField.frame.size.width, AlternatePhoneNumberTextField.frame.size.height);
        border6.borderWidth = borderWidth6;
        [AlternatePhoneNumberTextField.layer addSublayer:border6];
        AlternatePhoneNumberTextField.layer.masksToBounds = YES;
        
        CALayer *border7 = [CALayer layer];
        CGFloat borderWidth7 = 2;
        border7.borderColor = [UIColor darkGrayColor].CGColor;
        border7.frame = CGRectMake(0, AlternatePhoneNumberTextField.frame.size.height - borderWidth7, AlternatePhoneNumberTextField.frame.size.width, AlternatePhoneNumberTextField.frame.size.height);
        border7.borderWidth = borderWidth7;
        [AlternatePhoneNumberTextField.layer addSublayer:border7];
        AlternatePhoneNumberTextField.layer.masksToBounds = YES;
        
        CALayer *border8 = [CALayer layer];
        CGFloat borderWidth8 = 2;
        border8.borderColor = [UIColor darkGrayColor].CGColor;
        border8.frame = CGRectMake(0, LandMarktextField.frame.size.height - borderWidth8, LandMarktextField.frame.size.width, LandMarktextField.frame.size.height);
        border8.borderWidth = borderWidth8;
        [LandMarktextField.layer addSublayer:border8];
        LandMarktextField.layer.masksToBounds = YES;
        
        HomeDeliveryButton.layer.cornerRadius = 16;
        HomeDeliveryButton.layer.borderWidth = 1;
        HomeDeliveryButton.layer.borderColor = [UIColor blackColor].CGColor;
        
        WorkDeliveryButton.layer.cornerRadius = 16;
        WorkDeliveryButton.layer.borderWidth = 1;
        WorkDeliveryButton.layer.borderColor = [UIColor blackColor].CGColor;

    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(IBAction)clickOnCancel:(UIButton *)sender{
    
}

-(IBAction)clickOnSave:(UIButton *)sender{
    if ([NameTextField.text isEqualToString:@""]||[CityTextField.text isEqualToString:@""]||[PincodeTextField.text isEqualToString:@""]||[StateTextField.text isEqualToString:@""]||[LocalityTextField.text isEqualToString:@""]||[LandMarktextField.text isEqualToString:@""]||[PhnoneNumberTextField.text isEqualToString:@""]||[AlternatePhoneNumberTextField.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please check and fill all details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        [NSUserDefaults.standardUserDefaults setObject:NameTextField.text forKey:@"Name"];
        NSLog(@"%@",[NSUserDefaults.standardUserDefaults valueForKey:@"Name"]);
        [NSUserDefaults.standardUserDefaults setObject:CityTextField.text forKey:@"City"];
        [NSUserDefaults.standardUserDefaults setObject:PincodeTextField.text forKey:@"Pincode"];
        [NSUserDefaults.standardUserDefaults setObject:StateTextField.text forKey:@"State"];
        [NSUserDefaults.standardUserDefaults setObject:PhnoneNumberTextField.text forKey:@"Number"];
        [NSUserDefaults.standardUserDefaults setObject:AlternatePhoneNumberTextField.text forKey:@"AltNumber"];
        [NSUserDefaults.standardUserDefaults setObject:LocalityTextField.text forKey:@"Address"];
        [NSUserDefaults.standardUserDefaults setObject:LandMarktextField.text forKey:@"Landmark"];
       
        NameTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Name"];
        CityTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"City"];
        PincodeTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Pincode"];
        StateTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"State"];
        PhnoneNumberTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Number"];
        AlternatePhoneNumberTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"AltNumber"];
        LocalityTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Address"];
        LandMarktextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Landmark"];
        
        AddressDetailsViewController *addressDetailsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressDetailsViewController"];
        [self.navigationController pushViewController:addressDetailsVc animated:YES];
    }
 


    
}
-(void)viewWillAppear:(BOOL)animated{
    NameTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Name"];
    CityTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"City"];
    PincodeTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Pincode"];
    StateTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"State"];
    PhnoneNumberTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Number"];
    AlternatePhoneNumberTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"AltNumber"];
    LocalityTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Address"];
    LandMarktextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Landmark"];
}

@end
