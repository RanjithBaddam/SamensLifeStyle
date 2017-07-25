//
//  RelatedImageModel.m
//  samens
//
//  Created by All time Support on 21/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "RelatedImageModel.h"

@implementation RelatedImageModel
-(void)getModelWithDictionary:(NSDictionary *)dict{
    self.Name = [dict valueForKey:@"Name"];
    NSLog(@"%@",self.Name);
    self.color = [dict valueForKey:@"color"];
    self.color_code = [dict valueForKey:@"color_code"];
    NSLog(@"%@",self.color_code);
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
    NSLog(@"%@",self.image);
    self.pid = [dict valueForKey:@"pid"];
    NSLog(@"%@",self.pid);
    self.price = [dict valueForKey:@"price"];

}

@end
