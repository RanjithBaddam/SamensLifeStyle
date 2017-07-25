//
//  SliderModel.h
//  samens
//
//  Created by All time Support on 28/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SliderModel : NSObject
@property(nonatomic,strong)NSString *Description;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *brand;
@property(nonatomic,strong)NSString *color_code;

@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *image2;
@property(nonatomic,strong)NSString *image3;
@property(nonatomic,strong)NSString *image4;
@property(nonatomic,strong)NSString *off_price;
@property(nonatomic,strong)NSString *offer;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *rating;
@property(nonatomic,strong)NSMutableArray *sliderImages;
-(void)getSliderModelWithDict:(NSDictionary *)dict;

@end
