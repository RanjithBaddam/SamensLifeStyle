//
//  CatProductModel.m
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "CatProductModel.h"

@implementation CatProductModel
-(void)setModelWithDict:(NSDictionary*)dict{
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
    NSLog(@"%@",self.image);
    self.name = [dict valueForKey:@"name"];
    NSLog(@"%@",self.name);
    self.brand = [dict valueForKey:@"brand"];
    NSLog(@"%@",self.brand);
    self.color = [dict valueForKey:@"color"];
    NSLog(@"%@",self.color);
    self.color_code = [dict valueForKey:@"color_code"];
    NSLog(@"%@",self.color_code);
    self.off_price = [dict valueForKey:@"off_price"];
    NSLog(@"%@",self.off_price);
    self.offer = [dict valueForKey:@"offer"];
    NSLog(@"%@",self.offer);
    self.pid = [dict valueForKey:@"pid"];
    NSLog(@"%@",self.pid);
    self.price = [dict valueForKey:@"price"];
    NSLog(@"%@",self.price);
    self.subid = [dict valueForKey:@"subid"];
    NSLog(@"%@",self.subid);

}

@end
