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
#import <MBProgressHUD.h>
#import "AddressDetailsModel.h"
#import <CoreLocation/CoreLocation.h>

@interface PaymentAddressViewController ()<UITextFieldDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>{
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
    IBOutlet UIButton *defaultSavingBtn;
    IBOutlet UILabel *cityPopUp;
    IBOutlet UILabel *pincodePopUp;
    IBOutlet UILabel *statePopUp;
    IBOutlet UILabel *localityPopUp;
    IBOutlet UILabel *landMarkPopUp;
    IBOutlet UILabel *namePopUp;
    IBOutlet UILabel *phoneNumPopUp;
    IBOutlet UILabel *altPhnNumPopUp;
    NSTimer *timer;
    UIAlertView *alert;
    AddressDetailsModel *addressModel;
    NSMutableArray *addressData;
    CLLocationManager *locationManager;
    CLPlacemark *placemark;

}

@end

@implementation PaymentAddressViewController
-(void)viewWillAppear:(BOOL)animated{
    [self getUserAddressDetails];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.fullView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
//    [self.scrollView addSubview:self.fullView];

    CityTextField.delegate = self;
    PincodeTextField.delegate = self;
    StateTextField.delegate = self;
    LocalityTextField.delegate = self;
    LandMarktextField.delegate = self;
    NameTextField.delegate = self;
    PhnoneNumberTextField.delegate = self;
    AlternatePhoneNumberTextField.delegate = self;


    
//        UIImage *img = [UIImage imageNamed:@"NavigationImage"];
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
//        [imgView setImage:img];
//        // setContent mode aspect fit
//        [imgView setContentMode:UIViewContentModeScaleAspectFit];
//        self.navigationItem.titleView = imgView;
//        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 710);
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
    
    defaultSavingBtn.layer.borderWidth = 1;
    defaultSavingBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    


    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(IBAction)clickOnCancel:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickOnSave:(UIButton *)sender{
  
    if ([HomeDeliveryButton isSelected]) {
        
    if ([CityTextField.text isEqualToString:@""]|| [PincodeTextField.text isEqualToString:@""]||[StateTextField.text isEqualToString:@""]||[LocalityTextField.text isEqualToString:@""]||[LandMarktextField.text isEqualToString:@""]||[NameTextField.text isEqualToString:@""]||[PhnoneNumberTextField.text isEqualToString:@""]||[AlternatePhoneNumberTextField.text isEqualToString:@""]) {
        alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill all the details correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&city=%@&state=%@&type=%@&mobile_sec=%@&pin=%@&name=%@&land=%@&mobile=%@&add_full=%@&id=%@&d_add=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],CityTextField.text,StateTextField.text,@"H",AlternatePhoneNumberTextField.text,PincodeTextField.text,NameTextField.text,LandMarktextField.text,PhnoneNumberTextField.text,LocalityTextField.text,@"N",@"Y"];
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
                alert = [[UIAlertView alloc]initWithTitle:@"Wrong Details" message:@"Please fill all the details correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }else{
                dispatch_async(dispatch_get_main_queue(),^{

                AddressDetailsViewController *addressDetailsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressDetailsViewController"];
                [self.navigationController pushViewController:addressDetailsVc animated:YES];
                });
            }
            
        }
    }];
    [task resume];
        }else{
            alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Please enter valid details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    }else{
        if ([CityTextField.text isEqualToString:@""]|| [PincodeTextField.text isEqualToString:@""]||[StateTextField.text isEqualToString:@""]||[LocalityTextField.text isEqualToString:@""]||[LandMarktextField.text isEqualToString:@""]||[NameTextField.text isEqualToString:@""]||[PhnoneNumberTextField.text isEqualToString:@""]||[AlternatePhoneNumberTextField.text isEqualToString:@""]) {
            alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please fill all the details correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
            
            NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&city=%@&state=%@&type=%@&mobile_sec=%@&pin=%@&name=%@&land=%@&mobile=%@&add_full=%@&id=%@&d_add=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],CityTextField.text,StateTextField.text,@"W",AlternatePhoneNumberTextField.text,PincodeTextField.text,NameTextField.text,LandMarktextField.text,PhnoneNumberTextField.text,LocalityTextField.text,@"N",@"Y"];
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
                        alert = [[UIAlertView alloc]initWithTitle:@"Wrong Details" message:@"Please fill all the details correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(),^{
                            
                            AddressDetailsViewController *addressDetailsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressDetailsViewController"];
                            [self.navigationController pushViewController:addressDetailsVc animated:YES];
                        });
                    }
                    
                }
            }];
            [task resume];
            
              }else{
                  alert = [[UIAlertView alloc]initWithTitle:@"Failed" message:@"Please enter valid details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                  [alert show];

              }
        }

    }
}

-(IBAction)clickOnDefaultSave:(UIButton *)sender{
    if ([sender isSelected]) {
        [sender setSelected: NO];
        [defaultSavingBtn setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
        
    } else {
        [sender setSelected: YES];
        [defaultSavingBtn setBackgroundImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
        [HomeDeliveryButton setSelected:NO];
        [HomeDeliveryButton setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
        [WorkDeliveryButton setSelected:NO];
        [WorkDeliveryButton setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
    }
    
}
-(IBAction)clickOnHomeDelivery:(UIButton *)sender{
    if ([sender isSelected]) {
        [sender setSelected: NO];
        [HomeDeliveryButton setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
        
    } else {
        [sender setSelected: YES];
        [HomeDeliveryButton setBackgroundImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
        [WorkDeliveryButton setSelected:NO];
        [WorkDeliveryButton setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
        [defaultSavingBtn setSelected:NO];
        [defaultSavingBtn setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
    }
    
  
    
}
-(IBAction)clickOnWorkDelivery:(UIButton *)sender{
    if ([sender isSelected]) {
        [sender setSelected: NO];
        [WorkDeliveryButton setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
        
    } else {
        [sender setSelected: YES];
        [WorkDeliveryButton setBackgroundImage:[UIImage imageNamed:@"tick"] forState:UIControlStateNormal];
        [HomeDeliveryButton setSelected:NO];
        [HomeDeliveryButton setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
        [defaultSavingBtn setSelected:NO];
        [defaultSavingBtn setBackgroundImage:[UIImage imageNamed:@"untick"] forState:UIControlStateNormal];
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
-(void)getUserAddressDetails{
    dispatch_async(dispatch_get_main_queue(),^{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/FetchAdressDetails.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"]];
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
                 
                 
             }else{
            NSArray *dammyArray = [jsonData valueForKey:@"categories"];
            int index;
            addressData = [[NSMutableArray alloc]init];
            for (index = 0; index < dammyArray.count; index++) {
                NSDictionary *dict = dammyArray[index];
                addressModel = [[AddressDetailsModel alloc]init];
                [addressModel getAddressModelWithDictionary:dict];
                [addressData addObject:addressModel];
            }
            NSLog(@"%@",addressData);
                 dispatch_async(dispatch_get_main_queue(),^{
  
                 CityTextField.text = addressModel.city;
                 PincodeTextField.text = addressModel.pincode;
                 StateTextField.text = addressModel.state;
                 LocalityTextField.text = addressModel.full_address;
                 LandMarktextField.text = addressModel.landmark;
                 NameTextField.text = addressModel.name;
                 PhnoneNumberTextField.text = addressModel.mobile;
                 AlternatePhoneNumberTextField.text = addressModel.mobile_sec;
                 
                 });
        }
        }
    }];
    [task resume];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude]; //insert your coordinates
    
    [ceo reverseGeocodeLocation:loc
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  placemark = [placemarks objectAtIndex:0];
//                  if (placemark) {
//                      NSDictionary *address = [placemark valueForKey:@"addressDictionary"];
//                      NSLog(@"%@",address);
//                      CityTextField.text = [address valueForKey:@"City"];
//                      PincodeTextField.text = [address valueForKey:@"ZIP"];
//                      StateTextField.text = [address valueForKey:@"State"];
//                      LocalityTextField.text = [[address valueForKey:@"FormattedAddressLines"]componentsJoinedByString:@", "];
//                      NameTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"name"];
//                      PhnoneNumberTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"mobile"];
//                      
//                NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//                      
//                       NSLog(@"addressDictionary %@", placemark.addressDictionary);
//                      
//                      
//                      NSLog(@"I am currently at %@",locatedAt);
//                      
//                  }
//                  else {
//                      NSLog(@"Could not locate");
//                  }
              }
     ];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0)//Settings button pressed
    {
        if (alertView.tag == 100)
        {
            //This will open ios devices location settings
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: UIApplicationOpenSettingsURLString]];
        }
        else if (alertView.tag == 200)
        {
            //This will opne particular app location settings
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
    else if(buttonIndex == 1)//Cancel button pressed.
    {
        //TODO for cancel
    }
}

-(IBAction)clickOnLocatinAccess:(UIButton *)sender{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled!"
                                                            message:@"Please enable Location Based Services for better results! We promise to keep your location private"
                                                           delegate:self
                                                  cancelButtonTitle:@"Settings"
                                                  otherButtonTitles:@"Cancel", nil];
        
        //TODO if user has not given permission to device
        if (![CLLocationManager locationServicesEnabled])
        {
            alertView.tag = 100;
        }
        //TODO if user has not given permission to particular app
        else
        {
            alertView.tag = 200;
        }
        
        [alertView show];
        
        return;
    }
    else
    {
        //Location Services Enabled, let's start location updates
        [locationManager startUpdatingLocation];
        if (placemark) {
            NSDictionary *address = [placemark valueForKey:@"addressDictionary"];
            NSLog(@"%@",address);
            CityTextField.text = [address valueForKey:@"City"];
            PincodeTextField.text = [address valueForKey:@"ZIP"];
            StateTextField.text = [address valueForKey:@"State"];
            LocalityTextField.text = [[address valueForKey:@"FormattedAddressLines"]componentsJoinedByString:@", "];
            NameTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"name"];
            PhnoneNumberTextField.text = [NSUserDefaults.standardUserDefaults valueForKey:@"mobile"];
            
            NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
            
            NSLog(@"addressDictionary %@", placemark.addressDictionary);
            
            
            NSLog(@"I am currently at %@",locatedAt);
            
        }
        else {
            NSLog(@"Could not locate");
        }

        
    }

    
}


@end
