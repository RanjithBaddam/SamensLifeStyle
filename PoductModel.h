//
//  PoductModel.h
//  samens
//
//  Created by All time Support on 05/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoductModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *image;
-(void)getNameImage:(NSDictionary *)dict;

@end
