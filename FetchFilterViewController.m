//
//  FetchFilterViewController.m
//  samens
//
//  Created by All time Support on 24/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "FetchFilterViewController.h"
#import <MBProgressHUD.h>
#import "ItemsDisplayViewController.h"
#import "IndivisualFilterModel.h"

@interface FetchFilterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *filterDataArray;
    NSMutableArray *indivisualFilterData;
    NSMutableArray *sizeArray;
    NSMutableArray *priceArray;
    
}


@end

@implementation FetchFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchFilterItemData];
    sizeArray = [[NSMutableArray alloc]initWithObjects:@"S",@"M",@"L",@"XL",@"XXL", nil];
    priceArray = [[NSMutableArray alloc]initWithObjects:@"299-399",@"400-599",@"600-799",@"800-999",@"1000-1599",@"1600-1999", nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchFilterItemData{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
        
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/filteritem.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *params = [NSString stringWithFormat:@"subCatId=%@",_catModel.category_id];
    NSLog(@"%@",params);
    
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestData);
    [request setHTTPBody:requestData];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:30.0];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
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
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
                    alertView.tag = 002;
                    [alertView show];
                });
            }
            
        }else{
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",response);
            NSLog(@"%@",jsonData);
            NSArray *dammyArray = [jsonData valueForKey:@"categories"];
            NSLog(@"%@",dammyArray);
            int index;
            filterDataArray = [[NSMutableArray alloc]init];
            for (index = 0; index < dammyArray.count; index ++) {
                NSDictionary *dict = dammyArray[index];
                self.filterModel = [[filterItemModel alloc]init];
                [self.filterModel setFilterModelWithDictionary:dict];
                [filterDataArray addObject:_filterModel];
            }
            NSLog(@"%@",filterDataArray);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
               
            });
        }
    }];
    [task resume];
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]){
    }else{
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
    NSLog(@"%lu",(unsigned long)filterDataArray.count);
    return filterDataArray.count;
     }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
         NSLog(@"%lu",(unsigned long)sizeArray.count);
         return sizeArray.count;
     }else{
         NSLog(@"%lu",(unsigned long)priceArray.count);
         return priceArray.count;
     }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.filterModel = [filterDataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = self.filterModel.color_code;
    cell.imageView.image = [UIImage imageNamed:@"home"];
    
    NSLog(@"%@",self.filterModel.color_code);
   
    return cell;
      }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
          UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
          cell.accessoryType = UITableViewCellAccessoryCheckmark;
          cell.textLabel.text = [sizeArray objectAtIndex:indexPath.row];
          return cell;
      }else{
         UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
          cell.accessoryType = UITableViewCellAccessoryCheckmark;
          cell.textLabel.text = [priceArray objectAtIndex:indexPath.row];
          return cell;
      }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
    self.filterModel = [filterDataArray objectAtIndex:indexPath.row];
    ItemsDisplayViewController *itemDisplayVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
    itemDisplayVc.colorCode= self.filterModel.color_code;
    itemDisplayVc.CatModel = self.catModel;
    [NSUserDefaults.standardUserDefaults setValue:@"no" forKey:@"yes"];
    [self.navigationController pushViewController:itemDisplayVc animated:YES];
         
     }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            ItemsDisplayViewController *itemDisplayVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
         NSArray *sizeIndexArray = [sizeArray objectAtIndex:indexPath.row ];
         NSLog(@"%@",sizeIndexArray);
         NSLog(@"%@",_catModel);
         itemDisplayVc.CatModel = _catModel;
         NSLog(@"%@",itemDisplayVc.CatModel);
         itemDisplayVc.sizeIndexArray = sizeIndexArray;
          [self.navigationController pushViewController:itemDisplayVc animated:YES];
         
     }else{
         ItemsDisplayViewController *itemDisplayVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
         NSArray *priceIndex = [priceArray objectAtIndex:indexPath.row];
         itemDisplayVc.CatModel = _catModel;
         NSLog(@"%@",priceIndex);
         itemDisplayVc.priceIndexArray = priceIndex;
         [self.navigationController pushViewController:itemDisplayVc animated:YES];
     }
}
@end
