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
@interface SortItemDisplayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>{
    NSString *MainSortItemId;
    NSMutableArray *sortMainData;
    NSString *mainSortItemName;
    
}

@end

@implementation SortItemDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",MainSortItemId);
    [self getSortItemId:MainSortItemId];
    NSLog(@"%@",mainSortItemName);
    [self getSortItemName:mainSortItemName];
    
    self.sortNameLabel.text = mainSortItemName;
    
    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"156ca995-b970-29f4-fa48-64f8abf98e30" };
    NSArray *parameters = @[ @{ @"name": @"subCatId", @"value": MainSortItemId } ];
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
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_sub_category_item.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
                                                                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
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
                                                        sortMainData = [[NSMutableArray alloc]init];
                                                        for (index=0; index<dammyArray.count; index++) {
                                                            NSDictionary *dict = dammyArray[index];
                                                            SortDisplayModel *sortModel = [[SortDisplayModel alloc]init];
                                                            [sortModel getSortDisplay:dict];
                                                            [sortMainData addObject:sortModel];
                                                            NSLog(@"%@",sortMainData);
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                            self.sortitemDisplayCollectionView.delegate = self;
                                                            self.sortitemDisplayCollectionView.dataSource = self;
                                                            [self.sortitemDisplayCollectionView reloadData];
                                                        });

                                                    }
                                                    
                                                }];
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getSortItemId:(NSString *)str{
    NSLog(@"%@",str);
    MainSortItemId = str;
   // mainSortItemName = str;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)sortMainData.count);
    return sortMainData.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SortItemCollectionViewCell *cell = [_sortitemDisplayCollectionView dequeueReusableCellWithReuseIdentifier:@"SortItemCollectionViewCell" forIndexPath:indexPath];
    SortDisplayModel *model = [sortMainData objectAtIndex:indexPath.item];
    NSLog(@"%@",model);
    NSLog(@"%@",model.image);
    [cell.sortItemDisplayImageView setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    cell.sortItemDisplayLabel.text = model.Name;
    return cell;
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
