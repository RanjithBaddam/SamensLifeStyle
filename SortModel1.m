//
//  SortModel1.m
//  samens
//
//  Created by All time Support on 31/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SortModel1.h"

@implementation SortModel1
-(void)getSort1ModelWithDictionary:(NSDictionary *)dict{
    self.name = [dict valueForKey:@"name"];
    self.sub_catid = [dict valueForKey:@"sub_catid"];
    
}

@end
