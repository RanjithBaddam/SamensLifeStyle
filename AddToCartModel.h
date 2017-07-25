//
//  AddToCartModel.h
//  samens
//
//  Created by All time Support on 30/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddToCartModel : NSObject
@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *color;
@property(nonatomic,strong)NSString *custid;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSString *size;
@property(nonatomic,strong)NSMutableArray *priceArray;
-(void)AddToCartModelWithDictionary:(NSDictionary *)dict;


@end
