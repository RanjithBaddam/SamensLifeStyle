//
//  DescriptionModel.m
//  samens
//
//  Created by All time Support on 21/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "DescriptionModel.h"

@implementation DescriptionModel
-(void)getModelWithDict:(NSDictionary *)dict{
    self.Description = [dict valueForKey:@"Description"];
    NSLog(@"%@",self.Description);
    self.Name = [dict valueForKey:@"Name"];
    self.color_code = [dict valueForKey:@"color_code"];
    NSLog(@"%@",self.color_code);
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:self.image]];
    NSLog(@"%@",self.image);
    self.image2 = [dict valueForKey:@"image2"];
    self.image3 = [dict valueForKey:@"image3"];
    self.image4 = [dict valueForKey:@"image4"];
    self.off_price = [dict valueForKey:@"off_price"];
    self.offer = [dict valueForKey:@"offer"];
    self.pid = [dict valueForKey:@"pid"];
    NSLog(@"%@",self.pid);
    self.price = [dict valueForKey:@"price"];
//    self.color = [dict valueForKey:@"color"];
//    self.rating = [dict valueForKey:@"rating"];

}

@end
