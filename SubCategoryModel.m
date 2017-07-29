//
//  SubCategoryModel.m
//  samens
//
//  Created by All time Support on 12/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SubCategoryModel.h"

@implementation SubCategoryModel
-(void)setModelWithDict:(NSDictionary *)dict{
    self.Name = [dict valueForKey:@"Name"];
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
    self.price = [dict valueForKey:@"price"];
    NSLog(@"%@",self.price);
    self.pid = [dict valueForKey:@"pid"];
    self.color_code = [dict valueForKey:@"color_code"];
    self.image2 = [dict valueForKey:@"image2"];

    self.image3 = [dict valueForKey:@"image3"];
    self.image4 = [dict valueForKey:@"image4"];
    
    self.color = [dict valueForKey:@"color"];
    NSLog(@"%@",self.color);
    self.off_price = [dict valueForKey:@"off_price"];
    NSLog(@"%@",self.off_price);
    self.offer = [dict valueForKey:@"offer"];
    NSLog(@"%@",self.offer);
    self.rating = [NSString stringWithFormat:@"%@",[dict valueForKey:@"rating"]];
    NSLog(@"%@",self.rating);
    
    self.like_v = [dict valueForKey:@"like_v"];
    NSLog(@"%@",self.like_v);
}



@end
