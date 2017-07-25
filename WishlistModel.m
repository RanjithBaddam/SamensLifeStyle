//
//  WishlistModel.m
//  samens
//
//  Created by All time Support on 04/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "WishlistModel.h"

@implementation WishlistModel
-(void)getWishListModelWithDictionary:(NSDictionary *)dict{
    self.Description = [dict valueForKey:@"Description"];
    self.Name = [dict valueForKey:@"Name"];
    self.color_code = [dict valueForKey:@"color_code"];
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
    NSLog(@"%@",self.image);
    self.off_price = [dict valueForKey:@"off_price"];
    self.offer = [dict valueForKey:@"offer"];
    self.pid = [dict valueForKey:@"pid"];
    NSLog(@"%@",self.pid);
    self.price = [dict valueForKey:@"price"];
    self.quantity = [dict valueForKey:@"quantity"];
    self.rate = [dict valueForKey:@"rate"];
    NSLog(@"%@",self.rate);
    self.subid = [dict valueForKey:@"subid"];
  

}

@end
