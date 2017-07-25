//
//  SortDisplayModel.m
//  samens
//
//  Created by All time Support on 19/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SortDisplayModel.h"

@implementation SortDisplayModel
-(void)getSortDisplay:(NSDictionary *)sortDict{
    self.Name = [sortDict valueForKey:@"Name"];
    self.color = [sortDict valueForKey:@"color"];
    self.color_code = [sortDict valueForKey:@"color_code"];
    self.image =  [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[sortDict valueForKey:@"image"]];
    NSLog(@"%@",self.image);
    self.image2 = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[sortDict valueForKey:@"image2"]];
    self.image3 = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[sortDict valueForKey:@"image3"]];
    self.image4 = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[sortDict valueForKey:@"image4"]];
    self.pid = [sortDict valueForKey:@"pid"];
    NSLog(@"%@",self.pid);
    self.price = [sortDict valueForKey:@"price"];

}

@end
//http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/

//[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
