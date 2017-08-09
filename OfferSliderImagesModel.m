//
//  OfferSliderImagesModel.m
//  samens
//
//  Created by All time Support on 02/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "OfferSliderImagesModel.h"

@implementation OfferSliderImagesModel
-(void)getOfferSliderImagesModelWithDictionary:(NSDictionary *)dict{
    self.category_id = [dict valueForKey:@"category_id"];
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/image/%@",[dict valueForKey:@"image"]];
    NSLog(@"%@",self.image);
}

@end
