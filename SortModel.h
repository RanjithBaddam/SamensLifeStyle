//
//  SortModel.h
//  samens
//
//  Created by All time Support on 12/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *sub_catid;
-(void)setModelWithDict:(NSDictionary *)dict;

@end
