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

@interface WishlistViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    WishlistModel *wishlistModel;
    NSMutableArray *wishListDataArray;
    IBOutlet UIImageView *emptyWishlistImage;
}

@end

@implementation WishlistViewController
-(void)viewWillAppear:(BOOL)animated{
[self FetchWishlistData];
//    if (wishListDataArray.count==0) {
//        _wishlistTableView.hidden = YES;
//        emptyWishlistImage.hidden = NO;
//    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)FetchWishlistData{
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
            [_wishlistTableView reloadData];
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",jsonData);
            NSArray *dammyArray = [jsonData valueForKey:@"categories"];
            int index;
            wishListDataArray = [[NSMutableArray alloc]init];
            for (index=0; index<dammyArray.count; index++) {
                NSDictionary *dict = dammyArray[index];
                wishlistModel = [[WishlistModel alloc]init];
                [wishlistModel getWishListModelWithDictionary:dict];
                [wishListDataArray addObject:wishlistModel];
                NSLog(@"%@",wishListDataArray);
               
            }
                if (wishListDataArray.count==0) {
                    _wishlistTableView.hidden = YES;
                    emptyWishlistImage.hidden = NO;
                }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.wishlistTableView.delegate = self;
                self.wishlistTableView.dataSource = self;
                [self.wishlistTableView reloadData];
                
            });
        }
    }];
    [task resume];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSInteger sections = [self.wishlistTableView numberOfSections];
//    BOOL hasRows = NO;
//    for (int i = 0; i < sections; i++) {
//        BOOL sectionHasRows = ([self.wishlistTableView numberOfRowsInSection:i] > 0) ? YES : NO;
//        if (sectionHasRows) {
//            hasRows = YES;
//            break;
//        }
//    }
//    
//    if (sections == 0 || hasRows == NO)
//    {
//        UIImage *image = [UIImage imageNamed:@"emptywishlist"];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        
//        // Add image view on top of table view
//        [self.wishlistTableView addSubview:imageView];
//        
//        // Set the background view of the table view
//        self.wishlistTableView.backgroundView = imageView;
//    }
//    return sections;
    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)wishListDataArray.count);
    return wishListDataArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WishlistTableViewCell *cell = [_wishlistTableView dequeueReusableCellWithIdentifier:@"WishlistTableViewCell"];
    wishlistModel = [wishListDataArray objectAtIndex:indexPath.row];
    [cell.productImage setImageWithURL:[NSURL URLWithString:wishlistModel.image] placeholderImage:nil];
    cell.NameLabel.text = wishlistModel.Name;
    NSLog(@"%@",wishlistModel.Name);
    cell.rateLabel.text = wishlistModel.price;
    NSLog(@"%@",wishlistModel.price);
    cell.quantityLabel.text = wishlistModel.quantity;
    NSLog(@"%@",cell.quantityLabel.text);
    NSLog(@"%@",wishlistModel.rate);
    cell.ratingLabel.text = [NSString stringWithFormat:@"%@",wishlistModel.rate];
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
    wishlistModel = [wishListDataArray objectAtIndex:sender.tag];
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
                    [wishListDataArray removeObjectAtIndex:sender.tag];
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
@end
