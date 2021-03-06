//
//  FilterViewController.m
//  samens
//
//  Created by All time Support on 12/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "FilterViewController.h"
#import <MBProgressHUD.h>
#import "filterItemModel.h"
#import "FetchFilterViewController.h"

@interface FilterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
}
@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.FilterListTableView.delegate = self;
    self.FilterListTableView.dataSource = self;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)SliderChange:(id)sender{
    UISlider *slider = (UISlider *)sender;
    NSString *newValue ;
    NSString *newValue2;
   newValue = [NSString stringWithFormat:@"%f",slider.value];
    int newValue1 = [newValue intValue];
    newValue2 = [NSString stringWithFormat:@"%d",newValue1];
    self.sliderLabel.text = newValue2;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    if (indexPath.section==0) {

        cell.imageView.image = nil;
        cell.textLabel.text = @"Color";
        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
        cell.textLabel.font  = myFont;
        cell.detailTextLabel.text = @"Select your color";
        UIFont *myFont1 = [ UIFont fontWithName: @"Arial" size: 13.0 ];
        cell.detailTextLabel.font  = myFont1;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }else if (indexPath.section==1){
        cell.imageView.image = nil;
        cell.textLabel.text = @"Size";
        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
        cell.textLabel.font  = myFont;
        cell.detailTextLabel.text = @"Select your size";
        UIFont *myFont1 = [ UIFont fontWithName: @"Arial" size: 13.0 ];
        cell.detailTextLabel.font  = myFont1;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }else if (indexPath.section==2){
        cell.imageView.image = nil;
        cell.textLabel.text = @"Price";
        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
        cell.textLabel.font  = myFont;
        cell.detailTextLabel.text = @"Select your price";
        UIFont *myFont1 = [ UIFont fontWithName: @"Arial" size: 13.0 ];
        cell.detailTextLabel.font  = myFont1;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }else if (indexPath.section==3){
        cell.imageView.image = nil;
        cell.textLabel.text = @"Size";
        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
        cell.textLabel.font  = myFont;
        cell.detailTextLabel.text = @"Price show level";
        UIFont *myFont1 = [ UIFont fontWithName: @"Arial" size: 13.0 ];
        cell.detailTextLabel.font  = myFont1;
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    } 
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]) {
    if (indexPath.section==0) {
        

        [ NSUserDefaults.standardUserDefaults setValue:@"color" forKey:@"index"];

        FetchFilterViewController *fetchFilterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FetchFilterViewController"];
        
        fetchFilterVc.catModel = self.catModel;
        [self.navigationController pushViewController:fetchFilterVc animated:YES];
    }else if (indexPath.section==1){
        [NSUserDefaults.standardUserDefaults setValue:@"size" forKey:@"index"];
     FetchFilterViewController *fetchFilterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FetchFilterViewController"];
         fetchFilterVc.catModel = self.catModel;
        fetchFilterVc.sortModel = self.sortModel;

        [self.navigationController pushViewController:fetchFilterVc animated:YES];

    }else{
        [NSUserDefaults.standardUserDefaults setValue:@"price" forKey:@"index"];
        FetchFilterViewController *fetchFilterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FetchFilterViewController"];
         fetchFilterVc.catModel = self.catModel;
        fetchFilterVc.sortModel = self.sortModel;

        [self.navigationController pushViewController:fetchFilterVc animated:YES];
    }
    }else{
        if (indexPath.section == 0) {
            [NSUserDefaults.standardUserDefaults setValue:@"color1" forKey:@"index"];
        FetchFilterViewController *fetchFilterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FetchFilterViewController"];
            fetchFilterVc.sortModel = self.sortModel;
            [self.navigationController pushViewController:fetchFilterVc animated:YES];

        }else if (indexPath.section==1){
            [NSUserDefaults.standardUserDefaults setValue:@"size" forKey:@"index"];
            FetchFilterViewController *fetchFilterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FetchFilterViewController"];
            fetchFilterVc.sortModel = self.sortModel;
            
            [self.navigationController pushViewController:fetchFilterVc animated:YES];
            
        }else{
            [NSUserDefaults.standardUserDefaults setValue:@"price" forKey:@"index"];
            FetchFilterViewController *fetchFilterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FetchFilterViewController"];
            fetchFilterVc.sortModel = self.sortModel;
            
            [self.navigationController pushViewController:fetchFilterVc animated:YES];
        }

    }
}
@end
