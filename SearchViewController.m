//
//  SearchViewController.m
//  samens
//
//  Created by All time Support on 28/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SearchViewController.h"
#import <MBProgressHUD.h>
#import "searchModel.h"
#import "ItemsDisplayViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *searchChangingArray;
    searchModel *searchListModel;
    NSMutableArray *searchDataArray;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"search";
    self.title = @"Search";
    searchBar.frame = CGRectMake(0, 0, self.navigationController.view.bounds.size.width, 64);
    searchBar.barStyle = UIBarStyleDefault;
    [searchBar setTranslucent:NO];
    searchBar.backgroundImage = [UIImage new];
    [self.view addSubview:searchBar];
    searchBar.delegate = self;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
   
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
        });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetchSearchall_item_list.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *params = [NSString stringWithFormat:@"samens=%@",searchBar.text];
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
                int index;
                searchDataArray = [[NSMutableArray alloc]init];
                for (index = 0; index < dammyArray.count; index++) {
                    NSDictionary *dict = dammyArray[index];
                    searchListModel = [[searchModel alloc]init];
                    [searchListModel getSearchDataModelWithDictionary:dict];
                    [searchDataArray addObject:searchListModel];
                }
                NSLog(@"%@",searchDataArray);
                NSLog(@"%lu",(unsigned long)searchDataArray.count);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.searchTableView.delegate =self;
                self.searchTableView.dataSource = self;
                [self.searchTableView reloadData];

            });
        }];
        [task resume];
        
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)searchDataArray.count);
    return searchDataArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    searchListModel  = [searchDataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = searchListModel.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ItemsDisplayViewController *itemDisplayVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
    searchListModel = [searchDataArray objectAtIndex:indexPath.row];
    NSLog(@"%@",searchListModel);
    NSLog(@"%@",searchListModel.name);
    itemDisplayVc.searchName = searchListModel.name;
    NSLog(@"%@",itemDisplayVc.searchName);
    [NSUserDefaults.standardUserDefaults setValue:@"search" forKey:@"Direct"];
    [self.navigationController pushViewController:itemDisplayVc animated:YES];
    
}
@end
