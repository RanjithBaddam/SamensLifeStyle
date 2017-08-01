//
//  SortModel1.h
//  samens
//
//  Created by All time Support on 31/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortModel1 : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *sub_catid;
-(void)getSort1ModelWithDictionary:(NSDictionary *)dict;
@end
