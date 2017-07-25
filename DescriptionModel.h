//
//  DescriptionModel.h
//  samens
//
//  Created by All time Support on 21/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DescriptionModel : NSObject
@property(nonatomic,strong)NSString *Description;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *color_code;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *image2;
@property(nonatomic,strong)NSString *image3;
@property(nonatomic,strong)NSString *image4;
@property(nonatomic,strong)NSString *off_price;
@property(nonatomic,strong)NSString *offer;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *price;
//@property(nonatomic,strong)NSString *color;
//@property(nonatomic,strong)NSString *rating;

-(void)getModelWithDict:(NSDictionary *)dict;


@end
