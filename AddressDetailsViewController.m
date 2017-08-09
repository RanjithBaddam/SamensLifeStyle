//
//  AddressDetailsViewController.m
//  samens
//
//  Created by All time Support on 09/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AddressDetailsViewController.h"
#import "PaymentAddressViewController.h"

@interface AddressDetailsViewController ()

@end

@implementation AddressDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.CustName.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Name"];
    self.cityName.text = [NSUserDefaults.standardUserDefaults valueForKey:@"City"];
    self.stateName.text = [NSUserDefaults.standardUserDefaults valueForKey:@"State"];
    self.address.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Address"];
    self.pincode.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Pincode"];
    self.custMobile.text = [NSUserDefaults.standardUserDefaults valueForKey:@"Number"];
    self.alternateMobileNumber.text = [NSUserDefaults.standardUserDefaults valueForKey:@"AltNumber"];
    [self.editButton addTarget:self action:@selector(clickOnEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(IBAction)clickOnEdit:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)clickOnRemove:(UIButton *)sender{
    
    
}
@end
