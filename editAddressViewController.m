//
//  editAddressViewController.m
//  samens
//
//  Created by All time Support on 16/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "editAddressViewController.h"
#import <MBProgressHUD.h>
#import "AddressDetailsViewController.h"

@interface editAddressViewController ()<UITextFieldDelegate>

@end

@implementation editAddressViewController{
    IBOutlet UITextField *CityTextField;
    IBOutlet UITextField *PincodeTextField;
    IBOutlet UITextField *StateTextField;
    IBOutlet UITextField *LocalityTextField;
    IBOutlet UITextField *LandMarktextField;
    IBOutlet UITextField *NameTextField;
    IBOutlet UITextField *PhnoneNumberTextField;
    IBOutlet UITextField *AlternatePhoneNumberTextField;
    
    IBOutlet UILabel *cityPopUp;
    IBOutlet UILabel *pincodePopUp;
    IBOutlet UILabel *statePopUp;
    IBOutlet UILabel *localityPopUp;
    IBOutlet UILabel *landMarkPopUp;
    IBOutlet UILabel *namePopUp;
    IBOutlet UILabel *phoneNumPopUp;
    IBOutlet UILabel *altPhnNumPopUp;
}
-(void)viewWillAppear:(BOOL)animated{
    CityTextField.text = self.addressDetailsModel.city;
    PincodeTextField.text = self.addressDetailsModel.pincode;
    StateTextField.text = self.addressDetailsModel.state;
    LocalityTextField.text = self.addressDetailsModel.full_address;
    LandMarktextField.text = self.addressDetailsModel.landmark;
    NameTextField.text = self.addressDetailsModel.name;
    PhnoneNumberTextField.text = self.addressDetailsModel.mobile;
    AlternatePhoneNumberTextField.text = self.addressDetailsModel.mobile_sec;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CityTextField.delegate = self;
    PincodeTextField.delegate = self;
    StateTextField.delegate = self;
    LocalityTextField.delegate = self;
    LandMarktextField.delegate = self;
    NameTextField.delegate = self;
    PhnoneNumberTextField.delegate = self;
    AlternatePhoneNumberTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)clickOnSave:(UIButton *)sender{
    
    if ([CityTextField.text isEqualToString:@""]|| [PincodeTextField.text isEqualToString:@""]||[StateTextField.text isEqualToString:@""]||[LocalityTextField.text isEqualToString:@""]||[LandMarktextField.text isEqualToString:@""]||[NameTextField.text isEqualToString:@""]||[PhnoneNumberTextField.text isEqualToString:@""]||[AlternatePhoneNumberTextField.text isEqualToString:@""]) {
      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill all the details correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
       if ([PincodeTextField.text length]==6 || [PhnoneNumberTextField.text length] == 10  || [AlternatePhoneNumberTextField.text length] == 10) {
        dispatch_async(dispatch_get_main_queue(),^{
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/send_address.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *type = self.addressDetailsModel.add_type;
        NSString *d_add = self.addressDetailsModel.full_address;
        NSString *Id = self.addressDetailsModel.id;
        NSLog(@"%@",Id);
        NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&city=%@&state=%@&type=%@&mobile_sec=%@&pin=%@&name=%@&land=%@&mobile=%@&add_full=%@&id=%@&d_add=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],CityTextField.text,StateTextField.text,type,AlternatePhoneNumberTextField.text,PincodeTextField.text,NameTextField.text,LandMarktextField.text,PhnoneNumberTextField.text,LocalityTextField.text,Id,d_add];
        NSLog(@"%@",params);
        
        NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",requestData);
        [request setHTTPBody:requestData];
        
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        [config setTimeoutIntervalForRequest:30.0];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *task= [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError *err;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            if (error) {
                NSLog(@"%@",err);
                if ([error.localizedDescription isEqualToString:@"The request timed out."]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
                        alertView.tag = 001;
                        [alertView show];
                    });
                }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
                    dispatch_async(dispatch_get_main_queue(),^{
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        alertView.tag = 002;
                        [alertView show];
                    });
                }
                
            }else{
                id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"%@",jsonData);
                if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                    dispatch_async(dispatch_get_main_queue(),^{
                        AddressDetailsViewController *addressDetailsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressDetailsViewController"];
                        [self.navigationController pushViewController:addressDetailsVc animated:YES];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(),^{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"UpdateFailed" message:@"UserNotSuccessfullyUpdated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    });
                }
                
            }
        }];
        [task resume];
       }else{
          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Please enter valid details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];
       }
}
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == CityTextField) {
        cityPopUp.hidden = NO;
        CityTextField.placeholder = nil;
        
    }else if (textField == PincodeTextField){
        pincodePopUp.hidden = NO;
        PincodeTextField.placeholder = nil;
        
    }else if (textField == StateTextField){
        statePopUp.hidden = NO;
        StateTextField.placeholder = nil;
        
    }else if (textField == LocalityTextField){
        localityPopUp.hidden = NO;
        LocalityTextField.placeholder = nil;
        
    }else if (textField == LandMarktextField){
        landMarkPopUp.hidden = NO;
        LandMarktextField.placeholder = nil;
        
    }else if (textField == NameTextField){
        namePopUp.hidden = NO;
        NameTextField.placeholder = nil;
        
    }else if (textField == PhnoneNumberTextField){
        phoneNumPopUp.hidden = NO;
        PhnoneNumberTextField.placeholder = nil;
        
    }else{
        altPhnNumPopUp.hidden = NO;
        AlternatePhoneNumberTextField.placeholder = nil;
        
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == CityTextField) {
        
        cityPopUp.hidden = YES;
        CityTextField.placeholder = @"City*";
        
    }else if (textField == PincodeTextField){
        pincodePopUp.hidden = YES;
        PincodeTextField.placeholder = @"Pincode *";
        
    }else if (textField == StateTextField){
        statePopUp.hidden = YES;
        StateTextField.placeholder = @"State *";
        
    }else if (textField == LocalityTextField){
        localityPopUp.hidden = YES;
        LocalityTextField.placeholder = @"Locality,area or street *";
        
    }else if (textField == LandMarktextField){
        landMarkPopUp.hidden = YES;
        LandMarktextField.placeholder = @"Landmark (Optional)";
        
    }else if (textField == NameTextField){
        namePopUp.hidden = YES;
        NameTextField.placeholder = @"Name";
        
    }else if (textField == PhnoneNumberTextField){
        phoneNumPopUp.hidden = YES;
        PhnoneNumberTextField.placeholder = @"Phone Number";
        
    }else{
        altPhnNumPopUp.hidden = YES;
        
        AlternatePhoneNumberTextField.placeholder = @"Alternate Phone Number";
    }
}

@end
