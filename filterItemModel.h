//
//  filterItemModel.h
//  samens
//
//  Created by All time Support on 24/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface filterItemModel : NSObject
@property(nonatomic,weak)NSString *color_code;
-(void)setFilterModelWithDictionary:(NSDictionary *)dict;

@end
