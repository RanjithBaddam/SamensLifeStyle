//
//  LoginDetailsModel.m
//  samens
//
//  Created by All time Support on 03/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "LoginDetailsModel.h"

@implementation LoginDetailsModel
-(void)loginDetailsModelWithDictionary:(NSDictionary *)dict{
    self.api = [NSUserDefaults.standardUserDefaults valueForKey:@"api"];
    NSLog(@"%@",self.api);
    self.custid = [NSUserDefaults.standardUserDefaults valueForKey:@"custid"];
    NSLog(@"%@",self.custid);
    self.dor = [NSUserDefaults.standardUserDefaults valueForKey:@"dor"];

    self.email = [NSUserDefaults.standardUserDefaults valueForKey:@"email"];

   // self.image = [dict valueForKey:@"image"];
    self.mobile = [NSUserDefaults.standardUserDefaults valueForKey:@"mobile"];
    self.name = [NSUserDefaults.standardUserDefaults valueForKey:@"name"];

}

@end
