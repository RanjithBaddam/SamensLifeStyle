//
//  AddToCartViewController.m
//  samens
//
//  Created by All time Support on 30/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AddToCartViewController.h"
#import "AddToCartModel.h"
#import "AddToCartTableViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import <MBProgressHUD.h>
#import "DetailsTableViewCell.h"
#import "ViewController.h"

@interface AddToCartViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    AddToCartModel *addToCartModel;
    NSMutableArray *AddToCartData;
    NSMutableArray *Remove;
    NSMutableArray *AmountArray;
    NSString *finalSum;
    IBOutlet UIView *quantityView;
    float eachPrice;
    int defaultStepperValue;
    NSMutableArray *quantityArray;
    NSMutableArray *priceArray;
    NSMutableArray *allLabelsTextArray;
    NSMutableArray *titlesArray;
    NSMutableArray *idsArray;
    NSMutableArray *sizeArray;
    NSMutableArray *colorArray;
    NSArray *dammyArray;
    IBOutlet UIImageView *emptyCartImageView;
}


@end

@implementation AddToCartViewController
-(void)viewWillAppear:(BOOL)animated{
    [self FetchAddToCart];
   

 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AmountArray = [[NSMutableArray alloc]initWithObjects:@"price",@"Delivery", nil];
    dammyArray = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)FetchAddToCart{
        if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"] || [[NSUserDefaults.standardUserDefaults valueForKey:@"login"]isEqualToString:@"google"] || [[NSUserDefaults.standardUserDefaults valueForKey:@"login"]isEqualToString:@"facebook"]){
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    quantityArray = [[NSMutableArray alloc]init];
    priceArray = [[NSMutableArray alloc]init];
    
    sizeArray = [[NSMutableArray alloc]init];
    colorArray = [[NSMutableArray alloc]init];
    titlesArray = [[NSMutableArray alloc]init];
    idsArray = [[NSMutableArray alloc]init];

    allLabelsTextArray = [[NSMutableArray alloc]init];
    
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_basketdata.php"];
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
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        if (error) {
            NSLog(@"%@",err);
            _AddToCartTableView.hidden = YES;
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
           
             dammyArray = [jsonData valueForKey:@"categories"];
            NSLog(@"%@",dammyArray);
            int index;
            AddToCartData = [[NSMutableArray alloc]init];
             eachPrice = 0;
            for (index=0; index<dammyArray.count; index++) {
                NSDictionary *dict = dammyArray[index];
                [quantityArray addObject:dict[@"quantity"]];
                [priceArray addObject:dict[@"price"]];
                eachPrice += [[dict valueForKey:@"price"] intValue] * [[dict valueForKey:@"quantity"] intValue];
                addToCartModel = [[AddToCartModel alloc]init];
                [addToCartModel AddToCartModelWithDictionary:dict];
                [AddToCartData addObject:addToCartModel];
            
                [colorArray addObject:dict[@"color"]];
                [sizeArray addObject:dict[@"size"]];
                [titlesArray addObject:dict[@"name"]];
                [idsArray addObject:dict[@"cid"]];

            }
            [NSUserDefaults.standardUserDefaults setObject:dammyArray forKey:@"AddToCart"];
            NSLog(@"%@",quantityArray);
            NSLog(@"%@",jsonData);
            finalSum = [NSString stringWithFormat:@"%.0f",eachPrice];
            NSLog(@"%@",finalSum);
            if (dammyArray==NULL) {
                _AddToCartTableView.hidden = YES;
                emptyCartImageView.hidden = NO;
            }else{
                _AddToCartTableView.hidden = NO;
                emptyCartImageView.hidden = YES;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                _totalPriceLabel.text = finalSum;
                _AddToCartTableView.delegate = self;
                _AddToCartTableView.dataSource = self;
                [_AddToCartTableView reloadData];
                
            });
        }

    }];
    [task resume];
        }else{
            [self.tabBarController setSelectedIndex:3];
            
        }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return 2;
    }
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        
        NSLog(@"%lu",(unsigned long)AddToCartData.count);
        return AddToCartData.count;
    }else{
    return 1;
        
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section==0) {
    
        AddToCartTableViewCell *cell = [_AddToCartTableView dequeueReusableCellWithIdentifier:@"AddToCartTableViewCell"];
        
        addToCartModel = [AddToCartData objectAtIndex:indexPath.row];
        NSLog(@"%@",addToCartModel.image);
        [cell.ProductImage setImageWithURL:[NSURL URLWithString:addToCartModel.image] placeholderImage:nil];
        cell.ProductNameLabel.text = addToCartModel.name;
        NSLog(@"%@",cell.ProductNameLabel.text);
        cell.colorLabel.text = addToCartModel.color;
        cell.SizeLabel.text = addToCartModel.size;
        
        cell.PriceLabel.text = [NSString stringWithFormat:@"%.0d",([[priceArray objectAtIndex:indexPath.row] intValue]*[[quantityArray objectAtIndex:indexPath.row] intValue])];
        
        [cell.removeButton addTarget:self action:@selector(clickOnRemoveAddtoCart:) forControlEvents:UIControlEventTouchUpInside];
        cell.quantityStepper.minimumValue = 1;
        cell.quantityStepper.value = [[quantityArray objectAtIndex:indexPath.row] intValue];
        cell.quantityStepper.tag = indexPath.row;
        [cell.quantityStepper addTarget:self action:@selector(ClickOnStepper:) forControlEvents:UIControlEventTouchUpInside];
        cell.stepperQuantityLabel.text = [quantityArray objectAtIndex:indexPath.row];
        cell.removeButton.tag = indexPath.row;
        NSLog(@"%ld",(long)cell.removeButton.tag);
        
        [cell.moveToWishListButton addTarget:self action:@selector(clickOnMoveTowishList:) forControlEvents:UIControlEventTouchUpInside];
        cell.moveToWishListButton.tag = indexPath.row;
        NSLog(@"%ld",(long)cell.moveToWishListButton.tag);
     
        [allLabelsTextArray addObject:cell.PriceLabel.text];
        
        return cell;

    }else{
        DetailsTableViewCell *cell;
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailsTableViewCell" owner:nil options:nil];
        for (id curentObject in topLevelObjects)
        {
            
            if ([curentObject isKindOfClass:[UITableViewCell class]])
            {
          cell = [[DetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailsTableViewCell"];
                cell = (DetailsTableViewCell *)curentObject;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                NSLog(@"%@",addToCartModel.priceArray);
                cell.PriceAmountLabel.text = finalSum;
                cell.DeliveryLabel.text = @"Free";
                cell.AmountPayableLabel.text = finalSum;
                break;
            }
        }
        return cell;
    }
    
}



-(IBAction)clickOnRemoveAddtoCart:(UIButton *)sender{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/deletefeed.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    addToCartModel = [AddToCartData objectAtIndex:sender.tag];
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&pid=%@&size=%@&color=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],addToCartModel.pid,addToCartModel.size,addToCartModel.color];
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
                    [AddToCartData removeObjectAtIndex:sender.tag];
                    [_AddToCartTableView reloadData];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"User successfully removed from cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    alert.tag = 100;
                    [alert show];
                    [self FetchAddToCart];
                  
                });

        }
        }
    
    }];
    [task resume];
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == 100){
//        if (buttonIndex == 1){
//            [AddToCartData removeObject:buttonIndex];
//            [self FetchAddToCart];
//
//        }else{
//            [_AddToCartTableView reloadData];
//            [self FetchAddToCart];
//        }
//    }
//}
-(IBAction)clickOnMoveTowishList:(UIButton *)sender{
   
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/send_indivi_like.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *params = [NSString stringWithFormat:@"cid=%@&api=%@&status=%@&pid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"],[NSUserDefaults.standardUserDefaults valueForKey:@"api"],@"Y",addToCartModel.pid];
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
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                    AddToCartTableViewCell *cell = [_AddToCartTableView cellForRowAtIndexPath:selectedIndexPath];
                    [self clickOnRemoveAddtoCart:cell.moveToWishListButton];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
                    AddToCartTableViewCell *cell1 = [_AddToCartTableView cellForRowAtIndexPath:selectedIndexPath];
                    [self clickOnRemoveAddtoCart:cell1.moveToWishListButton];
                });
            }
        }
    }];
    [task resume];
    
}



-(IBAction)ClickOnChangePincode:(id)sender{
    
}
-(IBAction)ClickOnStepper:(UIStepper *)sender{
    
    double value = [[priceArray objectAtIndex:sender.tag] intValue];
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    AddToCartTableViewCell *cell = [_AddToCartTableView cellForRowAtIndexPath:selectedIndexPath];
    
    NSString *stepper = [NSString stringWithFormat:@"%d",(int)sender.value];
    [cell.stepperQuantityLabel setText:stepper];
    
    cell.PriceLabel.text = [NSString stringWithFormat:@"%.0f",([stepper intValue] * value)];
    
    [allLabelsTextArray replaceObjectAtIndex:sender.tag withObject:cell.PriceLabel.text];
    
    [quantityArray replaceObjectAtIndex:sender.tag withObject:stepper];
    
    int sum = 0;
    for (NSString *eachLableText in allLabelsTextArray){
        sum += [eachLableText intValue];
    }
    
    NSIndexPath *selectedIndexPath2 = [NSIndexPath indexPathForRow:1 inSection:1];
    DetailsTableViewCell *cell2 = [_AddToCartTableView cellForRowAtIndexPath:selectedIndexPath2];
    dispatch_async(dispatch_get_main_queue(), ^{
    cell2.AmountPayableLabel.text = [NSString stringWithFormat:@"%i",sum];
    cell2.PriceAmountLabel.text = [NSString stringWithFormat:@"%i",sum];
    
    _totalPriceLabel.text = [NSString stringWithFormat:@"%i",sum];
    });
//    [self updateCart:sender.tag withQuantity:stepper];
}
-(void)updateCart:(int)tag withQuantity:(NSString *)quantity{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
    NSMutableArray *paramsArray=[[NSMutableArray alloc]init];
    [paramsArray addObject:[idsArray objectAtIndex:tag]];
    [paramsArray addObject:[NSString stringWithFormat:@"cid=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"custid"]]];
    [paramsArray addObject:[NSString stringWithFormat:@"price=%@",[priceArray objectAtIndex:tag]]];
    [paramsArray addObject:[NSString stringWithFormat:@"title=%@",[titlesArray objectAtIndex:tag]]];
    [paramsArray addObject:[NSString stringWithFormat:@"api=%@",[NSUserDefaults.standardUserDefaults valueForKey:@"api"]]];
    
    [paramsArray addObject:[NSString stringWithFormat:@"size=%@",[sizeArray objectAtIndex:tag]]];
    [paramsArray addObject:[NSString stringWithFormat:@"color=%@",[colorArray objectAtIndex:tag]]];
    
    [paramsArray addObject:[NSString stringWithFormat:@"quantity=%@",quantity]];
    
    NSString *params = [paramsArray componentsJoinedByString:@"&"];

//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSString *strloadingText = [NSString stringWithFormat:@""];
//        hud.label.text = strloadingText;
        NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/add_to_cart.php"];
        NSURL *url=[NSURL URLWithString:urlInstring];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
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
                NSLog(@"%@",jsonData);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [self FetchAddToCart];
                        });
            }
            
            
        }];
        
        [task resume];
    });

}
@end
