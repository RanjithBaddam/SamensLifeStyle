//
//  URLhandler.h
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLhandler : NSObject
+(void)getJsonResultWithMutableURLRequst:(NSMutableURLRequest *)mutableRequest success:(void (^)(id , NSURLResponse *response))successHandler failure:(void(^)(NSError* error , NSURLResponse *response))failureHandler;
@end
