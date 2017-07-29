//
//  searchModel.m
//  samens
//
//  Created by All time Support on 28/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "searchModel.h"

@implementation searchModel
-(void)getSearchDataModelWithDictionary:(NSDictionary *)dict{
    self.category_id = [dict valueForKey:@"category_id"];
    self.name = [dict valueForKey:@"name"];
    self.product_id = [dict valueForKey:@"product_id"];

}

@end
