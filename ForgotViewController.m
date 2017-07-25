//
//  ForgotViewController.m
//  samens
//
//  Created by All time Support on 27/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "ForgotViewController.h"
#import <MBProgressHUD.h>
#import "verificationViewController.h"

@interface ForgotViewController ()

@end

@implementation ForgotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self.navigationItem setHidesBackButton:YES animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)ClickOnNext:(UIButton *)sender{
    if ([self.numberTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"MobileNumber" message:@"Please fill all the details" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }else{
        self.popUpView.hidden = YES;
        self.popUpView1.hidden = NO;
}
}
-(IBAction)ClickOnNewNext:(UIButton *)sender{
    self.popUpView.hidden = YES;
    if ([self.newpasswordTextField.text isEqualToString:@""]||[self.confirmPassword.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Password" message:@"Please fill all the details" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
        hud.label.text = strloadingText;
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/forgetpassword.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        NSString *params = [NSString stringWithFormat:@"mobile=%@&password=%@",self.numberTextField.text,self.confirmPassword.text];
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
            }else{
                id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"%@",response);
                NSLog(@"%@",jsonData);
               
            }
             dispatch_async(dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 verificationViewController *verifyVc = [self.storyboard instantiateViewControllerWithIdentifier:@"verificationViewController"];
                 [self.navigationController pushViewController:verifyVc animated:YES];
             });
        }];
        
        [task resume];
}

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
