//
//  RelatedImageModel.h
//  samens
//
//  Created by All time Support on 21/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RelatedImageModel : NSObject
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *color;
@property(nonatomic,strong)NSString *color_code;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *price;

-(void)getModelWithDictionary:(NSDictionary *)dict;


@end
