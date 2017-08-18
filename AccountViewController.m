 //
//  AccountViewController.m
//  samens
//
//  Created by All time Support on 16/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AccountViewController.h"
#import "ViewController.h"
#import "TermsAndConditionsViewController.h"
#import "SupportViewController.h"
#import "AccountSettingViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "homeViewController.h"

@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate>{
    NSMutableArray *ImgArray,*secImgArray;
    NSMutableArray *firstSectionArray;
    NSMutableArray *detailArray;
    NSMutableArray *secSectionArray;
    NSMutableArray *thirdSectionArray;
    NSMutableArray *fourthSectionArray;
    NSMutableArray *fifthSectionArray;
    NSMutableArray *wishlistArray;
   
   
}

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setHidesBackButton:YES];
        self.scrollView.contentSize = CGSizeMake(414, 718);
        
        ImgArray = [[NSMutableArray alloc]initWithObjects:@"cancelBtn", nil];
        secImgArray = [[NSMutableArray alloc]initWithObjects:@"home", nil];
        firstSectionArray = [[NSMutableArray alloc]initWithObjects:@"Sign in", nil];
        detailArray = [[NSMutableArray alloc]initWithObjects:@"View your order,wallet balance,etc", nil];
        
        secSectionArray = [[NSMutableArray alloc]initWithObjects:@"Track Order", nil];
        thirdSectionArray = [[NSMutableArray alloc]initWithObjects:@"Help Center",@"My Rewards",@"Rate the App",@"Send Feedback", nil];
        fourthSectionArray = [[NSMutableArray alloc]initWithObjects:@"Clear History",@"Legal", nil];
        fifthSectionArray = [[NSMutableArray alloc]initWithObjects:@"Terms and Conditions",@"Support",@"About", nil];
        
        self.AccountTableView.delegate = self;
        self.AccountTableView.dataSource = self;
    self.tabBarController.delegate = self;
    
   
}
-(void)viewWillAppear:(BOOL)animated{

    [_AccountTableView reloadData];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickOnSignIn:(id)sender{
    ViewController *loginVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:loginVc animated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }else if (section ==2){
        return thirdSectionArray.count;
    }else if (section==3){
        return fourthSectionArray.count;
    }else if (section==4){
        return fifthSectionArray.count;
    }else{
        return 1;
    }
    return section;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
            cell.textLabel.text = @"Account";
            cell.imageView.image = [UIImage imageNamed:@""];
            cell.detailTextLabel.text = [NSUserDefaults.standardUserDefaults valueForKey:@"name"];
            
        }else{
            cell.textLabel.text = @"Sign In";
            cell.detailTextLabel.text = @"View your orders wallet balance etc.";
            cell.imageView.image = [UIImage imageNamed:@""];
        }
        }else{
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
                cell.textLabel.text = @"Sign Out";
                cell.imageView.image = [UIImage imageNamed:@""];
                cell.detailTextLabel.text = [NSUserDefaults.standardUserDefaults valueForKey:@"name"];
                
            }else{
                cell.textLabel.text = @"Account";
                cell.detailTextLabel.text = @"View your orders wallet balance etc.";
                cell.imageView.image = [UIImage imageNamed:@""];
            }

        }
        
    }else if (indexPath.section==1){
        if (indexPath.row==0) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
                cell.textLabel.text = @"My Wallet";
            }else{
                cell.textLabel.text = @"Track Order";
            }
        }else{
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
                cell.textLabel.text = @"My orders";
            }else{
                cell.textLabel.text = nil;
            }
        }
        
       
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
                cell.textLabel.text = @"Help Center";
            }else{
                cell.textLabel.text = @"Help Center";
            }
        }
        
    else if (indexPath.row==1){
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
            cell.textLabel.text = @"My Rewards";
        }else{
            cell.textLabel.text = @"My Rewards";
        }
    }
    else if (indexPath.row ==2){
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
            cell.textLabel.text = @"Rate the App";
        }else{
            cell.textLabel.text = @"Rate the App";
        }
    }else if (indexPath.row ==3){
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
            cell.textLabel.text = @"Send Feedback";
        }else{
            cell.textLabel.text = @"Send Feedback";
        }
    }
    }else if (indexPath.section==3){
        if (indexPath.row==0) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
                cell.textLabel.text = @"Account Setting";
            }else{
                cell.textLabel.text = @"Clear History";
            }
        }
        
    else if (indexPath.row == 1){
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){
            cell.textLabel.text = @"Clear History";
        }else{
            cell.textLabel.text = @"Legal";
        }
    }
    }else if (indexPath.section==4){
        if (indexPath.row==0) {
             cell.textLabel.text = @"Terms And Conditions";
        }else if (indexPath.row==1){
            cell.textLabel.text = @"Support";
            
        }else{
            cell.textLabel.text = @"About";
        }
    }
    else{
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]){

        cell.textLabel.text = [NSUserDefaults.standardUserDefaults valueForKey:@"name"];
        }else{
            cell.textLabel.text = nil;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row==0) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]) {
            AccountSettingViewController *accoutSettingVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountSettingViewController"];
            [self.navigationController pushViewController:accoutSettingVc animated:YES];
            
        }else{
            ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        }else if (indexPath.row==1){
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoggedIn"] isEqualToString:@"yes"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"SignOut" message:@"You want to SignOut" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"SignOut", nil];
            [alert show];
            alert.tag = 100;
        }
        else{

            [self.navigationController popViewControllerAnimated:YES];
        }
        }

    }else if (indexPath.section==4){
        if (indexPath.row==0) {
            TermsAndConditionsViewController *termsAndConditionVc = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndConditionsViewController"];
            [self.navigationController pushViewController:termsAndConditionVc animated:YES];
        }else if (indexPath.row==1){
            SupportViewController *supportVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SupportViewController" ];
            [self.navigationController pushViewController:supportVc animated:YES];
        }
      
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     if (alertView.tag == 100){
        if (buttonIndex == 1){
           
            [[NSUserDefaults standardUserDefaults] setValue:@"no" forKey:@"LoggedIn"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"api"] ;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"custid"];
           [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"dor"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mobile"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pass"];

            
            [_AccountTableView reloadData];
            
            
        }
    }
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"Selected INDEX OF TAB-BAR ==> %lu", (unsigned long)tabBarController.selectedIndex);
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"no"]) {
    if (tabBarController.selectedIndex == 3) {
        [_AccountTableView reloadData];
    }else if (tabBarController.selectedIndex == 2){
        [self.tabBarController setSelectedIndex:3];
        [_AccountTableView reloadData];
    }else if (tabBarController.selectedIndex == 4){
        [self.tabBarController setSelectedIndex:3];
    }else if (tabBarController.selectedIndex == 0){
        [self.tabBarController setSelectedIndex:0];
    }else{
        [self.tabBarController setSelectedIndex:3];
    }
    }else{
        if (tabBarController.selectedIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
            
        }else if (tabBarController.selectedIndex == 1){
            [self.tabBarController setSelectedIndex:1];
            
        }else if (tabBarController.selectedIndex == 2){
            [self.tabBarController setSelectedIndex:2];
        }else if (tabBarController.selectedIndex == 3){
            [self.tabBarController setSelectedIndex:3];
        }else{
            [self.tabBarController setSelectedIndex:4];
        }
    }
}
@end
