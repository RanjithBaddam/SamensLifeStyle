//
//  ItemVariantViewController.m
//  samens
//
//  Created by All time Support on 20/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "ItemVariantViewController.h"
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFNetworking/AFURLResponseSerialization.h>

@interface ItemVariantViewController (){
    NSString *MainColorCode;
    NSString *MainItemName;
}

@end

@implementation ItemVariantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self getColorData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getColorData{
    [self getMainItemName:MainItemName];
    [self getColor_code:MainColorCode];
    
    /*
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSString *params = [NSString stringWithFormat:@"subCatId=%@&c=%@",@"Samens  Full Sleeves Textured Shirt",@"#565c6c"];
    NSLog(@"%@",params);
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestData);
    [request setHTTPBody:requestData];
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:30.0];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data , NSURLResponse *response , NSError *error){
        if (error){
            NSLog(@"%@",error);
        }else{
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",jsonData);
        }
    }];
        [task resume];
     */
    

//    NSArray *parameters = @[@{ @"name": @"subCatId", @"value": @"Samens  Full Sleeves Textured Shirt" },
//                             @{ @"name": @"c", @"value": @"#565c6c" }];
//    
//    NSError *error;
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:&error];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"]
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:20.0];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:postData];

    
//    NSURL *baseURL = [NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"];
//    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
//
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain, text/html, application/json, audio/wav, application/octest-stream"];
//
//    [manager POST:@"POST" parameters:[NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:&error] constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
//    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
//     {
//         // Success
//         NSLog(@"Success: %@", responseObject);
//     }failure:^(NSURLSessionDataTask *task, NSError *error)
//     {
//         // Failure
//         NSLog(@"Failure: %@", error);
//     }];
    
    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"b5f2ec96-2a48-ca3a-98c8-ceafde4799ce" };
    NSArray *parameters = @[ @{ @"name": @"subCatId", @"value": @"Samens  Full Sleeves Textured Shirt" },
                             @{ @"name": @"c", @"value": @"#565c6c" } ];
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
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_filterd_sub_category_item.php"]
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
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        
                                                        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                        NSLog(@"%@",jsonData);
                                                    }
                                                    
                                                }];
    [dataTask resume];
    
    
   
}
-(void)getColor_code:(NSString *)ColorCode{
    NSLog(@"%@",ColorCode);
    MainColorCode = ColorCode;
    NSLog(@"%@",MainColorCode);
}
-(void)getMainItemName:(NSString *)itemName{
    NSLog(@"%@",itemName);
    MainItemName = itemName;
    NSLog(@"%@",MainItemName);
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
