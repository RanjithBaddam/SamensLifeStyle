//
//  CatProductModel.h
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatProductModel : NSObject
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * image;
@property(nonatomic,strong) NSString * brand;
@property(nonatomic,strong) NSString * color;
@property(nonatomic,strong) NSString * color_code;
@property(nonatomic,strong) NSString * off_price;
@property(nonatomic,strong) NSString * offer;
@property(nonatomic,strong) NSString * pid;
@property(nonatomic,strong) NSString * price;
@property(nonatomic,strong) NSString * subid;

-(void)setModelWithDict:(NSDictionary*)dict;



@end
