//
//  ReviewFetchModel.m
//  samens
//
//  Created by All time Support on 30/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "ReviewFetchModel.h"

@implementation ReviewFetchModel
-(void)FetchModelWithDict:(NSDictionary *)dict{
    self.Name1 = [dict valueForKey:@"Name"];
    NSLog(@"%@",self.Name1);
    self.date = [dict valueForKey:@"date"];
    NSLog(@"%@",self.date);
    self.name = [dict valueForKey:@"name"];
    NSLog(@"%@",self.name);
    self.rate = [dict valueForKey:@"rate"];
    NSLog(@"%@",self.rate);
    self.review = [dict valueForKey:@"review"];
    NSLog(@"%@",self.review);
    self.title = [dict valueForKey:@"title"];
    NSLog(@"%@",self.title);
}

@end
