//
//  WishlistViewController.m
//  samens
//
//  Created by All time Support on 04/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "WishlistViewController.h"
#import <MBProgressHUD.h>
#import "WishlistModel.h"
#import "WishlistTableViewCell.h"
#import <MBProgressHUD.h>
#import <UIImageView+AFNetworking.h>
#import "ViewController.h"
#import "AccountViewController.h"


@interface WishlistViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITabBarControllerDelegate>{
    WishlistModel *wishlistModel;
    IBOutlet UIImageView *emptyWishlistImage;
}

@end

@implementation WishlistViewController
-(void)viewWillAppear:(BOOL)animated{
//    if (wishListDataArray.count==0) {
//        _wishlistTableView.hidden = YES;
//        emptyWishlistImage.hidden = NO;
//    }
    [self FetchWishlistData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarController.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)FetchWishlistData{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"]){
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/wishlist.php"];
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
            _wishlistTableView.hidden = YES;
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
//            [_wishlistTableView reloadData];
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",jsonData);
            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    _wishlistTableView.hidden = YES;
                    emptyWishlistImage.hidden = NO;
                });
            }else{
            _dammyArray1 = [[NSMutableArray alloc]init];
            _dammyArray1  = [jsonData valueForKey:@"categories"];
            NSLog(@"%@",_dammyArray1);

            int index;
            _wishListDataArray = [[NSMutableArray alloc]init];
            for (index=0; index<_dammyArray1.count; index++) {
                NSDictionary *dict = _dammyArray1[index];
                wishlistModel = [[WishlistModel alloc]init];
                [wishlistModel getWishListModelWithDictionary:dict];
                [_wishListDataArray addObject:wishlistModel];
            }
            NSLog(@"%@",_wishListDataArray);
            
                if (_wishListDataArray.count==0) {
                    _wishlistTableView.hidden = YES;
                    emptyWishlistImage.hidden = NO;
                }
            dispatch_async(dispatch_get_main_queue(), ^{
                _wishlistTableView.hidden = NO;
                emptyWishlistImage.hidden = YES;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.wishlistTableView.delegate = self;
                self.wishlistTableView.dataSource = self;
                [self.wishlistTableView reloadData];
                
            });
            }
        }
    }];
    [task resume];
    }else{
        
        [self.tabBarController setSelectedIndex:3];

    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)_wishListDataArray.count);
    return _wishListDataArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WishlistTableViewCell *cell = [_wishlistTableView dequeueReusableCellWithIdentifier:@"WishlistTableViewCell"];
    wishlistModel = [_wishListDataArray objectAtIndex:indexPath.row];
    if ([wishlistModel.image isKindOfClass:[NSNull class]]) {
        cell.imageView.image = [UIImage imageNamed:@"bell"];
    }else{
    [cell.productImage setImageWithURL:[NSURL URLWithString:wishlistModel.image] placeholderImage:nil];
    }
    if ([wishlistModel.Name isKindOfClass:[NSNull class]]) {
        cell.NameLabel.text =@"null";
    }else{
        NSLog(@"%@",wishlistModel.Name);
    cell.NameLabel.text = wishlistModel.Name;
    }
    if ([wishlistModel.price isKindOfClass:[NSNull class]]) {
        cell.rateLabel.text = @"null";
    }else{
        cell.rateLabel.text = wishlistModel.price;
    }
    if ([wishlistModel.quantity isKindOfClass:[NSNull class]]) {
        cell.quantityLabel.text = @"null";
    }else{
   
    cell.quantityLabel.text = wishlistModel.quantity;
    }
    if ([wishlistModel.rate isKindOfClass:[NSNull class]]) {
        cell.rateLabel.text = @"Null";
    }else{
    NSLog(@"%@",wishlistModel.rate);
    cell.ratingLabel.text = [NSString stringWithFormat:@"%@",wishlistModel.rate];
    }
    [cell.RemoveButton addTarget:self action:@selector(clickOnRemoveFromWishlist:) forControlEvents:UIControlEventTouchUpInside];
    cell.RemoveButton.tag = indexPath.row;
    
    
    
    return cell;
    
}

-(IBAction)clickOnRemoveFromWishlist:(UIButton *)sender{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/delete_wishlist.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    wishlistModel = [_wishListDataArray objectAtIndex:sender.tag];
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&pid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],wishlistModel.pid];
    NSLog(@"%@",params);
    
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestData);
    [request setHTTPBody:requestData];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:30.0];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
            NSLog(@"%@",response);
            NSLog(@"%@",jsonData);
            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:1]]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [_wishListDataArray removeObjectAtIndex:sender.tag];
                    [_wishlistTableView reloadData];
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"User successfully deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [self FetchWishlistData];
                    
                });
                
            }
    }
    }];
    [task resume];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 001) {
        [self FetchWishlistData];
    }else{
        [self FetchWishlistData];
    }
}
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"Selected INDEX OF TAB-BAR ==> %lu", (unsigned long)tabBarController.selectedIndex);
    
    if (tabBarController.selectedIndex == 2) {
       
    }
}



@end
