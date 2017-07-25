//
//  WishlistModel.h
//  samens
//
//  Created by All time Support on 04/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WishlistModel : NSObject
@property(nonatomic,strong)NSString *Description;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *color_code;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *off_price;
@property(nonatomic,strong)NSString *offer;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *rate;
@property(nonatomic,strong)NSString *subid;

-(void)getWishListModelWithDictionary:(NSDictionary *)dict;

@end
