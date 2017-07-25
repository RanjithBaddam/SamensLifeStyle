//
//  CategoryModel.h
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject
@property(nonatomic,strong) NSString * category_id;
@property(nonatomic,strong) NSString * category_name;
@property(nonatomic,strong) NSString * image;
@property(nonatomic,strong) NSMutableArray * product;
-(void)setModelWithDict:(NSDictionary*)dict;
//@property(nonatomic,strong) NSMutableArray *imgArray;
//-(void)setModelWithImgDict:(NSDictionary *)dict;

@end
