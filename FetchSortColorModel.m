//
//  FetchSortColorModel.m
//  samens
//
//  Created by All time Support on 26/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "FetchSortColorModel.h"

@implementation FetchSortColorModel
-(void)FetchSortColorModelWithDictionary:(NSDictionary *)dict{
    self.color_code = [dict valueForKey:@"color_code"];
}

@end
