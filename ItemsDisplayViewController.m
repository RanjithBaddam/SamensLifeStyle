//
//  ItemsDisplayViewController.m
//  samens
//
//  Created by All time Support on 10/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "ItemsDisplayViewController.h"
#import "SubCategoryModel.h"
#import "DisplayItemsCollectionViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "SortModel.h"
#import "FilterViewController.h"
#import "SubSubViewController.h"
#import "SortItemDisplayViewController.h"
#import "ItemSizeViewController.h"
#import "WishlistViewController.h"
#import <MBProgressHUD.h>
#import "ViewController.h"
#import "IndivisualFilterModel.h"



@interface ItemsDisplayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *sortMainData;
    NSString *categoryMainName;
    UILabel *headerLabel;
    NSString *getMainSortId;
    NSString *PopUpNameText;
    NSString *priceMainId;
    NSString *pidMainId;
    NSMutableArray *indivisualFilterDataArray;
}

@end

@implementation ItemsDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = categoryMainName;
    
   
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(clickOnTap:)];
//    [self.view addGestureRecognizer:singleTap];

    self.sortPopUpView.hidden = YES;
    [self getName:categoryMainName];
    [self getId:_categoryMainId];
    [self getSortId:getMainSortId];
    [self getItemImages];
    
}
-(void)getItemImages{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"yes"]) {
        
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_sub_category_item.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&subCatId=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],_categoryMainId];
    
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
            


                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        id subCatagoryArr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                        NSLog(@"%@",subCatagoryArr);
                                                        
                                                        NSArray *dammySubCatArray = [subCatagoryArr valueForKey:@"categories"];
                                                        NSLog(@"%@",dammySubCatArray);
                                                        
                                                        _subCatMainData = [[NSMutableArray alloc]init];
                                                        int index;
                                                        
                                                        for (index=0; index<dammySubCatArray.count; index++) {
                                                            NSDictionary *dict = dammySubCatArray[index];
                                                            _subModel = [[SubCategoryModel alloc]init];
                                                            NSLog(@"%@",dict);
                                                            [_subModel setModelWithDict:dict];
                                                            NSLog(@"%@",_subModel);
                                                            [_subCatMainData addObject:_subModel];
                                                        }
                                                        NSLog(@"%@",_subCatMainData);

                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [_DisplayItemsCollectionView reloadData];
                                                        });
                                                    }
                                                    
                                                }];
    [task resume];
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]){
        
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
            });
            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
            NSURL *url=[NSURL URLWithString:urlInstring];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            NSString *params = [NSString stringWithFormat:@"subCatId=%@&c=%@",_CatModel.category_id,_colorCode];
            
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
                    NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                    int index;
                    indivisualFilterDataArray = [[NSMutableArray alloc]init];
                    for (index=0; index<dammyArray.count; index++) {
                        NSDictionary *dict = dammyArray[index];
                        _indivisualFilterModel = [[IndivisualFilterModel alloc]init];
                        [_indivisualFilterModel setIndivisualFilterItemWithDictionary:dict];
                        [indivisualFilterDataArray addObject:_indivisualFilterModel];
                        
                    }
                    NSLog(@"%@",indivisualFilterDataArray);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_DisplayItemsCollectionView reloadData];
                    });
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
        NSString *params = [NSString stringWithFormat:@"subCatId=%@&s=%@",_CatModel.category_id,_sizeIndexArray];
        
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
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_DisplayItemsCollectionView reloadData];
            });
        }];
        [task resume];
        
        
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
        });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *params = [NSString stringWithFormat:@"subCatId=%@&p=%@",_CatModel.category_id,_priceIndexArray];
        
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
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_DisplayItemsCollectionView reloadData];
            });
        }];
        [task resume];
    }

    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"yes"]isEqualToString:@"yes"]) {
        
    return _subCatMainData.count;
    }else{
        NSLog(@"%lu",(unsigned long)indivisualFilterDataArray.count);
        return indivisualFilterDataArray.count;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"yes"]isEqualToString:@"yes"]) {

    DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath];
    self.subModel = [_subCatMainData objectAtIndex:indexPath.item];
       
    [cell.displayItemImage setImageWithURL:[NSURL URLWithString:self.subModel.image] placeholderImage:nil];
    cell.displayItemTextLabel.text = self.subModel.Name;
    cell.wishListButton.tag = indexPath.item;
    NSLog(@"%ld",(long)cell.wishListButton.tag);
    [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
   
    cell.starRatingLabel.text = [NSString stringWithFormat:@"%@",self.subModel.rating];
    if ([_subModel.offer isEqualToString:@"yes"]) {
        cell.priceLabel.text = self.subModel.off_price;

        NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= _subModel.price attributes:@{NSStrikethroughStyleAttributeName:
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
        cell.offerLabel.backgroundColor = [UIColor redColor];
        cell.offerLabel.layer.cornerRadius = 13;
        cell.offerLabel.clipsToBounds = YES;
        return cell;
        
    }else{
        cell.priceLabel.text = _subModel.price;
        cell.priceOffLabel.text = nil;
        cell.offerLabel.text = nil;
        return cell;
    }
    
    }else{
        DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath ];
        self.indivisualFilterModel = [indivisualFilterDataArray objectAtIndex:indexPath.item];
        NSLog(@"%@",self.indivisualFilterModel.image);
        NSLog(@"%@",self.indivisualFilterModel.Name);
        [cell.displayItemImage setImageWithURL:[NSURL URLWithString:self.indivisualFilterModel.image] placeholderImage:nil];
        cell.displayItemTextLabel.text = self.indivisualFilterModel.Name;
        cell.wishListButton.tag = indexPath.item;
        NSLog(@"%ld",(long)cell.wishListButton.tag);
        [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.starRatingLabel.text = [NSString stringWithFormat:@"%@",self.indivisualFilterModel.rating];
        if ([_indivisualFilterModel.offer isEqualToString:@"yes"]) {
            cell.priceLabel.text = self.indivisualFilterModel.off_price;
            
            NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= _indivisualFilterModel.price attributes:@{NSStrikethroughStyleAttributeName:
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
            cell.offerLabel.backgroundColor = [UIColor redColor];
            cell.offerLabel.layer.cornerRadius = 13;
            cell.offerLabel.clipsToBounds = YES;
            return cell;

        }else{
            cell.priceLabel.text = _indivisualFilterModel.price;
            cell.priceOffLabel.text = nil;
            cell.offerLabel.text = nil;
            return cell;
        }
    
}
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"yes"]isEqualToString:@"yes"]) {
    SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
     _subModel = [_subCatMainData objectAtIndex:indexPath.item];
    subsubVc.loginDetailsArray = self.loginDetailsArray;
    subsubVc.loginModel = self.loginModel;
    subsubVc.subCategoryModel = _subModel;
    NSLog(@"%@",_subModel.pid);
    [subsubVc getId:_subModel.pid];
    [subsubVc getColor_code:_subModel.color_code];
        
    [subsubVc getItemName:_subModel.Name];
    NSLog(@"%@",_subModel.Name);
    [subsubVc getItemPrice:_subModel.price];
   
    
    [self.navigationController pushViewController:subsubVc animated:YES];
    }else{
        
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(203, 364);
}
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (collectionView==_DisplayItemsCollectionView) {
//        
//        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//    }
//}

-(IBAction)ClickOnWishlist:(UIButton *)sender{
   
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"])
 {

     MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
     hud.label.text = strloadingText;
     NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/send_indivi_like.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
     _subModel = [_subCatMainData objectAtIndex:sender.tag];
    
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&status=%@&pid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"Y",_subModel.pid];
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
                    DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView cellForItemAtIndexPath:selectedIndexPath];
                    cell.wishListButton.backgroundColor = [UIColor redColor];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User Wishlist" message:@"Successfully Added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [alert show];
                });
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                    DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView cellForItemAtIndexPath:selectedIndexPath];
                    cell.wishListButton.backgroundColor = [UIColor whiteColor];
                    
//                    WishlistViewController *wishListVc = [self.storyboard instantiateViewControllerWithIdentifier:@"WishlistViewController"];
//                    wishListVc.loginModel = self.loginModel;
//                    
//                    wishListVc.subModel = self.subModel;
//                    [self.navigationController pushViewController:wishListVc animated:YES];
                    
                });
            }

            
        }
        

    }];
    [task resume];
 }else{
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login" message:@"Please logIn " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     ViewController *vc= [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
     [self.navigationController pushViewController:vc animated:YES];
 }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getId:(NSString *)CategoryId
{
    NSLog(@"%@",CategoryId);
    _categoryMainId = CategoryId;
}

-(void)GetSortData{
   
    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"554194aa-7dc1-9888-889c-d059e4257252" };
    NSArray *parameters = @[ @{ @"name": @"cid", @"value": _categoryMainId } ];
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
    
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
                                                    }
                                                    id sortData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                    NSLog(@"%@",sortData);
                                                    
                                                    NSArray *sortDammyArr = [sortData valueForKey:@"category"];
                                                    sortMainData = [[NSMutableArray alloc]init];
                                                    int index;
                                                    for (index=0; index<sortDammyArr.count; index++) {
                                                        NSDictionary *dict = sortDammyArr[index];
                                                        SortModel *model = [[SortModel alloc]init];
                                                        [model setModelWithDict:dict];
                                                        [sortMainData addObject:model];
                                                        NSLog(@"%@",sortMainData);
                                                    
                                                    
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                        self.sortTableView.delegate = self;
                                                        self.sortTableView.dataSource = self;
                                                        [self.sortTableView reloadData];
                                                    });
                                                    
                                                }];
    [dataTask resume];
    
    
}

-(IBAction)clickOnSort:(UIButton *)sender{
    [self getPopUpName:PopUpNameText];
    self.popUpTextLabel.text = PopUpNameText;
    self.sortPopUpView.hidden = NO;
    [self GetSortData];
}

//-(IBAction)ClickOnFilter:(id)sender{
//    FilterViewController *filterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
//    [self.navigationController pushViewController:filterVc animated:YES];
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sortMainData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    SortModel *displayModel = [sortMainData objectAtIndex:indexPath.row];
    NSLog(@"%@",displayModel);
        NSLog(@"%@",displayModel.name);
    cell.textLabel.text = displayModel.name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    SortItemDisplayViewController *sortItemVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SortItemDisplayViewController"];
    [self.navigationController pushViewController:sortItemVc animated:YES];
    SortModel *sortItemModel = [sortMainData objectAtIndex:indexPath.row];
    NSLog(@"%@",sortItemModel.sub_catid);
    [sortItemVc getSortItemId:sortItemModel.sub_catid];
    NSLog(@"%@",sortItemModel.name);
    [sortItemVc getSortItemName:sortItemModel.name];
    
    
    
}
-(void)getSortId:(NSString *)SortItemId{
    getMainSortId = SortItemId;
}


-(void)getName:(NSString *)CategoryName{
    NSLog(@"%@",CategoryName);
    categoryMainName = CategoryName;
    
    self.titleLabel.text = categoryMainName;
    
//    UINavigationBar *naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 1024, 66)];
//    
//    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectMake(200,8,200,30)];
//    navLabel.text = categoryMainName;
//    NSLog(@"%@",navLabel.text);
//    navLabel.textColor = [UIColor redColor];
//    [naviBarObj addSubview:navLabel];
//    [navLabel setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:naviBarObj];
    
    
}
-(void)getPopUpName:(NSString *)popUpName{
    PopUpNameText = popUpName;
}
-(IBAction)ClickOnSortClose:(id)sender{
    self.sortPopUpView.hidden = YES;
}
-(void)getPrice:(NSString *)price{
    priceMainId = price;
}
-(void)getPid:(NSString *)Pid{
    pidMainId = Pid;
}

-(IBAction)ClickOnFilter1:(id)sender{
    FilterViewController *filterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
    filterVc.catModel = self.CatModel;
    NSLog(@"%@",filterVc.catModel);
    [self.navigationController pushViewController:filterVc animated:YES];
    
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat widthOfCell =(self.view.frame.size.width-3)/2;
//    CGSize returnValue = CGSizeMake(widthOfCell, widthOfCell);
//
//    return returnValue;
//}





@end
