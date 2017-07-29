//
//  searchModel.h
//  samens
//
//  Created by All time Support on 28/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchModel : NSObject
@property(nonatomic,strong)NSString *category_id;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *product_id;
-(void)getSearchDataModelWithDictionary:(NSDictionary *)dict;
@end
