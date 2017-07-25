//
//  CatagoryImageModel.h
//  samens
//
//  Created by All time Support on 04/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatagoryImageModel : NSObject
@property(nonatomic,strong)NSNumber *category_id;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *category_name;
@property(nonatomic,strong)NSString *product;
-(void)setModelWithDict:(NSDictionary *)dict;

@end
