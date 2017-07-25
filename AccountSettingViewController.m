//
//  AccountSettingViewController.m
//  samens
//
//  Created by All time Support on 13/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "ForgotViewController.h"
#import <MBProgressHUD.h>

@interface AccountSettingViewController ()<UIAlertViewDelegate>
{
    IBOutlet UIImageView *profileImage;
    IBOutlet UITextField *nameTf;
    IBOutlet UITextField *emailTf;
    IBOutlet UITextField *mobileNumberTf;
    IBOutlet UITextField *passwordTf;
    

}
@property (nonatomic, weak) NSTimer *myTimer;
@property (nonatomic, strong) UIAlertView *myAlert;

@end

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameTf.text = [NSUserDefaults.standardUserDefaults valueForKey:@"name"];
    mobileNumberTf.text = [NSUserDefaults.standardUserDefaults valueForKey:@"mobile"];
    emailTf.text = [NSUserDefaults.standardUserDefaults valueForKey:@"email"];
    passwordTf.text = [NSUserDefaults.standardUserDefaults valueForKey:@"pass"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickOnUpdate:(id)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/updateAccountInfo.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *params = [NSString stringWithFormat:@"name=%@&email=%@&mobile=%@&password=%@&api=%@",nameTf.text,emailTf.text,mobileNumberTf.text,passwordTf.text,[NSUserDefaults.standardUserDefaults valueForKey:@"api"]];
    NSLog(@"%@",params);
    
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestData);
    [request setHTTPBody:requestData];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:30.0];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task= [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"%@",error);
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                _myAlert = [[UIAlertView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
                [_myAlert setAlertViewStyle:UIAlertViewStyleDefault];
                [_myAlert setTitle:@"User Successfully Updated"];
//                [_myAlert setBackgroundColor:[UIColor blackColor]];
                _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(cancelAlert) userInfo:nil repeats:NO];

                [_myAlert show];
            });
            
        }
    }];
    [task resume];
}
-(void)cancelAlert{
    [_myAlert dismissWithClickedButtonIndex:-1 animated:YES];
}

- (void)alertViewCancel:(UIAlertView *)alertView {
    
}

-(IBAction)clickOnChangeAddress:(id)sender{
    
}

@end
