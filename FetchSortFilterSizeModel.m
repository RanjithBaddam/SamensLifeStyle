//
//  FetchSortFilterSizeModel.m
//  samens
//
//  Created by All time Support on 27/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "FetchSortFilterSizeModel.h"

@implementation FetchSortFilterSizeModel
-(void)getSortFilterSizeModelWithDictionary:(NSDictionary *)dict{
    self.Name = [dict valueForKey:@"Name"];
    self.color = [dict valueForKey:@"color"];
    self.color_code = [dict valueForKey:@"color_code"];
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
    self.image2 = [dict valueForKey:@"image2"];
    self.image3 = [dict valueForKey:@"image3"];
    self.image4 = [dict valueForKey:@"image4"];
    self.off_price = [dict valueForKey:@"off_price"];
    self.offer = [dict valueForKey:@"offer"];
    self.pid = [dict valueForKey:@"pid"];
    self.price = [dict valueForKey:@"price"];
    self.rating = [dict valueForKey:@"rating"];

}

@end
