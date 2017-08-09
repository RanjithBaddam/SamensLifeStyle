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
#import "FetchSortColorModel.h"
#import "SortItemDisplayViewController.h"

@interface FetchFilterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *filterDataArray;
    NSMutableArray *indivisualFilterData;
    NSMutableArray *sizeArray;
    NSMutableArray *priceArray;
    FetchSortColorModel *fetchSortColorModel;
    NSMutableArray *fetchSortColorDataArray;
}


@end

@implementation FetchFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchFilterItemData];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchFilterItemData{
    NSLog(@"%@",[NSUserDefaults.standardUserDefaults valueForKey:@"index"]);
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]){
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
            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    self.FilterItemTableview.hidden = YES;
                });
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
    
        dispatch_async(dispatch_get_main_queue(),^{
            self.FilterItemTableview.hidden = NO;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            _FilterItemTableview.delegate = self;
            _FilterItemTableview.dataSource = self;
            [_FilterItemTableview reloadData];
        });
        }
        }
    }];
        [task resume];
    }else if([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
        sizeArray = [[NSMutableArray alloc]initWithObjects:@"S",@"M",@"L",@"XL",@"XXL", nil];
        _FilterItemTableview.dataSource = self;
        _FilterItemTableview.delegate = self;
        [_FilterItemTableview reloadData];
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
        priceArray = [[NSMutableArray alloc]initWithObjects:@"299-399",@"400-599",@"600-799",@"800-999",@"1000-1599",@"1600-1999", nil];
        _FilterItemTableview.dataSource = self;
        _FilterItemTableview.delegate = self;
        [_FilterItemTableview reloadData];
    }
    }else{
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
        });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/filteritem.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *params = [NSString stringWithFormat:@"subCatId=%@",_sortModel.sub_catid];
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
                if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        self.FilterItemTableview.hidden = YES;
                    });
                }else{
                NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                int index;
                fetchSortColorDataArray = [[NSMutableArray alloc]init];
                for (index = 0; index < dammyArray.count; index++) {
                    NSDictionary *dict = dammyArray[index];
                    fetchSortColorModel = [[FetchSortColorModel alloc]init];
                    [fetchSortColorModel FetchSortColorModelWithDictionary:dict];
                    [fetchSortColorDataArray addObject:fetchSortColorModel];
                }
                NSLog(@"%@",fetchSortColorDataArray);
               
            }
            dispatch_async(dispatch_get_main_queue(),^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [_FilterItemTableview reloadData];
                _FilterItemTableview.delegate = self;
                _FilterItemTableview.dataSource = self;
            });
            }
        }];
        [task resume];
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            sizeArray = [[NSMutableArray alloc]initWithObjects:@"S",@"M",@"L",@"XL",@"XXL", nil];
            _FilterItemTableview.dataSource = self;
            _FilterItemTableview.delegate = self;
            [_FilterItemTableview reloadData];
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
            priceArray = [[NSMutableArray alloc]initWithObjects:@"299-399",@"400-599",@"600-799",@"800-999",@"1000-1599",@"1600-1999", nil];
            _FilterItemTableview.dataSource = self;
            _FilterItemTableview.delegate = self;
            [_FilterItemTableview reloadData];
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]) {
    
     if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
    NSLog(@"%lu",(unsigned long)filterDataArray.count);
    return filterDataArray.count;
     }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
         NSLog(@"%lu",(unsigned long)sizeArray.count);
         return sizeArray.count;
     }else {
         NSLog(@"%lu",(unsigned long)priceArray.count);
         return priceArray.count;
     }
    }else{
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
            NSLog(@"%lu",(unsigned long)fetchSortColorDataArray.count);
            return fetchSortColorDataArray.count;
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            NSLog(@"%lu",(unsigned long)sizeArray.count);
            return sizeArray.count;
        }else{
            NSLog(@"%lu",(unsigned long)priceArray.count);
            return priceArray.count;
        }
        
     }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]) {
   
      if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    self.filterModel = [filterDataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = self.filterModel.color_code;
          
//          UIButton * accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
//          [accessoryButton setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
//          accessoryButton.frame = CGRectMake(0, 0, 40, 40);
//          [accessoryButton addTarget:self action:@selector(accessoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//          cell.accessoryView = accessoryButton;
//          accessoryButton.tag = indexPath.row;
      }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
         
          cell.textLabel.text = [sizeArray objectAtIndex:indexPath.row];
          [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

//          UIButton * accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
//          [accessoryButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//          accessoryButton.frame = CGRectMake(0, 0, 40, 40);
//          [accessoryButton addTarget:self action:@selector(accessoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//          cell.accessoryView = accessoryButton;
//          accessoryButton.tag = indexPath.row;

      }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
       
          cell.textLabel.text = [priceArray objectAtIndex:indexPath.row];
          [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

//          UIButton * accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
//          [accessoryButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//          accessoryButton.frame = CGRectMake(0, 0, 40, 40);
//          [accessoryButton addTarget:self action:@selector(accessoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//          cell.accessoryView = accessoryButton;
//          accessoryButton.tag = indexPath.row;

      }
}else{
 
     if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
       
          fetchSortColorModel = [fetchSortColorDataArray objectAtIndex:indexPath.row];
          cell.textLabel.text = fetchSortColorModel.color_code;
          [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

//          UIButton * accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
//          [accessoryButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//          accessoryButton.frame = CGRectMake(0, 0, 40, 40);
//          [accessoryButton addTarget:self action:@selector(accessoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//          cell.accessoryView = accessoryButton;
//          accessoryButton.tag = indexPath.row;
     }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
        
         cell.textLabel.text = [sizeArray objectAtIndex:indexPath.row];
         [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
         
         //          UIButton * accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
         //          [accessoryButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
         //          accessoryButton.frame = CGRectMake(0, 0, 40, 40);
         //          [accessoryButton addTarget:self action:@selector(accessoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
         //          cell.accessoryView = accessoryButton;
         //          accessoryButton.tag = indexPath.row;
         
     }else{
         
         cell.textLabel.text = [priceArray objectAtIndex:indexPath.row];
         [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
         
         //          UIButton * accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
         //          [accessoryButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
         //          accessoryButton.frame = CGRectMake(0, 0, 40, 40);
         //          [accessoryButton addTarget:self action:@selector(accessoryButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
         //          cell.accessoryView = accessoryButton;
         //          accessoryButton.tag = indexPath.row;
         
     }
    
}
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]) {

     if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
    self.filterModel = [filterDataArray objectAtIndex:indexPath.row];
    ItemsDisplayViewController *itemDisplayVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
         itemDisplayVc.MainSortItemId  = self.MainSortItemId;
         itemDisplayVc.sortModel = self.sortModel;
    itemDisplayVc.colorCode= self.filterModel.color_code;
         NSLog(@"%@",itemDisplayVc.colorCode);
    itemDisplayVc.CatModel = self.catModel;
         NSLog(@"%@",itemDisplayVc.CatModel);
         itemDisplayVc.categoryMainId = self.categoryMainId;
    [self.navigationController pushViewController:itemDisplayVc animated:YES];
         
     }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            ItemsDisplayViewController *itemDisplayVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
         NSArray *sizeIndexArray = [sizeArray objectAtIndex:indexPath.row ];
         NSLog(@"%@",sizeIndexArray);
         NSLog(@"%@",_catModel);
         itemDisplayVc.MainSortItemId  = self.MainSortItemId;
         itemDisplayVc.sortModel = self.sortModel;
         itemDisplayVc.categoryMainId = self.categoryMainId;
         itemDisplayVc.CatModel = _catModel;
         NSLog(@"%@",itemDisplayVc.CatModel);
         itemDisplayVc.sortModel = self.sortModel;
         NSLog(@"%@",itemDisplayVc.sortModel);
         itemDisplayVc.sizeIndexArray = sizeIndexArray;
          [self.navigationController pushViewController:itemDisplayVc animated:YES];
         
     }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
         ItemsDisplayViewController *itemDisplayVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
         NSString *priceIndex = [priceArray objectAtIndex:indexPath.row];
         itemDisplayVc.MainSortItemId  = self.MainSortItemId;
         itemDisplayVc.CatModel = _catModel;
         itemDisplayVc.categoryMainId = self.categoryMainId;
         itemDisplayVc.sortModel = self.sortModel;
         NSLog(@"%@",itemDisplayVc.sortModel);
         NSArray *separatedArray = [priceIndex componentsSeparatedByString:@"-"];
         NSArray * lastArray = [separatedArray lastObject];
         NSLog(@"%@",lastArray);
         itemDisplayVc.priceIndexArray = lastArray;
         [self.navigationController pushViewController:itemDisplayVc animated:YES];
     }
    }else{
         if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]){
         SortItemDisplayViewController *sortItemVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SortItemDisplayViewController"];
             fetchSortColorModel = [fetchSortColorDataArray objectAtIndex:indexPath.row];
             sortItemVc.categoryMainId = self.categoryMainId;
             NSLog(@"%@",self.MainSortItemId);
             sortItemVc.MainSortItemId = self.MainSortItemId;
             NSLog(@"%@",sortItemVc.MainSortItemId);
             sortItemVc.sort1MainId = self.sort1MainId;
             sortItemVc.sortDisplayModel = self.sortDisplayModel;
         sortItemVc.ColorCode1 = fetchSortColorModel.color_code;
         sortItemVc.sortModel = self.sortModel;
             sortItemVc.categoryMainId = self.categoryMainId;
         [self.navigationController pushViewController:sortItemVc animated:YES];
         }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
             SortItemDisplayViewController *sortItemVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SortItemDisplayViewController"];
             sortItemVc.categoryMainId = self.categoryMainId;
             NSArray *sizeIndexArray = [sizeArray objectAtIndex:indexPath.row ];
             NSLog(@"%@",sizeIndexArray);
             NSLog(@"%@",_catModel);
             sortItemVc.sortDisplayModel = self.sortDisplayModel;
             sortItemVc.catModel = _catModel;
             NSLog(@"%@",sortItemVc.catModel);
             sortItemVc.sortModel = self.sortModel;
             NSLog(@"%@",sortItemVc.sortModel);
             sortItemVc.sizeIndexArray = sizeIndexArray;
             sortItemVc.MainSortItemId = self.MainSortItemId;
            sortItemVc.sort1MainId = self.sort1MainId;
             sortItemVc.categoryMainId = self.categoryMainId;

             [self.navigationController pushViewController:sortItemVc animated:YES];
         }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
             SortItemDisplayViewController *sortItemVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SortItemDisplayViewController"];
             sortItemVc.categoryMainId = self.categoryMainId;
             NSString *priceIndex = [priceArray objectAtIndex:indexPath.row];
             sortItemVc.catModel = _catModel;
             sortItemVc.sortModel = self.sortModel;
             sortItemVc.sortDisplayModel = self.sortDisplayModel;
             NSLog(@"%@",sortItemVc.sortModel);
             NSArray *separatedArray = [priceIndex componentsSeparatedByString:@"-"];
             NSArray * lastArray = [separatedArray lastObject];
             NSLog(@"%@",lastArray);
             sortItemVc.MainSortItemId = self.MainSortItemId;
             sortItemVc.priceIndexArray = lastArray;
            sortItemVc.sort1MainId = self.sort1MainId;
             sortItemVc.categoryMainId = self.categoryMainId;
             [self.navigationController pushViewController:sortItemVc animated:YES];
         }
}
    }
-(IBAction)accessoryButtonPressed:(UIButton *)sender{
//    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
//    UITableViewCell* cell = [self.FilterItemTableview cellForRowAtIndexPath:selectedIndexPath];
    
    if ([sender.currentBackgroundImage isEqual:[UIImage imageNamed:@"home"]]) {

        [sender setBackgroundImage:[UIImage imageNamed:@"cancelBtn"] forState:UIControlStateNormal];

    }else{

        [sender setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];

    }
    
    

}


@end
