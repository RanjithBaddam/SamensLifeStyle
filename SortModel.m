//
//  SortModel.m
//  samens
//
//  Created by All time Support on 12/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SortModel.h"

@implementation SortModel
-(void)setModelWithDict:(NSDictionary *)dict{
    self.name = [dict valueForKey:@"name"];
    NSLog(@"%@",self.name);
    self.sub_catid = [dict valueForKey:@"sub_catid"];
}

@end
