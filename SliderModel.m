//
//  SliderModel.m
//  samens
//
//  Created by All time Support on 28/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SliderModel.h"

@implementation SliderModel
-(void)getSliderModelWithDict:(NSDictionary *)dict{
    self.Description = [dict valueForKey:@"Description"];
    self.Name = [dict valueForKey:@"Name"];
    NSLog(@"%@",self.Name);
    self.brand = [dict valueForKey:@"brand"];
    self.color_code = [dict valueForKey:@"color_code"];
    NSLog(@"%@",self.color_code);
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
    NSLog(@"%@",self.image);
    self.image2 = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image2"]];
    NSLog(@"%@",self.image2);
    self.image3 = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image3"]];
    NSLog(@"%@",self.image3);
    self.image4 = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image4"]];
    NSLog(@"%@",self.image4);
    self.off_price = [dict valueForKey:@"off_price"];
    self.offer = [dict valueForKey:@"offer"];
    self.pid = [dict valueForKey:@"pid"];
    NSLog(@"%@",self.pid);
    self.price = [dict valueForKey:@"price"];

    self.quantity = [dict valueForKey:@"quantity"];
    NSLog(@"%@",self.quantity);
    self.rating = [dict valueForKey:@"rating"];
    
    _sliderImages = [[NSMutableArray alloc]initWithObjects:self.image,self.image2,self.image3,self.image4, nil];
    NSLog(@"%@",_sliderImages);
    

}




@end
