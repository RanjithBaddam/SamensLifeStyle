//
//  URLhandler.m
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "URLhandler.h"

@implementation URLhandler
+(void)getJsonResultWithMutableURLRequst:(NSMutableURLRequest *)mutableRequest success:(void (^)(id , NSURLResponse *response))successHandler failure:(void(^)(NSError* error , NSURLResponse *response))failureHandler;
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:20.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData *data , NSURLResponse *response , NSError *error){
        if (error){
            failureHandler(error,response);
        }else{
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            successHandler(jsonObject , response);
        }
    }];
    [task resume];
}

@end
