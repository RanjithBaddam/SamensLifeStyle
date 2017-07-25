//
//  LoginDetailsModel.h
//  samens
//
//  Created by All time Support on 03/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginDetailsModel : NSObject
@property(nonatomic,strong)NSString *api;
@property(nonatomic,strong)NSString *custid;
@property(nonatomic,strong)NSString *dor;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *name;

-(void)loginDetailsModelWithDictionary:(NSDictionary *)dict;

@end
