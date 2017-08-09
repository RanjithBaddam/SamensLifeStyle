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
#import "FetchFilterSizeItemModel.h"
#import "FetchSortColorModelDetails.h"
#import "FetchSortFilterSizeModel.h"
#import "FilterPriceItemModel.h"
#import "PriceItemModel.h"
#import "SearchDataModel.h"
#import "SearchViewController.h"



@interface ItemsDisplayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    
    NSMutableArray *sortMainData;
    UILabel *headerLabel;
    NSString *getMainSortId;
    NSString *priceMainId;
    NSString *pidMainId;
    NSMutableArray *indivisualFilterDataArray;
    NSMutableArray *fetchFilterSizeDataArray;
    SortModel *sortmodel;
    NSMutableArray *Color1DataArray;
    NSMutableArray *Size1DataArray;
    FetchSortColorModelDetails *fetchColor1DetailsModel ;
    FetchSortFilterSizeModel *size1Model;
    NSMutableArray *priceDataArray;
    NSMutableArray *priceDataArray1;
    FilterPriceItemModel *PriceModel;
    PriceItemModel *priceModel1;
    NSMutableArray *searchDataArray;
    SearchDataModel *searchDataModel;
}
@end

@implementation ItemsDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = _categoryMainName;

   
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(clickOnTap:)];
//    [self.view addGestureRecognizer:singleTap];

    self.sortPopUpView.hidden = YES;
    [self getName:_categoryMainName];
    [self getId:_categoryMainId];
    [self getSortId:getMainSortId];
    self.searchBar.delegate = self;

   // [self getItemImages];
    
}
-(void)viewWillAppear:(BOOL)animated{
   [self getItemImages];
    [_searchBar resignFirstResponder];

}
-(void)getItemImages{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"yes"]) {
      dispatch_async(dispatch_get_main_queue(), ^{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      });
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
                                                        if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                        self.DisplayItemsCollectionView.hidden = YES;
                                                            });
                                                        }else{
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
                                                            self.DisplayItemsCollectionView.hidden = NO;

                                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                            self.DisplayItemsCollectionView.delegate = self;
                                                            self.DisplayItemsCollectionView.dataSource = self;
                                                            [self.DisplayItemsCollectionView reloadData];
                                                        });
                                                    }
                                                    }
        
                                                }];
    [task resume];
    
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]){
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
            
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
                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            self.DisplayItemsCollectionView.hidden = YES;
                        });
                    }else{
                    self.dammyArray = [jsonData valueForKey:@"categories"];
                    NSLog(@"%@",self.dammyArray);
                 
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.DisplayItemsCollectionView.hidden = NO;

                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        self.DisplayItemsCollectionView.delegate = self;
                        self.DisplayItemsCollectionView.dataSource = self;
                        [self.DisplayItemsCollectionView reloadData];
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
                if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        self.DisplayItemsCollectionView.hidden = YES;
                    });
                }else{
                NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                int index;
                fetchFilterSizeDataArray = [[NSMutableArray alloc]init];
                for (index = 0; index < dammyArray.count; index++) {
                    NSDictionary *dict = dammyArray[index];
                    _fetchFilterSizeModel = [[FetchFilterSizeItemModel alloc]init];
                    [_fetchFilterSizeModel FetchFilterSizeModelWithDictionary:dict];
                    [fetchFilterSizeDataArray addObject:_fetchFilterSizeModel];
                }
                NSLog(@"%@",fetchFilterSizeDataArray);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.DisplayItemsCollectionView.hidden = NO;

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.DisplayItemsCollectionView.delegate = self;
                self.DisplayItemsCollectionView.dataSource = self;
                [self.DisplayItemsCollectionView reloadData];
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
                if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        self.DisplayItemsCollectionView.hidden = YES;
                    });
                }else{
                    NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                    int index;
                    priceDataArray = [[NSMutableArray alloc]init];
                    for (index = 0 ; index < dammyArray.count; index++) {
                        NSDictionary *dict = dammyArray[index];
                        PriceModel = [[FilterPriceItemModel alloc]init];
                        [PriceModel filterPriceItemModelWithDictionary:dict];
                        [priceDataArray addObject:PriceModel];
                    }
                    NSLog(@"%@",priceDataArray);
                    
         
            dispatch_async(dispatch_get_main_queue(), ^{
                self.DisplayItemsCollectionView.hidden = NO;

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.DisplayItemsCollectionView.delegate = self;
                self.DisplayItemsCollectionView.dataSource = self;
                [self.DisplayItemsCollectionView reloadData];
            });
                }
            }
        }];
        [task resume];
    }

    }
//    else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"IndirectFilter"]){
//        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                
//            });
//            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
//            NSURL *url=[NSURL URLWithString:urlInstring];
//            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//            [request setHTTPMethod:@"POST"];
//            NSString *params = [NSString stringWithFormat:@"subCatId=%@&c=%@",_sortModel.sub_catid,_ColorCode1];
//            
//            NSLog(@"%@",params);
//            
//            NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
//            NSLog(@"%@",requestData);
//            [request setHTTPBody:requestData];
//            
//            NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
//            [config setTimeoutIntervalForRequest:30.0];
//            NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
//            NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                dispatch_async(dispatch_get_main_queue(),^{
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                });
//                NSError *err;
//                
//                if (error) {
//                    NSLog(@"%@",err);
//                    
//                    if ([error.localizedDescription isEqualToString:@"The request timed out."]){
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
//                            alertView.tag = 001;
//                            [alertView show];
//                        });
//                    }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
//                        dispatch_async(dispatch_get_main_queue(),^{
//                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
//                            alertView.tag = 002;
//                            [alertView show];
//                        });
//                    }
//                    
//                }else{
//                    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                    NSLog(@"%@",jsonData);
//                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            self.DisplayItemsCollectionView.hidden = YES;
//                        });
//                    }else{
//                    NSArray *dammyArray = [jsonData valueForKey:@"categories"];
//                    int index;
//                    Color1DataArray = [[NSMutableArray alloc]init];
//                    for (index=0; index < dammyArray.count ; index++) {
//                        NSDictionary *dict = dammyArray[index];
//            fetchColor1DetailsModel = [[FetchSortColorModelDetails alloc]init];
//                        [fetchColor1DetailsModel getColor1DetailsModelWithDictionary:dict];
//                        [Color1DataArray addObject:fetchColor1DetailsModel];
//                    }
//                    NSLog(@"%@",Color1DataArray);
//                  
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        self.DisplayItemsCollectionView.hidden = NO;
//
//                        [MBProgressHUD hideHUDForView:self.view animated:YES];
//                        self.DisplayItemsCollectionView.delegate = self;
//                        self.DisplayItemsCollectionView.dataSource = self;
//                        [self.DisplayItemsCollectionView reloadData];
//                    });
//
//                }
//                }
//            }];
//            [task resume];
//        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                
//            });
//            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
//            NSURL *url=[NSURL URLWithString:urlInstring];
//            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//            [request setHTTPMethod:@"POST"];
//            NSString *params = [NSString stringWithFormat:@"subCatId=%@&s=%@",_sortModel.sub_catid,_sizeIndexArray];
//            
//            NSLog(@"%@",params);
//            
//            NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
//            NSLog(@"%@",requestData);
//            [request setHTTPBody:requestData];
//            
//            NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
//            [config setTimeoutIntervalForRequest:30.0];
//            NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
//            NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                dispatch_async(dispatch_get_main_queue(),^{
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                });
//                NSError *err;
//                
//                if (error) {
//                    NSLog(@"%@",err);
//                    
//                    if ([error.localizedDescription isEqualToString:@"The request timed out."]){
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
//                            alertView.tag = 001;
//                            [alertView show];
//                        });
//                    }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
//                        dispatch_async(dispatch_get_main_queue(),^{
//                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
//                            alertView.tag = 002;
//                            [alertView show];
//                        });
//                    }
//                    
//                }else{
//                    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                    NSLog(@"%@",jsonData);
//                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            self.DisplayItemsCollectionView.hidden = YES;
//                        });
//                    }else{
//                    NSArray *dammyArray = [jsonData valueForKey:@"categories"];
//                    int index;
//                    Size1DataArray = [[NSMutableArray alloc]init];
//                    for (index = 0; index < dammyArray.count; index++) {
//                        NSDictionary *dict = dammyArray[index];
//                        size1Model = [[FetchSortFilterSizeModel alloc]init];
//                        [size1Model getSortFilterSizeModelWithDictionary:dict];
//                        [Size1DataArray addObject:size1Model];
//                    }
//                    NSLog(@"%@",Size1DataArray);
//                  
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        self.DisplayItemsCollectionView.hidden = NO;
//
//                        [MBProgressHUD hideHUDForView:self.view animated:YES];
//                        self.DisplayItemsCollectionView.delegate = self;
//                        self.DisplayItemsCollectionView.dataSource = self;
//                        [self.DisplayItemsCollectionView reloadData];
//                    });
//                    }
//                }
//            }];
//            [task resume];
//        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                
//            });
//            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
//            NSURL *url=[NSURL URLWithString:urlInstring];
//            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//            [request setHTTPMethod:@"POST"];
//            NSString *params = [NSString stringWithFormat:@"subCatId=%@&p=%@",_sortModel.sub_catid,_priceIndexArray];
//            
//            NSLog(@"%@",params);
//            
//            NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
//            NSLog(@"%@",requestData);
//            [request setHTTPBody:requestData];
//            
//            NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
//            [config setTimeoutIntervalForRequest:30.0];
//            NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
//            NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                dispatch_async(dispatch_get_main_queue(),^{
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                });
//                NSError *err;
//                
//                if (error) {
//                    NSLog(@"%@",err);
//                    
//                    if ([error.localizedDescription isEqualToString:@"The request timed out."]){
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
//                            alertView.tag = 001;
//                            [alertView show];
//                        });
//                    }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
//                        dispatch_async(dispatch_get_main_queue(),^{
//                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
//                            alertView.tag = 002;
//                            [alertView show];
//                        });
//                    }
//                    
//                }else{
//                    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                    NSLog(@"%@",jsonData);
//                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            self.DisplayItemsCollectionView.hidden = YES;
//                        });
//                    }else{
//                        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
//                        int index;
//                        priceDataArray1 = [[NSMutableArray alloc]init];
//                        for (index = 0; index < dammyArray.count; index++) {
//                            NSDictionary *dict = dammyArray[index];
//                            priceModel1 = [[PriceItemModel alloc]init];
//                            [priceModel1 getPriceDataModelWithDictionary:dict];
//                            [priceDataArray1 addObject:priceModel1];
//                        }
//                        NSLog(@"%@",priceDataArray1);
//                     
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                        self.DisplayItemsCollectionView.hidden = NO;
//
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            self.DisplayItemsCollectionView.delegate = self;
//                            self.DisplayItemsCollectionView.dataSource = self;
//                            [self.DisplayItemsCollectionView reloadData];
//                        });
// 
//                    }
//                    
//                }
//            }];
//            [task resume];
//        }
//}
    else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"search"]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
        });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_sub_category_item.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSString *params = [NSString stringWithFormat:@"subCatId=%@&api=%@&cid=%@",self.searchName,[NSUserDefaults.standardUserDefaults valueForKey:@"api"],[NSUserDefaults.standardUserDefaults valueForKey:@"custid"]];
        
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
                        self.DisplayItemsCollectionView.hidden = YES;
                    });
                }else{
                NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                int index ;
                searchDataArray = [[NSMutableArray alloc]init];
                for (index = 0; index < dammyArray.count; index++) {
                    NSDictionary *dict = dammyArray[index];
                    searchDataModel = [[SearchDataModel alloc]init];
                    [searchDataModel getSearchDataModelWithDictionary:dict];
                    [searchDataArray addObject:searchDataModel];
                }
                NSLog(@"%@",searchDataArray);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.DisplayItemsCollectionView.hidden = NO;

                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    self.DisplayItemsCollectionView.delegate = self;
                    self.DisplayItemsCollectionView.dataSource = self;
                    [self.DisplayItemsCollectionView reloadData];
                });
            }
            }
        }];
        [task resume];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"yes"]) {
        
    return _subCatMainData.count;
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]){
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
            NSLog(@"%lu",(unsigned long)self.dammyArray.count);
            return self.dammyArray.count;
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
        NSLog(@"%lu",(unsigned long)fetchFilterSizeDataArray.count);
        return fetchFilterSizeDataArray.count;
        }else{
            return priceDataArray.count;
        }
    }
//    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"IndirectFilter"]){
//        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
//            return Color1DataArray.count;
//        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
//            NSLog(@"%lu",(unsigned long)Size1DataArray.count);
//            return Size1DataArray.count;
//        }else{
//            return priceDataArray1.count;
//        }
   // }
else{
        NSLog(@"%lu",(unsigned long)searchDataArray.count);
        return searchDataArray.count;
    }

}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"yes"]) {

    DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath];
    self.subModel = [_subCatMainData objectAtIndex:indexPath.item];
        NSLog(@"%@",self.subModel);
        NSLog(@"%@",_subCatMainData);
       
    [cell.displayItemImage setImageWithURL:[NSURL URLWithString:self.subModel.image] placeholderImage:nil];
    cell.displayItemTextLabel.text = self.subModel.Name;
        cell.starRatingLabel.text = self.subModel.rating;
        cell.wishListButton.tag =  indexPath.item;
    NSLog(@"%ld",(long)cell.wishListButton.tag);
    
    [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
        self.subModel  = [_subCatMainData objectAtIndex:indexPath.item];
        if ([self.subModel.like_v isKindOfClass:[NSNull class]]) {
            [cell.wishListButton setBackgroundColor:[UIColor whiteColor]];
        }else if ([self.subModel.like_v isEqualToString:@"N"]){
            [cell.wishListButton setBackgroundColor:[UIColor whiteColor]];
        }else{
            [cell.wishListButton setBackgroundColor:[UIColor redColor]];
        }
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
                cell.offerLabel.hidden = NO;
                cell.offerLabel.layer.cornerRadius = 13;
                cell.offerLabel.clipsToBounds = YES;
                return cell;
                
            }else{
                cell.offerLabel.hidden = YES;

                cell.priceLabel.text = _subModel.price;
                cell.priceOffLabel.text = nil;
                cell.offerLabel.text = nil;
                return cell;
            }
            
        
    
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]){
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
        DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath ];
            NSLog(@"%@",self.dammyArray);
            NSLog(@"%@",[[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"Name"]);
        [cell.displayItemImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"image"]]] placeholderImage:nil];
        cell.displayItemTextLabel.text = [[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"Name"];
        cell.wishListButton.tag = indexPath.item;
        NSLog(@"%ld",(long)cell.wishListButton.tag);
        [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
            
            if ([[[self.dammyArray objectAtIndex:indexPath.item ]valueForKey:@"like_v"] isKindOfClass:[NSNull class]]) {
                cell.wishListButton.backgroundColor = [UIColor whiteColor];
            }else if ([[[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"like_v" ] isEqualToString:@"N"]){
                cell.wishListButton.backgroundColor = [UIColor whiteColor];
                
            }else{
                cell.wishListButton.backgroundColor = [UIColor redColor];
            }
        
        cell.starRatingLabel.text = [NSString stringWithFormat:@"%@",[[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"rating"]];
        if ([[[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"offer"] isEqualToString:@"yes"]) {
            cell.priceLabel.text = [[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"off_price"];
            
            NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= [[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"price"] attributes:@{NSStrikethroughStyleAttributeName:
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
            cell.offerLabel.backgroundColor = [UIColor whiteColor];
            cell.priceLabel.text = [[self.dammyArray objectAtIndex:indexPath.item]valueForKey:@"price"];
            cell.priceOffLabel.text = nil;
            cell.offerLabel.text = nil;
            return cell;
        }
    
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
         DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath ];
        self.fetchFilterSizeModel = [fetchFilterSizeDataArray objectAtIndex:indexPath.item];
        NSLog(@"%@",self.fetchFilterSizeModel.image);
        NSLog(@"%@",self.fetchFilterSizeModel.Name);
        [cell.displayItemImage setImageWithURL:[NSURL URLWithString:self.fetchFilterSizeModel.image] placeholderImage:nil];
        cell.displayItemTextLabel.text = self.fetchFilterSizeModel.Name;
        cell.wishListButton.tag = indexPath.item;
        NSLog(@"%ld",(long)cell.wishListButton.tag);
        [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.starRatingLabel.text = [NSString stringWithFormat:@"%@",self.fetchFilterSizeModel.rating];
        if ([self.fetchFilterSizeModel.offer isEqualToString:@"yes"]) {
            cell.priceLabel.text = self.fetchFilterSizeModel.off_price;
            
            NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= self.fetchFilterSizeModel.price attributes:@{NSStrikethroughStyleAttributeName:
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
            cell.offerLabel.backgroundColor = [UIColor whiteColor];
            cell.priceLabel.text = self.fetchFilterSizeModel.price;
            cell.priceOffLabel.text = nil;
            cell.offerLabel.text = nil;
            return cell;
        }

        
    }else{
        DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath ];
        PriceModel = [priceDataArray objectAtIndex:indexPath.item];
        NSLog(@"%@",PriceModel.image);
        NSLog(@"%@",PriceModel.Name);
        [cell.displayItemImage setImageWithURL:[NSURL URLWithString:PriceModel.image] placeholderImage:nil];
        cell.displayItemTextLabel.text = PriceModel.Name;
        cell.wishListButton.tag = indexPath.item;
        NSLog(@"%ld",(long)cell.wishListButton.tag);
        [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.starRatingLabel.text = [NSString stringWithFormat:@"%@",PriceModel.rating];
        if ([PriceModel.offer isEqualToString:@"yes"]) {
            cell.priceLabel.text = PriceModel.off_price;
            
            NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= PriceModel.price attributes:@{NSStrikethroughStyleAttributeName:
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
            cell.offerLabel.backgroundColor = [UIColor whiteColor];
            cell.priceLabel.text = PriceModel.price;
            cell.priceOffLabel.text = nil;
            cell.offerLabel.text = nil;
            return cell;
        }

    }
    }
//    else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"IndirectFilter"]){
//        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
//            DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath ];
//           fetchColor1DetailsModel = [Color1DataArray objectAtIndex:indexPath.item];
//            NSLog(@"%@",fetchColor1DetailsModel.image);
//            NSLog(@"%@",fetchColor1DetailsModel.Name);
//            [cell.displayItemImage setImageWithURL:[NSURL URLWithString:fetchColor1DetailsModel.image] placeholderImage:nil];
//            cell.displayItemTextLabel.text = fetchColor1DetailsModel.Name;
//            cell.wishListButton.tag = indexPath.item;
//            NSLog(@"%ld",(long)cell.wishListButton.tag);
//            [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
//            
//            cell.starRatingLabel.text = [NSString stringWithFormat:@"%@",fetchColor1DetailsModel.rating];
//            if ([fetchColor1DetailsModel.offer isEqualToString:@"yes"]) {
//                cell.priceLabel.text = fetchColor1DetailsModel.off_price;
//                
//                NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= fetchColor1DetailsModel.price attributes:@{NSStrikethroughStyleAttributeName:
//                                                                                                                                                                      [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
//                [cell.priceOffLabel setAttributedText:priceOffString];
//                NSString *string = cell.priceLabel.text;
//                NSLog(@"%@",string);
//                float value = [string floatValue];
//                NSString *string1 = cell.priceOffLabel.text;
//                NSLog(@"%@",string1);
//                float value1 = [string1 floatValue];
//                float pers = 100;
//                float percentage = (value * pers)/value1;
//                NSLog(@"%f",percentage);
//                int totalValue = pers - percentage;
//                NSLog(@"%d",totalValue);
//                NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
//                NSLog(@"%@",persentage);
//                cell.offerLabel.text = persentage;
//                NSLog(@"%@",cell.offerLabel.text);
//                cell.offerLabel.backgroundColor = [UIColor redColor];
//                cell.offerLabel.layer.cornerRadius = 13;
//                cell.offerLabel.clipsToBounds = YES;
//                return cell;
//                
//            }else{
//                cell.priceLabel.text = fetchColor1DetailsModel.price;
//                cell.priceOffLabel.text = nil;
//                cell.offerLabel.text = nil;
//                return cell;
//            }
//
//        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
//            DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath ];
//            size1Model = [Size1DataArray objectAtIndex:indexPath.item];
//            NSLog(@"%@",size1Model.image);
//            NSLog(@"%@",size1Model.Name);
//            [cell.displayItemImage setImageWithURL:[NSURL URLWithString:size1Model.image] placeholderImage:nil];
//            cell.displayItemTextLabel.text = size1Model.Name;
//            cell.wishListButton.tag = indexPath.item;
//            NSLog(@"%ld",(long)cell.wishListButton.tag);
//            [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
//            
//            cell.starRatingLabel.text = [NSString stringWithFormat:@"%@",size1Model.rating];
//            if ([size1Model.offer isEqualToString:@"yes"]) {
//                cell.priceLabel.text = size1Model.off_price;
//                
//                NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= size1Model.price attributes:@{NSStrikethroughStyleAttributeName:
//                                                                                                                                                                       [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
//                [cell.priceOffLabel setAttributedText:priceOffString];
//                NSString *string = cell.priceLabel.text;
//                NSLog(@"%@",string);
//                float value = [string floatValue];
//                NSString *string1 = cell.priceOffLabel.text;
//                NSLog(@"%@",string1);
//                float value1 = [string1 floatValue];
//                float pers = 100;
//                float percentage = (value * pers)/value1;
//                NSLog(@"%f",percentage);
//                int totalValue = pers - percentage;
//                NSLog(@"%d",totalValue);
//                NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
//                NSLog(@"%@",persentage);
//                cell.offerLabel.text = persentage;
//                NSLog(@"%@",cell.offerLabel.text);
//                cell.offerLabel.backgroundColor = [UIColor redColor];
//                cell.offerLabel.layer.cornerRadius = 13;
//                cell.offerLabel.clipsToBounds = YES;
//                return cell;
//                
//            }else{
//                cell.priceLabel.text = size1Model.price;
//                cell.priceOffLabel.text = nil;
//                cell.offerLabel.text = nil;
//                return cell;
//            }
// 
//        }else{
//             DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath ];
//            priceModel1 = [priceDataArray1 objectAtIndex:indexPath.item];
//            NSLog(@"%@",priceModel1.image);
//            NSLog(@"%@",priceModel1.Name);
//            [cell.displayItemImage setImageWithURL:[NSURL URLWithString:priceModel1.image] placeholderImage:nil];
//            cell.displayItemTextLabel.text = priceModel1.Name;
//            cell.wishListButton.tag = indexPath.item;
//            NSLog(@"%ld",(long)cell.wishListButton.tag);
//            [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
//            
//            cell.starRatingLabel.text = [NSString stringWithFormat:@"%@",priceModel1.rating];
//            if ([priceModel1.offer isEqualToString:@"yes"]) {
//                cell.priceLabel.text = priceModel1.off_price;
//                
//                NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= priceModel1.price attributes:@{NSStrikethroughStyleAttributeName:
//                                                                                                                                                          [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
//                [cell.priceOffLabel setAttributedText:priceOffString];
//                NSString *string = cell.priceLabel.text;
//                NSLog(@"%@",string);
//                float value = [string floatValue];
//                NSString *string1 = cell.priceOffLabel.text;
//                NSLog(@"%@",string1);
//                float value1 = [string1 floatValue];
//                float pers = 100;
//                float percentage = (value * pers)/value1;
//                NSLog(@"%f",percentage);
//                int totalValue = pers - percentage;
//                NSLog(@"%d",totalValue);
//                NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
//                NSLog(@"%@",persentage);
//                cell.offerLabel.text = persentage;
//                NSLog(@"%@",cell.offerLabel.text);
//                cell.offerLabel.backgroundColor = [UIColor redColor];
//                cell.offerLabel.layer.cornerRadius = 13;
//                cell.offerLabel.clipsToBounds = YES;
//                return cell;
//                
//            }else{
//                cell.priceLabel.text = priceModel1.price;
//                cell.priceOffLabel.text = nil;
//                cell.offerLabel.text = nil;
//                return cell;
//            }
//        }
//    }
    else{
        DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView dequeueReusableCellWithReuseIdentifier:@"DisplayItemsCollectionViewCell" forIndexPath:indexPath];
        searchDataModel = [searchDataArray objectAtIndex:indexPath.item];
        
        [cell.displayItemImage setImageWithURL:[NSURL URLWithString:searchDataModel.image] placeholderImage:nil];
        cell.displayItemTextLabel.text = searchDataModel.Name;
        cell.wishListButton.tag = indexPath.item;
        NSLog(@"%ld",(long)cell.wishListButton.tag);
        
        [cell.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
        if ([searchDataModel.like_v isKindOfClass:[NSNull class]]) {
            cell.wishListButton.backgroundColor = [UIColor whiteColor];
            NSLog(@"%@",searchDataModel.like_v);
        }else if ([searchDataModel.like_v isEqualToString:@"N"]){
            cell.wishListButton.backgroundColor = [UIColor whiteColor];
            NSLog(@"%@",searchDataModel.like_v);
            
        }else{
            cell.wishListButton.backgroundColor = [UIColor redColor];
            NSLog(@"%@",searchDataModel.like_v);
        }
        cell.starRatingLabel.text = searchDataModel.rating;
        if ([searchDataModel.offer isEqualToString:@"yes"]) {
            cell.priceLabel.text = searchDataModel.off_price;
            
            NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell.priceOffLabel.text= searchDataModel.price attributes:@{NSStrikethroughStyleAttributeName:
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
            cell.offerLabel.backgroundColor = [UIColor whiteColor];
            cell.priceLabel.text = searchDataModel.price;
            cell.priceOffLabel.text = nil;
            cell.offerLabel.text = nil;
            return cell;
        }
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"yes"]) {
    SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
     _subModel = [_subCatMainData objectAtIndex:indexPath.item];
    subsubVc.subCategoryModel = _subModel;
    NSLog(@"%@",_subModel.pid);
    [subsubVc getId:_subModel.pid];
    [subsubVc getColor_code:_subModel.color_code];
        
    [subsubVc getItemName:_subModel.Name];
    NSLog(@"%@",_subModel.Name);
    [subsubVc getItemPrice:_subModel.price];
    [self.navigationController pushViewController:subsubVc animated:YES];
        
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"DirectFilter"]){
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color"]) {
            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
            _indivisualFilterModel = [indivisualFilterDataArray objectAtIndex:indexPath.item];
           
            [subsubVc getId:_indivisualFilterModel.pid];
            [subsubVc getColor_code:_indivisualFilterModel.color_code];
            NSLog(@"%@",_indivisualFilterModel.Name);
            [subsubVc getItemName:_indivisualFilterModel.Name];
            NSLog(@"%@",_indivisualFilterModel.Name);
            [subsubVc getItemPrice:_indivisualFilterModel.price];
            [self.navigationController pushViewController:subsubVc animated:YES];
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
            _fetchFilterSizeModel = [fetchFilterSizeDataArray objectAtIndex:indexPath.item];
            
            [subsubVc getId:_fetchFilterSizeModel.pid];
            [subsubVc getColor_code:_fetchFilterSizeModel.color_code];
            
            [subsubVc getItemName:_fetchFilterSizeModel.Name];
            NSLog(@"%@",_fetchFilterSizeModel.Name);
            [subsubVc getItemPrice:_fetchFilterSizeModel.price];
            [self.navigationController pushViewController:subsubVc animated:YES];
        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
            PriceModel = [priceDataArray objectAtIndex:indexPath.item];
            
            [subsubVc getId:PriceModel.pid];
            [subsubVc getColor_code:PriceModel.color_code];
            
            [subsubVc getItemName:PriceModel.Name];
            NSLog(@"%@",PriceModel.Name);
            [subsubVc getItemPrice:PriceModel.price];
            [self.navigationController pushViewController:subsubVc animated:YES];
        }
//    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Direct"]isEqualToString:@"IndirectFilter"]){
//        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"color1"]) {
//            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
//            fetchColor1DetailsModel = [Color1DataArray objectAtIndex:indexPath.item];
//            
//            [subsubVc getId:fetchColor1DetailsModel.pid];
//            [subsubVc getColor_code:fetchColor1DetailsModel.color_code];
//            
//            [subsubVc getItemName:fetchColor1DetailsModel.Name];
//            NSLog(@"%@",fetchColor1DetailsModel.Name);
//            [subsubVc getItemPrice:fetchColor1DetailsModel.price];
//            [self.navigationController pushViewController:subsubVc animated:YES];
//        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"size"]){
//            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
//            size1Model = [Size1DataArray objectAtIndex:indexPath.item];
//            
//            [subsubVc getId:size1Model.pid];
//            [subsubVc getColor_code:size1Model.color_code];
//            
//            [subsubVc getItemName:size1Model.Name];
//            NSLog(@"%@",size1Model.Name);
//            [subsubVc getItemPrice:size1Model.price];
//            [self.navigationController pushViewController:subsubVc animated:YES];
//        }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"index"]isEqualToString:@"price"]){
//            SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
//            priceModel1 = [priceDataArray1 objectAtIndex:indexPath.item];
//            
//            [subsubVc getId:priceModel1.pid];
//            [subsubVc getColor_code:priceModel1.color_code];
//            
//            [subsubVc getItemName:priceModel1.Name];
//            NSLog(@"%@",priceModel1.Name);
//            [subsubVc getItemPrice:priceModel1.price];
//            [self.navigationController pushViewController:subsubVc animated:YES];
//        }
//
//    }else{
        SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
        searchDataModel = [searchDataArray objectAtIndex:indexPath.item];
        [subsubVc getId:searchDataModel.pid];
        [subsubVc getColor_code:searchDataModel.color_code];
        
        [subsubVc getItemName:searchDataModel.Name];
        NSLog(@"%@",searchDataModel.Name);
        [subsubVc getItemPrice:searchDataModel.price];
        [self.navigationController pushViewController:subsubVc animated:YES];

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
   
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"] || [[NSUserDefaults.standardUserDefaults valueForKey:@"login"]isEqualToString:@"google"] || [[NSUserDefaults.standardUserDefaults valueForKey:@"login"]isEqualToString:@"facebook"])
 {
//     NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
//     NSData *data1 = [currentDefaults objectForKey:@"WishListData"];
//     NSMutableArray *token = [[NSMutableArray alloc]init];
//     token = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
//     NSLog(@"%@",token);
//     
//     self.subModel = [_subCatMainData objectAtIndex:sender.tag];
//     NSLog(@"%@",self.subModel.pid);
//     NSArray *token1 = [token valueForKey:@"pid"];
//     NSLog(@"%@",token1);
     self.subModel = [_subCatMainData objectAtIndex:sender.tag];
     NSLog(@"%@",self.subModel.Name);
     NSLog(@"%@",self.subModel.like_v);
         if ([self.subModel.like_v isKindOfClass:[NSNull class]] || [self.subModel.like_v isEqualToString:@"N"]) {
             dispatch_async(dispatch_get_main_queue(), ^{
    
         MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
         hud.label.text = strloadingText;
             });
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
                 [self getItemImages];

                 if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                     dispatch_async(dispatch_get_main_queue(), ^{
                         NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                         DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView cellForItemAtIndexPath:selectedIndexPath];
                         cell.wishListButton.backgroundColor = [UIColor redColor];
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         
                     });
                     
                 }else{
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                         DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView cellForItemAtIndexPath:selectedIndexPath];
                         cell.wishListButton.backgroundColor = [UIColor redColor];
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
         _subModel = [_subCatMainData objectAtIndex:sender.tag];
         
         NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&status=%@&pid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"N",_subModel.pid];
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
                 [self getItemImages];

                 if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                     dispatch_async(dispatch_get_main_queue(), ^{
                         NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                         DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView cellForItemAtIndexPath:selectedIndexPath];
                         cell.wishListButton.backgroundColor = [UIColor whiteColor];
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         
                     });
                     
                 }else{
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                         DisplayItemsCollectionViewCell *cell = [_DisplayItemsCollectionView cellForItemAtIndexPath:selectedIndexPath];
                         cell.wishListButton.backgroundColor = [UIColor redColor];
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
         self.tabBarController.tabBar.hidden = YES;
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
   
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"DirectSort"]) {
        
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
                                                            self.DisplayItemsCollectionView.hidden = YES;
                                                        });
                                                    }else{
                                                    
                                                    NSArray *sortDammyArr = [sortData valueForKey:@"category"];
                                                    sortMainData = [[NSMutableArray alloc]init];
                                                    int index;
                                                    for (index=0; index<sortDammyArr.count; index++) {
                                                        NSDictionary *dict = sortDammyArr[index];
                                                        sortmodel = [[SortModel alloc]init];
                                                        [sortmodel setModelWithDict:dict];
                                                        [sortMainData addObject:sortmodel];
                                                        NSLog(@"%@",sortMainData);
                                                    
                                                    
                                                    }
                                                    dispatch_async(dispatch_get_main_queue(), ^{
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

-(IBAction)clickOnSort:(UIButton *)sender{
    [NSUserDefaults.standardUserDefaults setValue:@"DirectSort" forKey:@"Sort"];
    [self getPopUpName:_PopUpNameText];
    self.popUpTextLabel.text = _PopUpNameText;
    self.sortPopUpView.hidden = NO;
    self.DisplayItemsCollectionView.alpha = 0.3;
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
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"Sort"]isEqualToString:@"DirectSort"]) {
        
    SortItemDisplayViewController *sortItemVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SortItemDisplayViewController"];
    [self.navigationController pushViewController:sortItemVc animated:YES];
    sortmodel = [sortMainData objectAtIndex:indexPath.row];
    sortItemVc.categoryMainId = self.categoryMainId;
        NSLog(@"%@",sortItemVc.categoryMainId);
        NSLog(@"%@",sortmodel.sub_catid);
        sortItemVc.MainSortItemId = sortmodel.sub_catid;
        NSLog(@"%@",sortItemVc.MainSortItemId);
    //[sortItemVc getSortItemId:self.MainSortItemId];
    NSLog(@"%@",sortmodel.name);
    [sortItemVc getSortItemName:sortmodel.name];
    sortItemVc.sortModel = sortmodel;
        NSLog(@"%@",self.PopUpNameText);
    sortItemVc.PopUpNameText = self.PopUpNameText;
        NSLog(@"%@",sortItemVc.PopUpNameText);
        
    }
    
}
-(void)getSortId:(NSString *)SortItemId{
    getMainSortId = SortItemId;
}


-(void)getName:(NSString *)CategoryName{
    NSLog(@"%@",CategoryName);
    _categoryMainName = CategoryName;
    
    self.titleLabel.text = _categoryMainName;

    
    
}
-(void)getPopUpName:(NSString *)popUpName{
    _PopUpNameText = popUpName;
}
-(IBAction)ClickOnSortClose:(id)sender{
    self.sortPopUpView.hidden = YES;
    self.DisplayItemsCollectionView.alpha = 1;
}
-(void)getPrice:(NSString *)price{
    priceMainId = price;
}
-(void)getPid:(NSString *)Pid{
    pidMainId = Pid;
}

-(IBAction)ClickOnFilter1:(UIButton *)sender{
    
    [NSUserDefaults.standardUserDefaults setValue:@"DirectFilter" forKey:@"Direct"];
    FilterViewController *filterVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];
    filterVc.catModel = self.CatModel;
    NSLog(@"%@",filterVc.catModel);
    filterVc.MainSortItemId = sortmodel.sub_catid;
    filterVc.sortModel = self.sortModel;
    NSLog(@"%@",filterVc.catModel);
    filterVc.categoryMainId = self.categoryMainId;
    [self.navigationController pushViewController:filterVc animated:YES];
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController *searchBarVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [self.navigationController pushViewController:searchBarVc animated:YES];
    return NO;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat widthOfCell =(self.view.frame.size.width-3)/2;
//    CGSize returnValue = CGSizeMake(widthOfCell, widthOfCell);
//
//    return returnValue;
//}





@end
