//
//  AdsBannerModel.m
//  samens
//
//  Created by All time Support on 11/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AdsBannerModel.h"

@implementation AdsBannerModel
-(void)setModelWithDict:(NSDictionary *)dict{
    self.mob_image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/login_banner/%@",[dict valueForKey:@"mob_image"]];
}


@end
