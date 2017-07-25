//
//  signupViewController.m
//  samens
//
//  Created by All time Support on 01/06/17
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "signupViewController.h"
#import <MBProgressHUD.h>
#import "verificationViewController.h"
#import "AccountViewController.h"

@interface signupViewController (){
    NSTimer *myTimer;
    UIAlertView *alert;
    NSPredicate *emailTest;
  
}
@property(nonatomic,weak)IBOutlet UITextField *nameTF;
@property(nonatomic,weak)IBOutlet UITextField *emailTF;
@property(nonatomic,weak)IBOutlet UITextField *passwordTF;
@property(nonatomic,weak)IBOutlet UITextField *confirmpasswordTF;
@property(nonatomic,weak)IBOutlet UITextField *mobileNumTF;
@property(nonatomic,strong)NSArray *array;

@end

@implementation signupViewController
@synthesize nameTF,emailTF,passwordTF,confirmpasswordTF,mobileNumTF;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(IBAction)clickOnSignUp:(id)sender{

    if ([nameTF.text isEqualToString:@""]||[emailTF.text isEqualToString:@""]||[passwordTF.text isEqualToString:@""]||[confirmpasswordTF.text isEqualToString:@""]||[mobileNumTF.text isEqualToString:@""]) {
        alert = [[UIAlertView alloc]initWithTitle:@"SignUpFailed" message:@"Please fill the all details correctly" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
     
    if ([passwordTF.text isEqualToString:confirmpasswordTF.text] && [mobileNumTF.text length]==10 &&[self NSStringIsValidEmail:emailTF.text]&&[nameTF.text length]<=20){
      
      MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
        hud.label.text = strloadingText;
        
        
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/request_sms.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *params = [NSString stringWithFormat:@"name=%@&email=%@&password=%@&mobile=%@",nameTF.text,emailTF.text,passwordTF.text,mobileNumTF.text];
        NSLog(@"%@",params);
        
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",requestData);
    [request setHTTPBody:requestData];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:30.0];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError *err;
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
                NSLog(@"%@",response);
                NSLog(@"%@",jsonData);
                NSArray *dammyArray = [jsonData objectForKey:@"categories"];
                
                for (NSDictionary *eachUser in dammyArray){
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"api"] forKey:@"api"];
                    NSLog(@"%@",eachUser);
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"custid"] forKey:@"custid"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"dor"] forKey:@"dor"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"email"] forKey:@"email"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"mobile"] forKey:@"mobile"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"name"] forKey:@"name"];
                    NSLog(@"%@",eachUser);
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"pass"] forKey:@"pass"];
                    
                }

                if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"error"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:1]]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSError *Error;
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        alert = [[UIAlertView alloc]initWithTitle:@"User SignUp" message:[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&Error] objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                         alert = [[UIAlertView alloc]initWithTitle:nil message:@"SMS request is initiated! You will be receiving it shortly." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                         myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(cancelAlert) userInfo:nil repeats:NO];
                        [alert show];
                        verificationViewController *verifyVc = [self.storyboard instantiateViewControllerWithIdentifier:@"verificationViewController"];
                        [self.navigationController pushViewController:verifyVc animated:YES];
                        
                    });
                }

            }
        } ];
        [task resume];
}else{
            alert = [[UIAlertView alloc]initWithTitle:@"Please check" message:@"Oops! Password does not matches and mobile number must 10 digits" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
     }
}
-(void)cancelAlert{
    [alert dismissWithClickedButtonIndex:-1 animated:YES];
 
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
