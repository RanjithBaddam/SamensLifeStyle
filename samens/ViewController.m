//
//  ViewController.m
//  samens
//
//  Created by All time Support on 30/05/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "AdsBannerModel.h"
#import "homeViewController.h"
#import "adsScrollCollectionViewCell.h"
#import "signupViewController.h"
#import "ForgotViewController.h"
#import "LoginDetailsModel.h"
#import "AccountViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AccountViewController.h"



@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSMutableArray *adsMainData;
    NSTimer *timer;
    NSInteger currentAnimationIndex;
    NSMutableArray *loginDetailsArray;
    LoginDetailsModel *loginModel;
    
}
@property(nonatomic,weak)IBOutlet UITextField *emailTextField;
@property(nonatomic,weak)IBOutlet UITextField *passwordTextField;


@end

@implementation ViewController
@synthesize passwordTextField;
@synthesize emailTextField;



- (void)viewDidLoad {
    [super viewDidLoad];
        [GIDSignIn sharedInstance].uiDelegate = self;

    [NSUserDefaults.standardUserDefaults setValue:@"facebook" forKey:@"login"];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions =
    @[@"public_profile", @"email"];
    NSLog(@"%@",loginButton.readPermissions);

    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,name,email,first_name,last_name,picture.type(large)" forKey:@"fields"];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSString *fbPhotoUrl = [[[result objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"];
                 NSLog(@"%@",fbPhotoUrl);
                 NSString *email = [result objectForKey:@"email"];
                 NSString *name = [result objectForKey:@"name"];
                 NSString *userid = [result objectForKey:@"id"];
                 
                 NSLog(@"%@%@%@",email,name,userid);
            
//                 MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                 NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//                 hud.label.text = strloadingText;
                 NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/registration_ios_social-media.php"];
                 
                 NSURL *url=[NSURL URLWithString:urlInstring];
                 NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
                 [request setHTTPMethod:@"POST"];
                 NSString *params = [NSString stringWithFormat:@"userid=%@&name=%@&type=%@&image=%@&email=%@",userid,name,@"F",fbPhotoUrl,email];
                 NSLog(@"%@",params);
                 NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
                 NSLog(@"%@",requestData);
                 [request setHTTPBody:requestData];
                 NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
                 [config setTimeoutIntervalForRequest:30.0];
                 NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
                 NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data , NSURLResponse *response , NSError *error){
                     if (error){
                         NSLog(@"%@",error);
                     }else{
                         id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                         NSLog(@"%@",jsonData);
                     }
                 }];
                 [task resume];
                 
        
    }
         }];
    }
    
    [self.navigationItem setHidesBackButton:YES];

    emailTextField.text = @"baddamranjith@gmail.com";
    passwordTextField.text = @"baddam123";

    [self getAdsImages];
    UIImage *image = [UIImage imageNamed:@"Title head"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    [self.navigationItem.backBarButtonItem setAccessibilityElementsHidden:YES];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    


}


-(IBAction)clickOnLogin:(id)sender{
    
    if ([emailTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Please fill all the details" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
       
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{

        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
        hud.label.text = strloadingText;
        });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/login_samens.php"];
        
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *params = [NSString stringWithFormat:@"email=%@&password=%@",emailTextField.text,passwordTextField.text];
        NSLog(@"%@",params);
        NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",requestData);
        [request setHTTPBody:requestData];
        
        NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
        [config setTimeoutIntervalForRequest:30.0];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data , NSURLResponse *response , NSError *error){
            if (error){
                NSLog(@"%@",error);
               
            }else{
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                NSLog(@"%@",response);
                NSLog(@"%@",jsonData);
                NSArray *dammyArray = [jsonData objectForKey:@"categories"];
                
                for (NSDictionary *eachUser in dammyArray){
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"api"] forKey:@"api"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"custid"] forKey:@"custid"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"dor"] forKey:@"dor"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"email"] forKey:@"email"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"mobile"] forKey:@"mobile"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"name"] forKey:@"name"];
                    [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"pass"] forKey:@"pass"];
                    
                }
                
                int index;
                loginDetailsArray = [[NSMutableArray alloc]init];
                for (index=0; index<dammyArray.count; index++) {
                    NSDictionary *dict = dammyArray[index];
                    loginModel = [[LoginDetailsModel alloc]init];
                    [loginModel loginDetailsModelWithDictionary:dict];
                    [loginDetailsArray addObject:loginModel];
                }
                

            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                dispatch_async(dispatch_get_main_queue(), ^{
                        NSError *Error;
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User Login" message:[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&Error] objectForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    });
                
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:@"LoggedIn"];
 //                       [NSUserDefaults.standardUserDefaults setValue:@"normal" forKey:@"login"];

//                        self.tabBarController.selectedIndex = 0;

                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        AccountViewController *accountVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountViewController"];
                        accountVc.loginModel = loginModel;
                        [self.navigationController pushViewController:accountVc animated:YES];
                       

                      
                        
                    });
                }
                    }
                
            
        }];
        
        [task resume];
    }
   
}
-(void)getAdsImages{
    dispatch_async(dispatch_get_main_queue(), ^{

    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
    hud.label.text = strloadingText;
    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_page_indicater_image.php"];
    
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *params = [NSString stringWithFormat:@"sames=@&sames=@"];
    NSLog(@"%@",params);
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestData);
    [request setHTTPBody:requestData];
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:30.0];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data , NSURLResponse *response , NSError *error){
        if (error){
            NSLog(@"%@",error);
        }else{
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",jsonData);
            NSArray *dammyImg = [jsonData valueForKey:@"custmer"];
            NSLog(@"%@",dammyImg);
            int index;
            adsMainData = [[NSMutableArray alloc]init];
            for (index=0; index<dammyImg.count; index++) {
                NSDictionary *dict = dammyImg[index];
                AdsBannerModel *model =[AdsBannerModel new];
                [model setModelWithDict:dict];
                [adsMainData addObject:model];
            }
        }
         dispatch_async(dispatch_get_main_queue(), ^{
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             _adsScrollCollectionView.delegate = self;
             _adsScrollCollectionView.dataSource = self;
             [_adsScrollCollectionView reloadData];
             timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(performSlideAnimation:) userInfo:nil repeats:true];
             currentAnimationIndex = 0;
                      });

    }];
    [task resume];
}
-(IBAction)performSlideAnimation:(id)sender{
    [self.adsScrollCollectionView layoutIfNeeded];
    if (currentAnimationIndex >= adsMainData.count) {
        currentAnimationIndex = 0;
    }
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentAnimationIndex inSection:0];
    [_adsScrollCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    currentAnimationIndex = currentAnimationIndex + 1;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return adsMainData.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    adsScrollCollectionViewCell *cell = [_adsScrollCollectionView dequeueReusableCellWithReuseIdentifier:@"adsScrollCollectionViewCell" forIndexPath:indexPath];
    AdsBannerModel *model = [adsMainData objectAtIndex:indexPath.item];
    [cell.adsScrollImage setImageWithURL:[NSURL URLWithString:model.mob_image] placeholderImage:nil];
    return cell;
}
-(IBAction)clickOnSignup:(id)sender{
    signupViewController *signUpVc = [self.storyboard instantiateViewControllerWithIdentifier:@"signupViewController"];
    [self.navigationController pushViewController:signUpVc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ClickOnForgot:(id)sender{
    ForgotViewController *forgotVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotViewController"];
    [self.navigationController pushViewController:forgotVc animated:YES];
    
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    //[myActivityIndicator stopAnimating];
    NSLog(@"%@",signIn);

}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapSignIn:(id)sender {
    [NSUserDefaults.standardUserDefaults setValue:@"google" forKey:@"login"];
    [[GIDSignIn sharedInstance] signIn];
}
- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}
        
@end
