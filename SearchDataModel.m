//
//  SearchDataModel.m
//  samens
//
//  Created by All time Support on 31/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SearchDataModel.h"

@implementation SearchDataModel
-(void)getSearchDataModelWithDictionary:(NSDictionary *)dict{
    self.Name = [dict valueForKey:@"Name"];
    self.color = [dict valueForKey:@"color"];
    self.color_code = [dict valueForKey:@"color_code"];
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
    self.image2 = [dict valueForKey:@"image2"];
    self.image3 = [dict valueForKey:@"image3"];
    self.image4 = [dict valueForKey:@"image4"];
    self.like_v = [dict valueForKey:@"like_v"];
    self.off_price = [dict valueForKey:@"off_price"];
    self.offer = [dict valueForKey:@"offer"];
    self.pid = [dict valueForKey:@"pid"];
    self.price = [dict valueForKey:@"price"];
    self.rating = [NSString stringWithFormat:@"%@",[dict valueForKey:@"rating"]];

}

@end