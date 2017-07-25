//
//  SortDisplayModel.h
//  samens
//
//  Created by All time Support on 19/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortDisplayModel : NSObject
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *color;
@property(nonatomic,strong)NSString *color_code;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *image2;
@property(nonatomic,strong)NSString *image3;
@property(nonatomic,strong)NSString *image4;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *price;
-(void)getSortDisplay:(NSDictionary *)sortDict;


@end
