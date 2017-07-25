//
//  SizeModel.m
//  samens
//
//  Created by All time Support on 20/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "SizeModel.h"

@implementation SizeModel
-(void)getModelWithDict:(NSDictionary *)dict{
    self.size = [dict valueForKey:@"size"];
}

@end
