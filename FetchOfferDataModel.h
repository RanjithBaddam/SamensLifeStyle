//
//  FetchOfferDataModel.h
//  samens
//
//  Created by All time Support on 02/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchOfferDataModel : NSObject
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *color;
@property(nonatomic,strong)NSString *color_code;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *like_v;
@property(nonatomic,strong)NSString *off_price;
@property(nonatomic,strong)NSString *offer;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *rating;


-(void)getFetchOfferDataModelWithDictionary:(NSDictionary *)dict;

@end
