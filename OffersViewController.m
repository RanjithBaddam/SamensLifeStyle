//
//  OffersViewController.m
//  samens
//
//  Created by All time Support on 02/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "OffersViewController.h"
#import "CategoryModel.h"
#import "OffersCollectionViewCell.h"
#import <UIImageView+AFNetworking.h>
#import <MBProgressHUD.h>
#import "OfferSliderImagesModel.h"
#import "OfferItemNameCollectionViewCell.h"
#import "FetchOfferDataModel.h"
#import "ItemDisplayCollectionViewCell.h"
#import "SubSubViewController.h"



@interface OffersViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *categoryArray;
    OfferSliderImagesModel *sliderModel;
    NSMutableArray *offerSliderData;
    NSArray *categoryIdArray;
    NSString *index1 ;
    FetchOfferDataModel *offerDataModel;
    NSMutableArray *offerDataArray;
}

@end

@implementation OffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
categoryArray = [NSUserDefaults.standardUserDefaults valueForKey:@"CategoryNameKey"];
    NSLog(@"%@",categoryArray);
    [self getOfferScrollingImages];
    self.offerItemNameCollectionView.delegate = self;
    self.offerItemNameCollectionView.dataSource = self;
    [self.offerItemNameCollectionView reloadData];
    categoryIdArray = [NSUserDefaults.standardUserDefaults valueForKey:@"catIdkey"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == _offersCollectionView) {
        return 1;
    }else if (collectionView ==_offerItemNameCollectionView){
    return 1;
    }else{
        return 1;
    }
    }
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _offersCollectionView) {

    NSLog(@"%lu",(unsigned long)offerSliderData.count);
    return offerSliderData.count;
    }else if (collectionView ==_offerItemNameCollectionView){
        return categoryArray.count;
    }else{
        return offerDataArray.count;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _offersCollectionView) {
 
    OffersCollectionViewCell *cell = [_offersCollectionView dequeueReusableCellWithReuseIdentifier:@"OffersCollectionViewCell" forIndexPath:indexPath];
    sliderModel = [offerSliderData objectAtIndex:indexPath.item];
    [cell.offersImages setImageWithURL:[NSURL URLWithString:sliderModel.image] placeholderImage:nil];
    return cell;
    }else if (collectionView ==_offerItemNameCollectionView){
        OfferItemNameCollectionViewCell *cell1 = [_offerItemNameCollectionView dequeueReusableCellWithReuseIdentifier:@"OfferItemNameCollectionViewCell" forIndexPath:indexPath];
        [cell1.offerItemNameButton setTitle:[categoryArray objectAtIndex:indexPath.item] forState:UIControlStateNormal];
        index1 = [categoryIdArray objectAtIndex:indexPath.item];
        NSLog(@"%@",index1);
        if (cell1.selected) {
            cell1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:153/255.0 alpha:1]; // highlight selection
        }
        else
        {
            cell1.backgroundColor = [UIColor clearColor]; // Default color
        }
        cell1.offerItemNameButton.tag = index1;
        [cell1.offerItemNameButton addTarget:self action:@selector(clickOnOfferItem:) forControlEvents:UIControlEventTouchUpInside];
        return cell1;
    }else{
        ItemDisplayCollectionViewCell *cell2 = [_offerItemDisplayCollectionView dequeueReusableCellWithReuseIdentifier:@"ItemDisplayCollectionViewCell" forIndexPath:indexPath];
    offerDataModel = [offerDataArray objectAtIndex:indexPath.item];
    [cell2.displayItemImage setImageWithURL:[NSURL URLWithString:offerDataModel.image] placeholderImage:nil];
        cell2.displayItemTextLabel.text = offerDataModel.Name;
        cell2.wishListButton.tag = indexPath.item;
        NSLog(@"%ld",(long)cell2.wishListButton.tag);
       

        [cell2.wishListButton addTarget:self action:@selector(ClickOnWishlist:) forControlEvents:UIControlEventTouchUpInside];
        if ([offerDataModel.like_v isKindOfClass:[NSNull class]]) {
            cell2.wishListButton.backgroundColor = [UIColor whiteColor];
            NSLog(@"%@",offerDataModel.like_v);
        }else if ([offerDataModel.like_v isEqualToString:@"N"]){
            cell2.wishListButton.backgroundColor = [UIColor whiteColor];
            NSLog(@"%@",offerDataModel.like_v);
            
        }else{
            cell2.wishListButton.backgroundColor = [UIColor redColor];
            NSLog(@"%@",offerDataModel.like_v);
        }
        cell2.starRatingLabel.text = offerDataModel.rating;
        if ([offerDataModel.offer isEqualToString:@"yes"]) {
            cell2.priceLabel.text = offerDataModel.off_price;
            
            NSAttributedString *priceOffString = [[NSAttributedString alloc]initWithString:cell2.priceOffLabel.text= offerDataModel.price attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                                                                     [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
            [cell2.priceOffLabel setAttributedText:priceOffString];
            NSString *string = cell2.priceLabel.text;
            NSLog(@"%@",string);
            float value = [string floatValue];
            NSString *string1 = cell2.priceOffLabel.text;
            NSLog(@"%@",string1);
            float value1 = [string1 floatValue];
            float pers = 100;
            float percentage = (value * pers)/value1;
            NSLog(@"%f",percentage);
            int totalValue = pers - percentage;
            NSLog(@"%d",totalValue);
            NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
            NSLog(@"%@",persentage);
            cell2
            
            .offerLabel.text = persentage;
            NSLog(@"%@",cell2.offerLabel.text);
            cell2.offerLabel.backgroundColor = [UIColor redColor];
            cell2.offerLabel.layer.cornerRadius = 13;
            cell2.offerLabel.clipsToBounds = YES;
            return cell2;
            
        }else{
            cell2.priceLabel.text = offerDataModel.price;
            cell2.priceOffLabel.text = nil;
            cell2.offerLabel.text = nil;
            return cell2;
        }

        
        
        
    }
    }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _offersCollectionView) {
        
    }else if (collectionView ==_offerItemNameCollectionView){
        UICollectionViewCell* cell = [collectionView  cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:153/255.0 alpha:1];
    }else{
        SubSubViewController *subsubVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
        offerDataModel = [offerDataArray objectAtIndex:indexPath.item];
        NSLog(@"%@",offerDataModel.pid);
        [subsubVc getId:offerDataModel.pid];
        [subsubVc getColor_code:offerDataModel.color_code];
        
        [subsubVc getItemName:offerDataModel.Name];
        NSLog(@"%@",offerDataModel.Name);
        [subsubVc getItemPrice:offerDataModel.price];
        [self.navigationController pushViewController:subsubVc animated:YES];

    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView  cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}

-(void)getOfferScrollingImages{
    dispatch_async(dispatch_get_main_queue(), ^{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/FetchBrandWithOffer.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *params = [NSString stringWithFormat:@"samens=%@",@"samens"];
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
            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    self.offersCollectionView.hidden = YES;
                });
            }else{
                NSArray *dammyArray = [jsonData objectForKey:@"categories"];
                int index;
                offerSliderData = [[NSMutableArray alloc]init];
                for (index = 0; index < dammyArray.count; index++) {
                    NSDictionary *dict = dammyArray [index];
                    sliderModel = [[OfferSliderImagesModel alloc]init];
                    [sliderModel getOfferSliderImagesModelWithDictionary:dict];
                    [offerSliderData addObject:sliderModel];
                }
                NSLog(@"%@",offerSliderData);
                self.offersCollectionView.hidden = NO;

                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    self.offersCollectionView.delegate = self;
                    self.offersCollectionView.dataSource = self;
                    [self.offersCollectionView reloadData];
                });
                
            }
        }
    }];
    [task resume];
 
}
-(IBAction)clickOnOfferItem:(UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_offers.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&catId=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],sender.tag];
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
            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    self.offerItemDisplayCollectionView.hidden = YES;
                });
            }else{

            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",response);
            NSLog(@"%@",jsonData);
            NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                int index;
                offerDataArray = [[NSMutableArray alloc]init];
                for (index = 0; index < dammyArray.count; index++) {
                    NSDictionary *dict = dammyArray[index];
                    offerDataModel = [[FetchOfferDataModel alloc]init];
                    [offerDataModel getFetchOfferDataModelWithDictionary:dict];
                    [offerDataArray addObject:offerDataModel];
                }
                NSLog(@"%@",offerDataArray);

                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    self.offerItemDisplayCollectionView.hidden = NO;
                    self.offerItemDisplayCollectionView.delegate = self;
                    self.offerItemDisplayCollectionView.dataSource = self;
                    [self.offerItemDisplayCollectionView reloadData];
                });
            }
 
}

    }];
    [task resume];
}
-(IBAction)ClickOnWishlist:(UIButton *)sender{
    NSArray *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"WishListData"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"WishListData"]);
    
    offerDataModel = [offerDataArray objectAtIndex:sender.tag];
    NSLog(@"%@",offerDataModel.pid);
    NSArray *token1 = [token valueForKey:@"pid"];
    NSLog(@"%@",token1);
    if ([token1 containsObject:offerDataModel.pid]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
            hud.label.text = strloadingText;
        });
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/send_indivi_like.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        offerDataModel = [offerDataArray objectAtIndex:sender.tag];
        
        NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&status=%@&pid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"N",offerDataModel.pid];
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
                        ItemDisplayCollectionViewCell *cell = [_offerItemDisplayCollectionView cellForItemAtIndexPath:selectedIndexPath];
                        cell.wishListButton.backgroundColor = [UIColor whiteColor];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                        ItemDisplayCollectionViewCell *cell = [_offerItemDisplayCollectionView cellForItemAtIndexPath:selectedIndexPath];
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
        offerDataModel = [offerDataArray objectAtIndex:sender.tag];
        
        NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&status=%@&pid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"Y",offerDataModel.pid];
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
                        ItemDisplayCollectionViewCell *cell = [_offerItemDisplayCollectionView cellForItemAtIndexPath:selectedIndexPath];
                        cell.wishListButton.backgroundColor = [UIColor redColor];
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                        ItemDisplayCollectionViewCell *cell = [_offerItemDisplayCollectionView cellForItemAtIndexPath:selectedIndexPath];
                        cell.wishListButton.backgroundColor = [UIColor whiteColor];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User Wishlist" message:@"Successfully Added" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        
                    });
                }
                
                
            }
            
            
        }];
        [task resume];
        
    }
}
@end
