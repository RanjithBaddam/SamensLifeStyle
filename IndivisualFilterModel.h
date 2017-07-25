//
//  IndivisualFilterModel.h
//  samens
//
//  Created by All time Support on 25/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndivisualFilterModel : NSObject
@property(nonatomic,weak)NSString *Name;
@property(nonatomic,weak)NSString *color;
@property(nonatomic,weak)NSString *color_code;
@property(nonatomic,weak)NSString *image;
@property(nonatomic,weak)NSString *image2;
@property(nonatomic,weak)NSString *image3;
@property(nonatomic,weak)NSString *image4;
@property(nonatomic,weak)NSString *off_price;
@property(nonatomic,weak)NSString *offer;
@property(nonatomic,weak)NSString *pid;
@property(nonatomic,weak)NSString *price;
@property(nonatomic,weak)NSString *rating;

-(void)setIndivisualFilterItemWithDictionary:(NSDictionary *)dict;

@end
