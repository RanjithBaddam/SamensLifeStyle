//
//  CatagoryImageModel.m
//  samens
//
//  Created by All time Support on 04/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "CatagoryImageModel.h"

@implementation CatagoryImageModel
-(void)setModelWithDict:(NSDictionary *)dict{
    [self.category_name valueForKey:@"category_name"];
    [self.category_id valueForKey:@"category_id"];
    [self.image valueForKey:@"image"];
    [self.product valueForKey:@"product"];
}

@end
