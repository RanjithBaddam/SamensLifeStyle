//
//  AddressDetailsModel.h
//  samens
//
//  Created by All time Support on 10/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressDetailsModel : NSObject
@property(nonatomic,strong)NSString *add_type;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *full_address;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *landmark;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *mobile_sec;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *pincode;
@property(nonatomic,strong)NSString *state;

-(void)getAddressModelWithDictionary:(NSDictionary *)dict;
@end
