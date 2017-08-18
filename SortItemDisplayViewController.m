//
//  SortItemDisplayViewController.m
//  samens
//
//  Created by All time Support on 19/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SortItemDisplayViewController.h"
#import "SortDisplayModel.h"
#import "SortItemCollectionViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import <MBProgressHUD.h>
#import "ViewController.h"
#import "FilterViewController.h"
#import "SortModel.h"
#import "SortModel1.h"
#import "IndirectSortModel.h"
#import "SubSubViewController.h"
#import "SearchViewController.h"
#import "FetchSortColorModelDetails.h"
#import "FetchSortFilterSizeModel.h"
#import "PriceItemModel.h"

@interface SortItemDisplayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSMutableArray *sortMainData;
    NSMutableArray *IndirectSortMainData;
    IndirectSortModel *indirectSortModel;
    
    NSString *mainSortItemName;
    SortModel1 *sortModel1;
    NSMutableArray *sortMainData1;
    NSMutableArray *Color1DataArray;
    FetchSortColorModelDetails *fetchColor1DetailsModel;
    NSMutableArray *Size1DataArray;
    FetchSortFilterSizeModel *size1Model;
    NSMutableArray *priceDataArray1;
    PriceItemModel *priceModel1;
}

@end

@implementation SortItemDisplayViewController
-(void)viewDidAppear:(BOOL)animated{
    [_searchBar resignFirstResponder];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getSortData];
    self.SortpopupView.hidden = YES;
    UIImage *backButtonImage = [UIImage imageNamed:@"home"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:backButtonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height)];
    [backButtonView addSubview:button];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    self.navigationItem.leftBarButtonItem = customBarItem;
    self.searchBar.delegate = self;
}
-(void)getSortData{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"DirectSort"]) {
        
    
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_sub_category_item.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *params = [NSString stringWithFormat:@"subCatId=%@&cid=%@&api=%@",_MainSortItemId,[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"]];
        
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
                NSLog(@"%@",jsonData);
                if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                self.sortitemDisplayCollectionView.hidden = YES;
                                                            });
                                                        }else{
                                                        
                                                        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                                                        int index;
                                                        sortMainData = [[NSMutableArray alloc]init];
                                                        for (index=0; index<dammyArray.count; index++) {
                                                            NSDictionary *dict = dammyArray[index];
                                                        _sortDisplayModel = [[SortDisplayModel alloc]init];
                                                            [_sortDisplayModel getSortDisplay:dict];
                                                            [sortMainData addObject:_sortDisplayModel];
                                                        }
                                                        NSLog(@"%@",sortMainData);
                                                        
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            self.sortitemDisplayCollectionView.hidden = NO;
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                            self.sortitemDisplayCollectionView.delegate = self;
                                                            self.sortitemDisplayCollectionView.dataSource = self;
                                                            [self.sortitemDisplayCollectionView reloadData];
                                                        });
                                                        }
                                                    }
                                                    
                                                }];
    [task resume];
    
    }
    else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"IndirectFilter"]){
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
            });
            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
            NSURL *url=[NSURL URLWithString:urlInstring];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            NSString *params = [NSString stringWithFormat:@"subCatId=%@&c=%@&cid=%@&api=%@",_sortModel.sub_catid,_ColorCode1,[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"]];
            
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
                    NSLog(@"%@",jsonData);
                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            self.sortitemDisplayCollectionView.hidden = YES;
                        });
                    }else{
                        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                        int index;
                        Color1DataArray = [[NSMutableArray alloc]init];
                        for (index=0; index < dammyArray.count ; index++) {
                            NSDictionary *dict = dammyArray[index];
                            fetchColor1DetailsModel = [[FetchSortColorModelDetails alloc]init];
                            [fetchColor1DetailsModel getColor1DetailsModelWithDictionary:dict];
                            [Color1DataArray addObject:fetchColor1DetailsModel];
                        }
                        NSLog(@"%@",Color1DataArray);
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.sortitemDisplayCollectionView.hidden = NO;
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            self.sortitemDisplayCollectionView.delegate = self;
                            self.sortitemDisplayCollectionView.dataSource = self;
                            [self.sortitemDisplayCollectionView reloadData];
                        });
                        
                    }
                }
            }];
            [task resume];
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
            });
            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
            NSURL *url=[NSURL URLWithString:urlInstring];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            NSLog(@"%@",_sortModel.sub_catid);
            NSLog(@"%@",_sizeIndexArray);
            NSString *params = [NSString stringWithFormat:@"subCatId=%@&s=%@&cid=%@&api=%@",_sortModel.sub_catid,_sizeIndexArray,[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"]];
            
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
                    NSLog(@"%@",jsonData);
                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            self.sortitemDisplayCollectionView.hidden = YES;
                        });
                    }else{
                        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                        int index;
                        Size1DataArray = [[NSMutableArray alloc]init];
                        for (index = 0; index < dammyArray.count; index++) {
                            NSDictionary *dict = dammyArray[index];
                            size1Model = [[FetchSortFilterSizeModel alloc]init];
                            [size1Model getSortFilterSizeModelWithDictionary:dict];
                            [Size1DataArray addObject:size1Model];
                        }
                        NSLog(@"%@",Size1DataArray);
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.sortitemDisplayCollectionView.hidden = NO;
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            self.sortitemDisplayCollectionView.delegate = self;
                            self.sortitemDisplayCollectionView.dataSource = self;
                            [self.sortitemDisplayCollectionView reloadData];
                        });
                    }
                }
            }];
            [task resume];
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
            });
            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
            NSURL *url=[NSURL URLWithString:urlInstring];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            NSString *params = [NSString stringWithFormat:@"subCatId=%@&p=%@&cid=%@&api=%@",_sortModel.sub_catid,_priceIndexArray,[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"]];
            
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
                    NSLog(@"%@",jsonData);
                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            self.sortitemDisplayCollectionView.hidden = YES;
                        });
                    }else{
                        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                        int index;
                        priceDataArray1 = [[NSMutableArray alloc]init];
                        for (index = 0; index < dammyArray.count; index++) {
                            NSDictionary *dict = dammyArray[index];
                            priceModel1 = [[PriceItemModel alloc]init];
                            [priceModel1 getPriceDataModelWithDictionary:dict];
                            [priceDataArray1 addObject:priceModel1];
                        }
                        NSLog(@"%@",priceDataArray1);
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.sortitemDisplayCollectionView.hidden = NO;
                            
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            self.sortitemDisplayCollectionView.delegate = self;
                            self.sortitemDisplayCollectionView.dataSource = self;
                            [self.sortitemDisplayCollectionView reloadData];
                        });
                        
                    }
                    
                }
            }];
            [task resume];
        }
    }else{
        
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
            });
            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_sub_category_item.php"];
            NSURL *url=[NSURL URLWithString:urlInstring];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            NSString *params = [NSString stringWithFormat:@"subCatId=%@&cid=%@&api=%@",_sort1MainId,[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"]];
            
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
                    NSLog(@"%@",jsonData);
                    
                                                            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                    self.sortitemDisplayCollectionView.hidden = YES;
                                                                });
                                                            }else{
                                                            NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                                                            int index;
                                                            IndirectSortMainData = [[NSMutableArray alloc]init];
                                                            for (index=0; index<dammyArray.count; index++) {
                                                                NSDictionary *dict = dammyArray[index];
                                                                indirectSortModel = [[IndirectSortModel alloc]init];
                                                                [indirectSortModel getIndirectSortModelWithDictionary:dict];
                                                            [IndirectSortMainData addObject:indirectSortModel];
                                                            }

                                                                NSLog(@"%@",IndirectSortMainData);
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                                self.sortitemDisplayCollectionView.hidden = NO;
                                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                    self.sortitemDisplayCollectionView.delegate = self;
                                                                    self.sortitemDisplayCollectionView.dataSource = self;
                                                                    [self.sortitemDisplayCollectionView reloadData];
                                                                    
                                                                    
                                                                });

                                                            }
                                                        }
                                                        
                                                    }];
        [task resume];

        }
}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)getSortItemId:(NSString *)str{
//    NSLog(@"%@",str);
//    _MainSortItemId = str;
//   // mainSortItemName = str;
//}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"DirectSort"]) {
        
    NSLog(@"%lu",(unsigned long)sortMainData.count);
    return sortMainData.count;
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"IndirectFilter"]){
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
            return Color1DataArray.count;
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            NSLog(@"%lu",(unsigned long)Size1DataArray.count);
            return Size1DataArray.count;
        }else{
            return priceDataArray1.count;
        }
    }else{
        NSLog(@"%lu",(unsigned long)IndirectSortMainData.count);
        return IndirectSortMainData.count;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"DirectSort"]) {
        
    SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView dequeueReusableCellWithReuseIdentifier:@"SortItemCollectionViewCell" forIndexPath:indexPath];
     _sortDisplayModel = [sortMainData objectAtIndex:indexPath.item];
    NSLog(@"%@",_sortDisplayModel);
    NSLog(@"%@",_sortDisplayModel.image);
    [cell.sortItemDisplayImageView setImageWithURL:[NSURL URLWithString:_sortDisplayModel.image] placeholderImage:nil];
    cell.DisplayItemTextLabel.text = _sortDisplayModel.Name;
    cell.WishListButton.tag = indexPath.item;
    NSLog(@"%ld",(long)cell.WishListButton.tag);
    [cell.WishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"]) {
            _sortDisplayModel  = [sortMainData objectAtIndex:indexPath.item];
            
            if ([_sortDisplayModel.like_v isKindOfClass:[NSNull class]]) {
                [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
            else if ([_sortDisplayModel.like_v isEqualToString:@"N"]){
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
            else{
                        [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like1"] forState:UIControlStateNormal];
                    }
        }else{
            [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        }

    cell.StarRatingLabel.text = [NSString stringWithFormat:@"%@",_sortDisplayModel.rating];
    if ([_sortDisplayModel.offer isEqualToString:@"yes"]) {
        cell.priceLabel.text = _sortDisplayModel.off_price;
        
        NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= _sortDisplayModel.price attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                                                                 [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        
        [cell.priceOffLabel setAttributedText:priceOffString];
        NSString *string = cell.priceLabel.text;
        NSLog(@"%@",string);
        float value = [string floatValue];
        NSString *string1 = cell.priceOffLabel.text;
        NSLog(@"%@",string1);
        float value1 = [string1 floatValue];
        float pers = 100;
        float percentage = (value * pers)/value1;
        NSLog(@"%f",percentage);
        int totalValue = pers - percentage;
        NSLog(@"%d",totalValue);
        NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
        NSLog(@"%@",persentage);
        cell.offerLabel.text = persentage;
        NSLog(@"%@",cell.offerLabel.text);
        cell.offerLabel.hidden = NO;
        cell.offerLabel.layer.cornerRadius = 13;
        cell.offerLabel.clipsToBounds = YES;
        return cell;

    
    }else{
        cell.offerLabel.hidden = YES;
        cell.priceLabel.text = _sortDisplayModel.price;
        cell.priceOffLabel.text = nil;
        cell.offerLabel.text = nil;
        return cell;

    }
    }
    else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"IndirectFilter"]){
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
            SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView dequeueReusableCellWithReuseIdentifier:@"SortItemCollectionViewCell" forIndexPath:indexPath ];
            fetchColor1DetailsModel = [Color1DataArray objectAtIndex:indexPath.item];
            NSLog(@"%@",fetchColor1DetailsModel.image);
            NSLog(@"%@",fetchColor1DetailsModel.Name);
            [cell.sortItemDisplayImageView setImageWithURL:[NSURL URLWithString:fetchColor1DetailsModel.image] placeholderImage:nil];
            cell.DisplayItemTextLabel.text = fetchColor1DetailsModel.Name;
            cell.WishListButton.tag = indexPath.item;
            NSLog(@"%ld",(long)cell.WishListButton.tag);
            [cell.WishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
            if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"]) {
                fetchColor1DetailsModel  = [Color1DataArray objectAtIndex:indexPath.item];
                
                if ([fetchColor1DetailsModel.like_v isKindOfClass:[NSNull class]]) {
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
                else if ([fetchColor1DetailsModel.like_v isEqualToString:@"N"]){
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
                else{
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like1"] forState:UIControlStateNormal];
                }
            }else{
                [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            }
            cell.StarRatingLabel.text = [NSString stringWithFormat:@"%@",fetchColor1DetailsModel.rating];
            if ([fetchColor1DetailsModel.offer isEqualToString:@"yes"]) {
                cell.priceLabel.text = fetchColor1DetailsModel.off_price;
                
                NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= fetchColor1DetailsModel.price attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                                                                                       [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
                [cell.priceOffLabel setAttributedText:priceOffString];
                NSString *string = cell.priceLabel.text;
                NSLog(@"%@",string);
                float value = [string floatValue];
                NSString *string1 = cell.priceOffLabel.text;
                NSLog(@"%@",string1);
                float value1 = [string1 floatValue];
                float pers = 100;
                float percentage = (value * pers)/value1;
                NSLog(@"%f",percentage);
                int totalValue = pers - percentage;
                NSLog(@"%d",totalValue);
                NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
                NSLog(@"%@",persentage);
                cell.offerLabel.text = persentage;
                NSLog(@"%@",cell.offerLabel.text);
                cell.offerLabel.hidden = NO;
                cell.offerLabel.layer.cornerRadius = 13;
                cell.offerLabel.clipsToBounds = YES;
                return cell;
                
            }else{
                cell.offerLabel.hidden = YES;
                cell.priceLabel.text = fetchColor1DetailsModel.price;
                cell.priceOffLabel.text = nil;
                cell.offerLabel.text = nil;
                return cell;
            }
            
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView dequeueReusableCellWithReuseIdentifier:@"SortItemCollectionViewCell" forIndexPath:indexPath ];
            size1Model = [Size1DataArray objectAtIndex:indexPath.item];
            NSLog(@"%@",size1Model.image);
            NSLog(@"%@",size1Model.Name);
            [cell.sortItemDisplayImageView setImageWithURL:[NSURL URLWithString:size1Model.image] placeholderImage:nil];
            cell.DisplayItemTextLabel.text = size1Model.Name;
            cell.WishListButton.tag = indexPath.item;
            NSLog(@"%ld",(long)cell.WishListButton.tag);
            [cell.WishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
            if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"]) {
                size1Model  = [Size1DataArray objectAtIndex:indexPath.item];
                
                if ([size1Model.like_v isKindOfClass:[NSNull class]]) {
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
                else if ([size1Model.like_v isEqualToString:@"N"]){
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
                else{
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like1"] forState:UIControlStateNormal];
                }
            }else{
                [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            }
            
            cell.StarRatingLabel.text = [NSString stringWithFormat:@"%@",size1Model.rating];
            if ([size1Model.offer isEqualToString:@"yes"]) {
                cell.priceLabel.text = size1Model.off_price;
                
                NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= size1Model.price attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                                                                          [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
                [cell.priceOffLabel setAttributedText:priceOffString];
                NSString *string = cell.priceLabel.text;
                NSLog(@"%@",string);
                float value = [string floatValue];
                NSString *string1 = cell.priceOffLabel.text;
                NSLog(@"%@",string1);
                float value1 = [string1 floatValue];
                float pers = 100;
                float percentage = (value * pers)/value1;
                NSLog(@"%f",percentage);
                int totalValue = pers - percentage;
                NSLog(@"%d",totalValue);
                NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
                NSLog(@"%@",persentage);
                cell.offerLabel.text = persentage;
                NSLog(@"%@",cell.offerLabel.text);
                cell.offerLabel.hidden = NO;
                cell.offerLabel.layer.cornerRadius = 13;
                cell.offerLabel.clipsToBounds = YES;
                return cell;
                
            }else{
                cell.offerLabel.hidden = YES;
                cell.priceLabel.text = size1Model.price;
                cell.priceOffLabel.text = nil;
                cell.offerLabel.text = nil;
                return cell;
            }
            
        }else{
            SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView dequeueReusableCellWithReuseIdentifier:@"SortItemCollectionViewCell" forIndexPath:indexPath ];
            priceModel1 = [priceDataArray1 objectAtIndex:indexPath.item];
            NSLog(@"%@",priceModel1.image);
            NSLog(@"%@",priceModel1.Name);
            [cell.sortItemDisplayImageView
             setImageWithURL:[NSURL URLWithString:priceModel1.image] placeholderImage:nil];
            cell.DisplayItemTextLabel.text = priceModel1.Name;
            cell.WishListButton.tag = indexPath.item;
            NSLog(@"%ld",(long)cell.WishListButton.tag);
            [cell.WishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
            if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"]) {
                priceModel1  = [priceDataArray1 objectAtIndex:indexPath.item];
                
                if ([priceModel1.like_v isKindOfClass:[NSNull class]]) {
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
                else if ([priceModel1.like_v isEqualToString:@"N"]){
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
                else{
                    [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like1"] forState:UIControlStateNormal];
                }
            }else{
                [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            }
          
            cell.StarRatingLabel.text = [NSString stringWithFormat:@"%@",priceModel1.rating];
            if ([priceModel1.offer isEqualToString:@"yes"]) {
                cell.priceLabel.text = priceModel1.off_price;
                
                NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= priceModel1.price attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                                                                           [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
                [cell.priceOffLabel setAttributedText:priceOffString];
                NSString *string = cell.priceLabel.text;
                NSLog(@"%@",string);
                float value = [string floatValue];
                NSString *string1 = cell.priceOffLabel.text;
                NSLog(@"%@",string1);
                float value1 = [string1 floatValue];
                float pers = 100;
                float percentage = (value * pers)/value1;
                NSLog(@"%f",percentage);
                int totalValue = pers - percentage;
                NSLog(@"%d",totalValue);
                NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
                NSLog(@"%@",persentage);
                cell.offerLabel.text = persentage;
                NSLog(@"%@",cell.offerLabel.text);
                cell.offerLabel.hidden = NO;
                cell.offerLabel.layer.cornerRadius = 13;
                cell.offerLabel.clipsToBounds = YES;
                return cell;
                
            }else{
                cell.offerLabel.hidden = YES;
                cell.priceLabel.text = priceModel1.price;
                cell.priceOffLabel.text = nil;
                cell.offerLabel.text = nil;
                return cell;
            }
        }
    }
    else{
        SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView dequeueReusableCellWithReuseIdentifier:@"SortItemCollectionViewCell" forIndexPath:indexPath];
        indirectSortModel = [IndirectSortMainData objectAtIndex:indexPath.item];
        NSLog(@"%@",IndirectSortMainData);
        NSLog(@"%@",indirectSortModel.image);
        NSLog(@"%@",indirectSortModel.Name);
        [cell.sortItemDisplayImageView setImageWithURL:[NSURL URLWithString:indirectSortModel.image] placeholderImage:nil];
        cell.DisplayItemTextLabel.text = indirectSortModel.Name;
        cell.WishListButton.tag = indexPath.item;
        NSLog(@"%ld",(long)cell.WishListButton.tag);
        [cell.WishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"]) {
            indirectSortModel  = [IndirectSortMainData objectAtIndex:indexPath.item];
            
            if ([indirectSortModel.like_v isKindOfClass:[NSNull class]]) {
                [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
            else if ([indirectSortModel.like_v isEqualToString:@"N"]){
                [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];        }
            else{
                [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like1"] forState:UIControlStateNormal];
            }
        }else{
            [cell.wishListButton setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        }

        cell.StarRatingLabel.text = [NSString stringWithFormat:@"%@",indirectSortModel.rating];
        if ([indirectSortModel.offer isEqualToString:@"yes"]) {
            cell.priceLabel.text = indirectSortModel.off_price;
            
            NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= indirectSortModel.price attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                                                                 [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
            [cell.priceOffLabel setAttributedText:priceOffString];
            NSString *string = cell.priceLabel.text;
            NSLog(@"%@",string);
            float value = [string floatValue];
            NSString *string1 = cell.priceOffLabel.text;
            NSLog(@"%@",string1);
            float value1 = [string1 floatValue];
            float pers = 100;
            float percentage = (value * pers)/value1;
            NSLog(@"%f",percentage);
            int totalValue = pers - percentage;
            NSLog(@"%d",totalValue);
            NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
            NSLog(@"%@",persentage);
            cell.offerLabel.text = persentage;
            NSLog(@"%@",cell.offerLabel.text);
            cell.offerLabel.hidden = NO;
            cell.offerLabel.layer.cornerRadius = 13;
            cell.offerLabel.clipsToBounds = YES;
            return cell;
            
            
        }else{
            cell.offerLabel.hidden = YES;
            cell.priceLabel.text = indirectSortModel.price;
            cell.priceOffLabel.text = nil;
            cell.offerLabel.text = nil;
            return cell;
            
        }

    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"DirectSort"]) {
        SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
        _sortDisplayModel = [sortMainData objectAtIndex:indexPath.item];
        NSLog(@"%@",_sortDisplayModel.pid);
        [subsubVc getId:_sortDisplayModel.pid];
        [subsubVc getColor_code:_sortDisplayModel.color_code];
        
        [subsubVc getItemName:_sortDisplayModel.Name];
        NSLog(@"%@",_sortDisplayModel.Name);
        [subsubVc getItemPrice:_sortDisplayModel.price];
        [self.navigationController pushViewController:subsubVc animated:YES];
        
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"IndirectFilter"]){
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
            fetchColor1DetailsModel = [Color1DataArray objectAtIndex:indexPath.item];
            
            [subsubVc getId:fetchColor1DetailsModel.pid];
            [subsubVc getColor_code:fetchColor1DetailsModel.color_code];
            
            [subsubVc getItemName:fetchColor1DetailsModel.Name];
            NSLog(@"%@",fetchColor1DetailsModel.Name);
            [subsubVc getItemPrice:fetchColor1DetailsModel.price];
            [self.navigationController pushViewController:subsubVc animated:YES];
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
            size1Model = [Size1DataArray objectAtIndex:indexPath.item];
            
            [subsubVc getId:size1Model.pid];
            [subsubVc getColor_code:size1Model.color_code];
            
            [subsubVc getItemName:size1Model.Name];
            NSLog(@"%@",size1Model.Name);
            [subsubVc getItemPrice:size1Model.price];
            [self.navigationController pushViewController:subsubVc animated:YES];
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
            priceModel1 = [priceDataArray1 objectAtIndex:indexPath.item];
            
            [subsubVc getId:priceModel1.pid];
            [subsubVc getColor_code:priceModel1.color_code];
            
            [subsubVc getItemName:priceModel1.Name];
            NSLog(@"%@",priceModel1.Name);
            [subsubVc getItemPrice:priceModel1.price];
            [self.navigationController pushViewController:subsubVc animated:YES];
        }
        
    }
    else{
        SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
         indirectSortModel = [IndirectSortMainData objectAtIndex:indexPath.item];
        NSLog(@"%@",indirectSortModel.pid);
        [subsubVc getId:indirectSortModel.pid];
        [subsubVc getColor_code:indirectSortModel.color_code];
        
        [subsubVc getItemName:indirectSortModel.Name];
        NSLog(@"%@",indirectSortModel.Name);
        [subsubVc getItemPrice:indirectSortModel.price];
        [self.navigationController pushViewController:subsubVc animated:YES];
    }
    
}
-(void)getSortItemName:(NSString *)nameStr{
    mainSortItemName = nameStr;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 001) {
        [self viewDidLoad];
    }else{
        [self viewDidLoad];
    }
}
-(IBAction)ClickOnWishlist:(UIButton *)sender{
    
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"])
    {
        NSArray *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"WishListData"];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"WishListData"]);
        
        _sortDisplayModel = [sortMainData objectAtIndex:sender.tag];
        NSLog(@"%@",_sortDisplayModel.pid);
        NSArray *token1 = [token valueForKey:@"pid"];
        NSLog(@"%@",token1);
        if ([token1 containsObject:_sortDisplayModel.pid]) {
            dispatch_async(dispatch_get_main_queue(), ^{

        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
        hud.label.text = strloadingText;
            });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/send_indivi_like.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];

        _sortDisplayModel = [sortMainData objectAtIndex:sender.tag];
        
        NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&status=%@&pid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"Y",_sortDisplayModel.pid];
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
                
                if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                        SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView cellForItemAtIndexPath:selectedIndexPath];
                        cell.WishListButton.backgroundColor = [UIColor whiteColor];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                        });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                        SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView cellForItemAtIndexPath:selectedIndexPath];
                        cell.WishListButton.backgroundColor = [UIColor redColor];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User Wishlist" message:@"Successfully Added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];

                        
                    });
                }
                
                
            }
            
            
        }];
        [task resume];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
                hud.label.text = strloadingText;
            });
            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/send_indivi_like.php"];
            NSURL *url=[NSURL URLWithString:urlInstring];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            _sortDisplayModel = [sortMainData objectAtIndex:sender.tag];
            
            NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&status=%@&pid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"Y",_sortDisplayModel.pid];
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
                    
                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                            SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView cellForItemAtIndexPath:selectedIndexPath];
                            cell.WishListButton.backgroundColor = [UIColor redColor];
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                        });
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                            SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView cellForItemAtIndexPath:selectedIndexPath];
                            cell.WishListButton.backgroundColor = [UIColor whiteColor];
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User Wishlist" message:@"Successfully Added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            
                        });
                    }
                    
                    
                }
                
                
            }];
            [task resume];
            
        }

    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login" message:@"Please logIn " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        ViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(IBAction)clickOnSort:(id)sender{
    [NSUserDefaults.standardUserDefaults setValue:@"Indirectsort" forKey:@"Sort"];
    self.SortpopupView.hidden = NO;
    [self sortPopUPData];
    self.popupTextLabel.text = _PopUpNameText;
}
-(void)sortPopUPData{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"Indirectsort"]) {

    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"554194aa-7dc1-9888-889c-d059e4257252" };
    NSArray *parameters = @[ @{ @"name": @"cid", @"value": _categoryMainId } ];
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
        NSLog(@"%@",parameters);
    
    NSError *error;
    NSMutableString *body = [NSMutableString string];
    for (NSDictionary *param in parameters) {
        [body appendFormat:@"--%@\r\n", boundary];
        if (param[@"fileName"]) {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", param[@"name"], param[@"fileName"]];
            [body appendFormat:@"Content-Type: %@\r\n\r\n", param[@"contentType"]];
            [body appendFormat:@"%@", [NSString stringWithContentsOfFile:param[@"fileName"] encoding:NSUTF8StringEncoding error:&error]];
            if (error) {
                NSLog(@"%@", error);
            }
        } else {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
            [body appendFormat:@"%@", param[@"value"]];
        }
    }
    [body appendFormat:@"\r\n--%@--\r\n", boundary];
    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
    hud.label.text = strloadingText;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/search_sub_category.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            id sortData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                    dispatch_async(dispatch_get_main_queue(),^{
                                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    });
                                                    
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                        _sortTableView.hidden = YES;
                                                        if ([error.localizedDescription isEqualToString:@"The request timed out."]){
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
                                                                alertView.tag = 001;
                                                                [alertView show];
                                                            });
                                                        }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
                                                            dispatch_async(dispatch_get_main_queue(),^{
                                                                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                                                [alertView show];
                                                            });
                                                        }
                                                        
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                    

                                                    NSLog(@"%@",sortData);
                                                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                            self.sortTableView.hidden = YES;
                                                        });
                                                    }else{
                                                    
                                                    NSArray *sortDammyArr = [sortData valueForKey:@"category"];
                                                    sortMainData1 = [[NSMutableArray alloc]init];
                                                    int index;
                                                    for (index=0; index<sortDammyArr.count; index++) {
                                                        NSDictionary *dict = sortDammyArr[index];
                                                        sortModel1 = [[SortModel1 alloc]init];
                                                        [sortModel1 getSort1ModelWithDictionary:dict];
                                                        [sortMainData1 addObject:sortModel1];
                                                        
                                                    }
                                                        NSLog(@"%@",sortMainData1);
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        self.sortTableView.hidden = NO;
                                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                        self.sortTableView.delegate = self;
                                                        self.sortTableView.dataSource = self;
                                                        [self.sortTableView reloadData];
                                                    });
                                                    }
                                                    }
                                                }];
    [dataTask resume];
    }else{
        
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sortMainData1.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    sortModel1 = [sortMainData1 objectAtIndex:indexPath.row];
    NSLog(@"%@",sortModel1);
    cell.textLabel.text = sortModel1.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    sortModel1 = [sortMainData1 objectAtIndex:indexPath.row];
    _sort1MainId = sortModel1.sub_catid;
    NSLog(@"%@",_sort1MainId);
    [self getSortData];
    self.SortpopupView.hidden = YES;
}


-(IBAction)clickOnFilter:(id)sender{
    [NSUserDefaults.standardUserDefaults setValue:@"IndirectFilter" forKey:@"Sort"];
    FilterViewController *filterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
    NSLog(@"%@",_sortDisplayModel);
    filterVc.sortDisplayModel = self.sortDisplayModel;
    NSLog(@"%@",filterVc.sortDisplayModel);
    filterVc.sort1MainId = self.sort1MainId;
    filterVc.categoryMainId = self.categoryMainId;
    filterVc.MainSortItemId = self.MainSortItemId;
    NSLog(@"%@",self.sortModel);
    filterVc.sortModel = self.sortModel;
    NSLog(@"%@",filterVc.sortModel);
    
    [self.navigationController pushViewController:filterVc animated:YES];
}

-(IBAction)ClickOnSortPopUpClose:(id)sender{
    self.SortpopupView.hidden = YES;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController *searchBarVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [self.navigationController pushViewController:searchBarVc animated:YES];
    return NO;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.frame.size.width/2)-0.5, 342);
}

@end
