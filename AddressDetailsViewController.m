//
//  AddressDetailsViewController.m
//  samens
//
//  Created by All time Support on 09/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AddressDetailsViewController.h"
#import "PaymentAddressViewController.h"
#import <MBProgressHUD.h>
#import "AddressDetailsModel.h"
#import "AddressTableViewCell.h"
#import "editAddressViewController.h"

@interface AddressDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *AddressData;
    AddressDetailsModel *addressDetailsModel;
    IBOutlet UILabel *noAddressLabel;
  
}
@end

@implementation AddressDetailsViewController
-(void)viewWillAppear:(BOOL)animated{
    [self FetchAddressDetails];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AddressData = [[NSMutableArray alloc]init];
}
-(IBAction)clickOnEdit:(UIButton *)sender{
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/FetchAdressTypeDetails.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    addressDetailsModel = [AddressData objectAtIndex:sender.tag];
    NSString *Type = addressDetailsModel.add_type;
    NSString *Id = addressDetailsModel.id;
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&type=%@&id=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],Type,Id];
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
            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:1]]){
                dispatch_async(dispatch_get_main_queue(),^{
                    editAddressViewController *editAddressVc = [self.storyboard instantiateViewControllerWithIdentifier:@"editAddressViewController"];
                    editAddressVc.addressDetailsModel = addressDetailsModel;
                    NSLog(@"%@",editAddressVc.addressDetailsModel);
                    [self.navigationController pushViewController:editAddressVc animated:YES];
             
                });
            }else{
                dispatch_async(dispatch_get_main_queue(),^{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Cannot edit" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                });
            }
        }
    }];
    [task resume];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)FetchAddressDetails{
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
                  dispatch_async(dispatch_get_main_queue(),^{
                      noAddressLabel.hidden = NO;
                      self.AddressTableview.hidden = YES;
                        [AddressData removeAllObjects];
                        self.AddressTableview.delegate = self;
                        self.AddressTableview.dataSource = self;
                        [self.AddressTableview reloadData];
                  });
                
              }else{
            NSArray *dammyArray = [jsonData valueForKey:@"categories"];
            NSLog(@"%@",dammyArray);
            int index;
            for (index = 0; index < dammyArray.count; index++) {
                addressDetailsModel = [[AddressDetailsModel alloc]init];
                NSDictionary *dict = dammyArray[index];
                [addressDetailsModel getAddressModelWithDictionary:dict];
                [AddressData addObject:addressDetailsModel];
            }
            NSLog(@"%@",AddressData);
            dispatch_async(dispatch_get_main_queue(),^{
                noAddressLabel.hidden = YES;
                self.AddressTableview.hidden = NO;
                [MBProgressHUD hideHUDForView :self.view animated:YES];
                self.AddressTableview.delegate = self;
                self.AddressTableview.dataSource = self;
                [self.AddressTableview reloadData];
            });
        }
        }
    }];
    [task resume];
}

-(IBAction)clickOnRemove:(UIButton *)sender{
    if ([addressDetailsModel.add_type isEqualToString:@"H"]) {
        
    dispatch_async(dispatch_get_main_queue(),^{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/delete_add.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&type=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"H"];
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
                  [self FetchAddressDetails];
              }else if ([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:1]]){
                  dispatch_async(dispatch_get_main_queue(),^{

                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"User successfully Removed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                  [alert show];
                  [self FetchAddressDetails];
                  });
              }else{
                  dispatch_async(dispatch_get_main_queue(),^{
                  [self FetchAddressDetails];
                  });
              }
        }
    }];
    [task resume];
    }else{
        dispatch_async(dispatch_get_main_queue(),^{
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/delete_add.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        
        NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&type=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"W"];
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
                    [self FetchAddressDetails];
                }else if ([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:1]]){
                    dispatch_async(dispatch_get_main_queue(),^{
                        
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"User successfully Removed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        [self FetchAddressDetails];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(),^{
                        [self FetchAddressDetails];
                    });
                }
            }
        }];
        [task resume];

    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return AddressData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      AddressTableViewCell *cell = [self.AddressTableview dequeueReusableCellWithIdentifier:@"AddressTableViewCell"];
    addressDetailsModel = [AddressData objectAtIndex:indexPath.section];
    NSLog(@"%@",addressDetailsModel.name);
    cell.CustName.text = addressDetailsModel.name;
    NSLog(@"%@",cell.CustName.text);
    cell.cityName.text = addressDetailsModel.city;
    cell.stateName.text = addressDetailsModel.state;
    cell.address.text = addressDetailsModel.full_address;
    cell.pincode.text = addressDetailsModel.pincode;
    cell.custMobile.text = addressDetailsModel.mobile;
    cell.alternateMobileNumber.text = addressDetailsModel.mobile_sec;
    cell.defaultSaveButton.layer.borderWidth = 1;
    cell.defaultSaveButton.layer.borderColor = [UIColor blackColor].CGColor;
    [cell.defaultSaveButton addTarget:self action:@selector(clickOnDefaultsSave:) forControlEvents:UIControlEventTouchUpInside];
    if ([addressDetailsModel.add_type isEqualToString:@"H"]) {
        cell.homePopUpLabel.hidden = NO;
    }else{
        cell.officePopUpLabel.hidden = NO;
    }
    
    return cell;
   
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *FooterView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 44)];
        [FooterView setBackgroundColor:[UIColor orangeColor]];
        UIButton *editButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, FooterView.frame.size.width/2, FooterView.frame.size.height)];
        [editButton setBackgroundColor:[UIColor orangeColor]];
        [editButton setTitle:@"EDIT" forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        editButton.tag = section;
        NSLog(@"%ld",(long)editButton.tag);
        [editButton addTarget:self action:@selector(clickOnEdit:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *RemoveButton = [[UIButton alloc]initWithFrame:CGRectMake((FooterView.frame.size.width)-207, 0, FooterView.frame.size.width/2, 44)];
        [RemoveButton setBackgroundColor:[UIColor blueColor]];
        [RemoveButton setTitle:@"REMOVE" forState:UIControlStateNormal];
        [RemoveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        RemoveButton.tag = section;
        [RemoveButton addTarget:self action:@selector(clickOnRemove:) forControlEvents:UIControlEventTouchUpInside];
        [FooterView addSubview:editButton];
        [FooterView addSubview:RemoveButton];
        return FooterView;

    
    
// custom view for footer. will be adjusted to default or specified footer height
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
}

-(IBAction)clickOnDefaultsSave:(UIButton *)sender{
    
}

@end
