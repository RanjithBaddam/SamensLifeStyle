//
//  imageCatagory.m
//  samens
//
//  Created by All time Support on 04/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "imageCatagory.h"

@implementation imageCatagory
-(void)setModelWithDict:(NSDictionary*)dict{
    
    self.category_id = [dict valueForKey:@"category_id"];
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/slider_image/%@",[dict valueForKey:@"image"]];
    

}
@end
