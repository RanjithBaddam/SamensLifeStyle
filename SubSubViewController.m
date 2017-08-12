//
//  SubSubViewController.m
//  samens
//
//  Created by All time Support on 11/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SubSubViewController.h"
#import "FullViewCollectionViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "SubCategoryModel.h"
#import "ItemsDisplayViewController.h"
#import "FullyImageViewController.h"
#import "ItemRatingViewController.h"
#import "ItemVariantViewController.h"
#import "ItemSizeViewController.h"
#import "SizeModel.h"
#import "itemSizeCollectionViewCell.h"
#import "DescriptionModel.h"
#import "descriptionTableViewCell.h"
#import "RelatedImageModel.h"
#import "RelatedImagesCollectionViewCell.h"
#import <UIImageView+AFNetworking.h>
#import <AFNetworking.h>
#import "SizeChatViewController.h"
#import "CatProductModel.h"
#import "ColorDataImagesModel.h"
#import "ColorImagesCollectionViewCell.h"
#import "SliderModel.h"
#import "ReviewFetchModel.h"
#import "AddToCartViewController.h"
#import "FetchReviewTableViewCell.h"
#import "AllReviewsViewController.h"
#import <MBProgressHUD.h>
#import "URLhandler.h"
#import "ProductPriceOfferTableViewCell.h"


@interface SubSubViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSString *descriptionData;
    NSString *subimage;
    NSString *subimage1;
    NSString *subimage2;
    NSString *subimage3;
    NSMutableArray *subimageArray;
    NSString *subsubCatId;

    NSString *ItemPriceData;
    NSString *ItemColorCode;
    NSMutableArray *sizeMainDataArray;
    NSMutableArray *descriptionMainDataArray;
    NSMutableArray *releatedImgsMainArray;
    IBOutlet UILabel *valueShowLabel;
    IBOutlet UILabel *RatingShowLabel;
    IBOutlet UIImageView *travelImage;
    IBOutlet UILabel *starRatingLabel;
    NSMutableArray *colorImagesData;
    NSMutableArray *sliderImagesData;
    NSMutableArray *SliderImages;
    NSString *SliderImage;
    NSString *SliderImage2;
    NSString *SliderImage3;
    NSString *SliderImage4;
    ReviewFetchModel *fetchModel;
    NSMutableArray *FetchReviewData;
    SizeModel *sizemodel;
    ColorDataImagesModel *colorModel;
    NSString *sizeIndexString;
    NSString *colorIndexString;
    RelatedImageModel *relatedImagesModel;
}

@end

@implementation SubSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self getId:_subsubCatId];
    [self getColor_code:_mainColorCode];
    [self getItemName:_ItemNameData];
 
 

    
    
    _subItemScrollView.contentSize = CGSizeMake(414, 3500);
    

    
    CALayer *border = [CALayer layer];
        CGFloat borderWidth = 2;
        border.borderColor = [UIColor darkGrayColor].CGColor;
        border.frame = CGRectMake(0, _ratingTitle.frame.size.height - borderWidth, _ratingTitle.frame.size.width, self.ratingTitle.frame.size.height);
        border.borderWidth = borderWidth;
        [self.ratingTitle.layer addSublayer:border];
        self.ratingTitle.layer.masksToBounds = YES;
    
        CALayer *border1 = [CALayer layer];
        CGFloat borderWidth1 = 2;
        border1.borderColor = [UIColor darkGrayColor].CGColor;
        border1.frame = CGRectMake(0,_ratingDescription.frame.size.height - borderWidth,_ratingDescription.frame.size.width,_ratingDescription.frame.size.height);
        border1.borderWidth = borderWidth1;
        [_ratingDescription.layer addSublayer:border1];
        _ratingDescription.layer.masksToBounds = YES;
    
    [_CheckPinTextField setBackgroundColor:[UIColor whiteColor]];
    [_CheckPinTextField.layer setBorderColor:[UIColor grayColor].CGColor];
    [_CheckPinTextField.layer setBorderWidth:1.0];

    [self refreshData];
   
}
-(void)ItemDetailsPrice{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    });
    self.itemNameLabel.text = _ItemNameData;
    self.remainingLabel.text = _sliderModel.quantity;
    [self getItemPrice:ItemPriceData];
    NSLog(@"%@",self.sliderModel.rating);
    NSString *ratingText = [NSString stringWithFormat:@"%@",self.sliderModel.rating];
    NSLog(@"%@",ratingText);
    starRatingLabel.text = ratingText;
    if ([_sliderModel.offer isEqualToString:@"yes"]) {
        self.itemPriceLabel.text = _sliderModel.off_price;
        NSAttributedString *priceOfferString = [[NSAttributedString alloc]initWithString:self.priceOffLabel.text = _sliderModel.price attributes:@{NSStrikethroughStyleAttributeName:
                                                                                                                                                            [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        [self.priceOffLabel setAttributedText:priceOfferString];
        NSString *string = self.itemPriceLabel.text;
        NSLog(@"%@",string);
        float value = [string floatValue];
        NSString *string1 = self.priceOffLabel.text;
        NSLog(@"%@",string1);
        float value1 = [string1 floatValue];
        float pers = 100;
        float percentage = (pers * value)/value1;
        int totalValue = pers - percentage;
        NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"% off"];
        NSLog(@"%@",persentage);
        self.persentageOffLabel.text = persentage;
        
        
    }else{
        self.itemPriceLabel.text = _sliderModel.price;
        self.priceOffLabel.text = nil;
        self.persentageOffLabel.text = nil;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getId:(NSString *)CategoryId{
    NSLog(@"%@",CategoryId);
    _subsubCatId = CategoryId;
    NSLog(@"%@",_subsubCatId);
    
}






-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _fullViewCollectionView) {
        return  self.sliderModel.sliderImages.count;
    }else if (collectionView==_sizeCollectionView){
        NSLog(@"%lu",(unsigned long)sizeMainDataArray.count);
            return sizeMainDataArray.count;
    }else if (collectionView == _relatedImagesCollectionView) {
        NSLog(@"%lu",(unsigned long)releatedImgsMainArray.count);
        return releatedImgsMainArray.count;
    }else{
         NSLog(@"%lu",(unsigned long)colorImagesData.count);
        return colorImagesData.count;
       
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   if (collectionView == _fullViewCollectionView) {
    
       FullViewCollectionViewCell *cell = [_fullViewCollectionView dequeueReusableCellWithReuseIdentifier:@"FullViewCollectionViewCell" forIndexPath:indexPath];
       [cell.fullViewImage setImageWithURL:[NSURL URLWithString:[self.sliderModel.sliderImages objectAtIndex:indexPath.item]] placeholderImage:nil];
      
       return cell;
       
    }else if (collectionView == _sizeCollectionView){
    itemSizeCollectionViewCell *cell = [_sizeCollectionView dequeueReusableCellWithReuseIdentifier:@"itemSizeCollectionViewCell" forIndexPath:indexPath];
        sizemodel = [sizeMainDataArray objectAtIndex:indexPath.item];
        cell.sizeLabel.text = sizemodel.size;
        [cell.sizeLabel setTextAlignment:NSTextAlignmentCenter];
        cell.sizeLabel.tag = indexPath.item;
        cell.sizeLabel.layer.borderColor = [UIColor blackColor].CGColor;
        cell.sizeLabel.layer.borderWidth = 2.0;

        
            return cell;
    }else if (collectionView == _relatedImagesCollectionView){
        RelatedImagesCollectionViewCell *cell = [_relatedImagesCollectionView dequeueReusableCellWithReuseIdentifier:@"RelatedImagesCollectionViewCell" forIndexPath:indexPath];
        relatedImagesModel = [releatedImgsMainArray objectAtIndex:indexPath.item];
        [cell.relatedImageView setImageWithURL:[NSURL URLWithString:relatedImagesModel.image] placeholderImage:nil];
        cell.relatedImageName.text = relatedImagesModel.Name;
        
        return cell;
        
    }else{
        ColorImagesCollectionViewCell *cell = [_colorImageCollectionView dequeueReusableCellWithReuseIdentifier:@"ColorImagesCollectionViewCell" forIndexPath:indexPath];
        colorModel = [colorImagesData objectAtIndex:indexPath.item];
        [cell.colorImages setImageWithURL:[NSURL URLWithString:colorModel.image] placeholderImage:nil];
        return cell;
    }
    
   
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _fullViewCollectionView) {
    
        FullyImageViewController *fullImageVc = [self.storyboard instantiateViewControllerWithIdentifier:@"FullyImageViewController"];
        fullImageVc.fullImageModel = self.sliderModel;
        [self.navigationController pushViewController:fullImageVc animated:YES];
        
    }else if (collectionView == _colorImageCollectionView){
        colorModel = [colorImagesData objectAtIndex:indexPath.item];
        [self getColorImagesPid:colorModel.pid];
        NSLog(@"%@",colorModel.pid);
    }else if (collectionView == _sizeCollectionView){
       
        sizemodel = [sizeMainDataArray objectAtIndex:indexPath.item];

    }else if (collectionView == _relatedImagesCollectionView){
        relatedImagesModel = [releatedImgsMainArray objectAtIndex:indexPath.item];
        NSLog(@"%@%@%@",relatedImagesModel.pid,relatedImagesModel.color_code,relatedImagesModel.Name);
        [self getRelatedImageProductIdColorImages:relatedImagesModel.pid :relatedImagesModel.Name :relatedImagesModel.color_code];
        
    }
    

// http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php

}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==_sizeCollectionView) {
        
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _sizeCollectionView) {
        
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    
    }
}

-(void)getItemName:(NSString *)itemName{
    _ItemNameData = itemName;
}
-(void)getItemPrice:(NSString *)itemPrice{
    ItemPriceData = itemPrice;
}

-(IBAction)clickOnRating:(UIButton *)sender{
    ItemRatingViewController *itemRatingVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemRatingViewController"];
    [self.navigationController pushViewController:itemRatingVc animated:YES];
}

-(void)getSizeData{
  [self getId:_subsubCatId];
    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"4eb91fac-f50b-aee1-62e0-ce0ad464c087" };
    NSArray *parameters = @[ @{ @"name": @"product_id", @"value": _subsubCatId } ];
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
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//        hud.label.text = strloadingText;
//    });
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_indivisula_list.php"]
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
                                                       
                                                        _sizeCollectionView.hidden = YES;
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
 
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                        NSLog(@"%@",jsonData);
                                                        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                                                        int index;
                                                        sizeMainDataArray = [[NSMutableArray alloc]init];
                                                        for (index=0; index<dammyArray.count; index++) {
                                                            NSDictionary *dict = dammyArray[index];
                                                            sizemodel = [[SizeModel alloc]init];
                                                            [sizemodel getModelWithDict:dict];
                                                            [sizeMainDataArray addObject:sizemodel];
                                                            NSLog(@"%@",sizeMainDataArray);
                                                        }
                                            dispatch_async(dispatch_get_main_queue(), ^{
//                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                self.sizeCollectionView.delegate = self;
                                                self.sizeCollectionView.dataSource = self;
                                                [self.sizeCollectionView reloadData];
                                            });
                                                    }
                                                }];
    [dataTask resume];
    

}



    
-(void)getColorData{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//        hud.label.text = strloadingText;
//    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *params = [NSString stringWithFormat:@"subCatId=%@&c=%@",_ItemNameData,_mainColorCode];
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
           
            _colorImageCollectionView.hidden = YES;
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
            colorImagesData = [[NSMutableArray alloc]init];
            for (index=0; index < dammyArray.count; index++) {
                NSDictionary *dict = dammyArray[index];
                colorModel = [[ColorDataImagesModel alloc]init];
                [ colorModel GetColorImagesModelWithDict:dict];
                [colorImagesData addObject:colorModel];
            }
             NSLog(@"%@",colorImagesData);

            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.colorImageCollectionView.delegate = self;
                self.colorImageCollectionView.dataSource = self;
                [self.colorImageCollectionView reloadData];
            });
            
        }
    } ];
    [task resume];

}

-(void)getColor_code:(NSString *)colorCode{
    _mainColorCode = colorCode;
      NSLog(@"%@",_mainColorCode);
}
-(void)getProductDescription{
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"17015ba0-c566-bb4d-ef7c-e6508c3def12" };
    NSArray *parameters = @[ @{ @"name": @"product_id", @"value": _subsubCatId } ];
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
 //   dispatch_async(dispatch_get_main_queue(), ^{
        
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//        hud.label.text = strloadingText;
//    });
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_indevisuallist_sliderImage.php"]
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
                                                       
                                                        _DescriptionTableView.hidden = YES;
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

                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                        NSLog(@"%@",jsonData);
                                                        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                                                        int index;
                                                        descriptionMainDataArray = [[NSMutableArray alloc]init];
                                                        for (index=0; index<dammyArray.count; index++) {
                                                            NSDictionary *dict = dammyArray[index];
                                                            DescriptionModel *model = [[DescriptionModel alloc]init];
                                                            [model getModelWithDict:dict];
                                                            [descriptionMainDataArray addObject:model];
                                                            NSLog(@"%@",descriptionMainDataArray);
                                                        }
                                                          dispatch_async(dispatch_get_main_queue(), ^{
//                                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                              _DescriptionTableView.delegate = self;
                                                              _DescriptionTableView.dataSource = self;
                                                              [_DescriptionTableView reloadData];
                                                          });
                                                    }
                                                }];
    [dataTask resume];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _fetchReviewTableView) {
        return FetchReviewData.count;
    }else {
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _DescriptionTableView) {
    return descriptionMainDataArray.count;
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _DescriptionTableView) {
    descriptionTableViewCell *cell = [_DescriptionTableView dequeueReusableCellWithIdentifier:@"descriptionTableViewCell"];
    cell.Tlabel.text = @"Description";
    DescriptionModel *model = [descriptionMainDataArray objectAtIndex:indexPath.row];
   cell.Dlabel.text = model.Description;
 NSLog(@"%@",cell.Dlabel.text);
        return cell;

    }else {
        FetchReviewTableViewCell *cell = [_fetchReviewTableView dequeueReusableCellWithIdentifier:@"FetchReviewTableViewCell"];
        fetchModel = [FetchReviewData objectAtIndex:indexPath.row];
        NSLog(@"%@",fetchModel.date);
        NSString *date = [NSString stringWithFormat:@"%@",fetchModel.date];
        NSString *rate = [NSString stringWithFormat:@"%@",fetchModel.rate];
        cell.reviewTimeDateLabel.text = date;
        cell.reviewStarsLabel.text = rate;
        cell.reviewDiscription.text = fetchModel.review;
        return cell;
    }

}


-(void)GetRelatedImages{
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"7a6f1d41-8ca6-d700-fe7d-7448eb499c52" };
    NSArray *parameters = @[ @{ @"name": @"subCatId", @"value": _subsubCatId } ];
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
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
        hud.label.text = strloadingText;
    });
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_you_may_like_item.php"]
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
                                                       
                                                        _relatedImagesCollectionView.hidden = YES;
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

                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                        NSLog(@"%@",jsonData);
                                                        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
                                                        int index;
                                            releatedImgsMainArray = [[NSMutableArray alloc]init];
                                                        for (index = 0; index < dammyArray.count; index++) {
                                                            NSDictionary *dict = dammyArray[index];
                                                            relatedImagesModel = [[RelatedImageModel alloc]init];
                                                            [relatedImagesModel getModelWithDictionary:dict];
                                                            [releatedImgsMainArray addObject:relatedImagesModel];
                                                        }
                                                        NSLog(@"%@",releatedImgsMainArray);

                                                       dispatch_async(dispatch_get_main_queue(), ^{
//                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    self.relatedImagesCollectionView.delegate = self;
                                                   self.relatedImagesCollectionView.dataSource = self;
                                                    [self.relatedImagesCollectionView reloadData];
                                                       });
                                                        
                                                    }
                                                    
                                                }];
    [dataTask resume];
}



-(IBAction)ClickOnWriteReview:(UIButton *)sender{
    self.RatingPopUpView.hidden = NO;
}
-(IBAction)clickOnHideRatingBtn:(id)sender{
    self.RatingPopUpView.hidden = YES;
}
-(IBAction)ClickOnCheck:(UIButton *)sender{
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"c9cfff1c-95c9-8e7a-c652-6d05a32581bf" };
    NSArray *parameters = @[ @{ @"name": @"pin", @"value": self.CheckPinTextField.text } ];
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
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//        hud.label.text = strloadingText;
//    });
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/check_pin.php"]
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

                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                        NSLog(@"%@",jsonData);
//                                                          dispatch_async(dispatch_get_main_queue(), ^{
//                                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
//                                                          });
                                                    }
                                                }];
    [dataTask resume];
    



}

-(IBAction)clickOnSizeChat:(UIButton *)sender{
    SizeChatViewController *sizeChatVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SizeChatViewController"];
    [self.navigationController pushViewController:sizeChatVc animated:YES];
}

-(IBAction)ValueChange:(UIStepper *)stepper{
    NSString *stepperValue = [NSString stringWithFormat:@"%d",
                          [[NSNumber numberWithDouble:[(UIStepper *)stepper value]] intValue]];
    if (stepperValue <= _sliderModel.quantity) {
    double value = [stepper value];
        NSLog(@"%f",value);
    [valueShowLabel setText:[NSString stringWithFormat:@"%d", (int)value]];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"No more quantities" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(IBAction)btn_action:(UIButton *)sender{
    NSInteger store = sender.tag;
    NSLog(@"%ld",(long)store);
    for(UIButton *btn in _btns_outlet){
        if (btn.tag <= store) {
            [btn setTitle:@"★" forState:UIControlStateNormal];
            RatingShowLabel.text = [NSString stringWithFormat:@"%d",(int)store];
            
        }else{
            [btn setTitle:@"☆" forState:UIControlStateNormal];
        }
    }
}

-(IBAction)ClickOnRatingCancel:(UIButton *)sender{
    self.RatingPopUpView.hidden = YES;
}
-(IBAction)bun_action1:(UIButton *)sender{
    NSInteger store = sender.tag;
    NSLog(@"%ld",(long)store);
    for(UIButton *btn in _btn_outlets){
        if (btn.tag <= store) {
            [btn setTitle:@"★" forState:UIControlStateNormal];
            self.rateShowLabel1.text = [NSString stringWithFormat:@"%d",(int)store];
            
        }else{
            [btn setTitle:@"☆" forState:UIControlStateNormal];
        }
    }
}
-(IBAction)ClickOnSubmit:(UIButton *)sender{
    if ([self.rateShowLabel1.text isEqualToString:@""]||[self.ratingTitle.text isEqualToString:@""]||[self.ratingDescription.text isEqualToString:@""]) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"AlertShowing" message:@"Please send rating and review" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
    NSMutableArray *paramsArray=[[NSMutableArray alloc]init];
    [paramsArray addObject:[NSString stringWithFormat:@"pid=%@",_subsubCatId]];
    [paramsArray addObject:[NSString stringWithFormat:@"rate=%@",_rateShowLabel1.text]];
    [paramsArray addObject:[NSString stringWithFormat:@"review=%@",self.ratingDescription.text]];
    [paramsArray addObject:[NSString stringWithFormat:@"cid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"]]];
    [paramsArray addObject:[NSString stringWithFormat:@"api=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"api"]]];
    [paramsArray addObject:[NSString stringWithFormat:@"title=%@",self.ratingTitle.text]];
    NSString *params = [paramsArray componentsJoinedByString:@"&"];
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//    hud.label.text = strloadingText;
//    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/submit_review.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

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

                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User Review" message:@"User Already Reviewed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                });
          
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[MBProgressHUD hideHUDForView:self.view animated:YES];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"User Review" message:@"User Successfully Reviewd" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                });
            }
            
        }
    } ];
    [task resume];

    
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)getColorImagesPid:(NSString *)colorImgPid{
    NSLog(@"%@",colorImgPid);
    _subsubCatId = colorImgPid;
    NSLog(@"%@",_subsubCatId);
    [self refreshData];
}
-(void)getRelatedImageProductIdColorImages:(NSString *)RelatedImagesId :(NSString *)ItemNameData :(NSString *)ColorCode  {
    _subsubCatId = RelatedImagesId;
    NSLog(@"%@",_subsubCatId);
    _ItemNameData = ItemNameData;
    NSLog(@"%@",_ItemNameData);
    _mainColorCode = ColorCode;
    NSLog(@"%@",_mainColorCode);
   
    [self refreshData];
}

-(void)GetSliderImages{
    
    //[self getColorImagesPid:subsubCatId];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//        hud.label.text = strloadingText;
//    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_indevisuallist_sliderImage.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *params = [NSString stringWithFormat:@"product_id=%@",_subsubCatId];
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
           
            _fullViewCollectionView.hidden = YES;
            if ([error.localizedDescription isEqualToString:@"The request timed out."]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
                    alertView.tag = 001;
                    [alertView show];
                });
            }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
                dispatch_async(dispatch_get_main_queue(),^{
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
                    [alertView show];
                });
            }

        }else{
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",response);
            NSLog(@"%@",jsonData);
           NSArray *dammyArray = [jsonData objectForKey:@"categories"];
            int index;
            sliderImagesData = [[NSMutableArray alloc]init];
            for (index=0; index<dammyArray.count; index++) {
                NSDictionary *dict = dammyArray[index];
                self.sliderModel = [[SliderModel alloc]init];
                [self.sliderModel getSliderModelWithDict:dict];
                [sliderImagesData addObject:self.sliderModel];
            }
            NSLog(@"%@",sliderImagesData);
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
                self.fullViewCollectionView.delegate = self;
                self.fullViewCollectionView.dataSource = self;
                [self.fullViewCollectionView reloadData];
                
            });

            [self GetRelatedImages];
            [self getProductDescription];
            [self getColorData];
            [self FetchReview];
            [self getSizeData];
            [self ItemDetailsPrice];
 
}
    }];
    [task resume];
}
-(void)FetchReview{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//        hud.label.text = strloadingText;
//    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_review_list.php"];
NSURL *url=[NSURL URLWithString:urlInstring];
NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
[request setHTTPMethod:@"POST"];

NSString *params = [NSString stringWithFormat:@"pid=%@",_subsubCatId];
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
            _fetchReviewTableView.hidden = YES;
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
        NSArray *dammyArray = [jsonData valueForKey:@"categories"];
        int index;
        FetchReviewData = [[NSMutableArray alloc]init];
        for (index=0; index<dammyArray.count; index++) {
            NSDictionary *dict = dammyArray[index];
             fetchModel = [[ReviewFetchModel alloc]init];
            [fetchModel FetchModelWithDict:dict];
            [FetchReviewData addObject:fetchModel];
        }
        NSLog(@"%@",FetchReviewData);
        dispatch_async(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
            _fetchReviewTableView.delegate = self;
            _fetchReviewTableView.dataSource = self;
            [_fetchReviewTableView reloadData];
        });
    }
}];
    [task resume];
    
  

}

-(void)refreshData{
    
    [self GetSliderImages];
//    [self GetRelatedImages];
//    [self getProductDescription];
//    [self getColorData];
//    [self FetchReview];
//    [self getSizeData];
//    [self ItemDetailsPrice];
    }
-(IBAction)ClickOnAddToCart:(id)sender{
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"]) {
        
        
        
        NSMutableArray *paramsArray=[[NSMutableArray alloc]init];
        [paramsArray addObject:[NSString stringWithFormat:@"pid=%@",_subsubCatId]];
        [paramsArray addObject:[NSString stringWithFormat:@"cid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"]]];
        [paramsArray addObject:[NSString stringWithFormat:@"price=%@",self.sliderModel.price]];
        [paramsArray addObject:[NSString stringWithFormat:@"title=%@",_ItemNameData]];
        [paramsArray addObject:[NSString stringWithFormat:@"api=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"api"]]];
        
        [paramsArray addObject:[NSString stringWithFormat:@"size=%@",sizemodel.size]];
        [paramsArray addObject:[NSString stringWithFormat:@"color=%@",colorModel.color]];
        NSLog(@"%@",valueShowLabel.text);
        [paramsArray addObject:[NSString stringWithFormat:@"quantity=%@",valueShowLabel.text]];
        
        NSString *params = [paramsArray componentsJoinedByString:@"&"];
        NSLog(@"%@",params);
        if (sizemodel.size==NULL || colorModel.color == NULL) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please choose color and size" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
//            hud.label.text = strloadingText;
//            });
            NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/add_to_cart.php"];
            NSURL *url=[NSURL URLWithString:urlInstring];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
          
            
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
                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                            [alertView show];
                        });
                    }
                    
                }
                else{
                    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                    NSLog(@"%@",response);
                    NSLog(@"%@",jsonData);
                    if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:0]]){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add To Cart" message:@"User Already Added Product" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            
                        });
                        
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Add To Cart" message:@"User Successfully  Added Product" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            
                            [alert show];
                        });
                    }
                    
                    
                }
                
                
            }];
            
            [task resume];
            
        }
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
            }
}

-(IBAction)ClickOnBuyNow:(id)sender{
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 001) {
        [self refreshData];
    }else{
        [self refreshData];
    }
}

-(IBAction)ClickOnMoreReviews:(id)sender{
    AllReviewsViewController *allReviewsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"AllReviewsViewController"];
    allReviewsVc.ReviewModel = fetchModel;
    allReviewsVc.ReviewsMainArray = FetchReviewData;
    [self.navigationController pushViewController:allReviewsVc animated:YES];
    
    
}
@end
