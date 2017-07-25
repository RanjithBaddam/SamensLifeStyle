//
//  filterItemModel.m
//  samens
//
//  Created by All time Support on 24/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "filterItemModel.h"

@implementation filterItemModel
-(void)setFilterModelWithDictionary:(NSDictionary *)dict{
    self.color_code = [dict valueForKey:@"color_code"];
    
}

@end
