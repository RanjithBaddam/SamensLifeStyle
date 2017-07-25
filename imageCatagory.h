//
//  imageCatagory.h
//  samens
//
//  Created by All time Support on 04/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imageCatagory : NSObject
@property(nonatomic,strong)NSNumber *category_id;
@property(nonatomic,strong)NSString *image;
-(void)setModelWithDict:(NSDictionary*)dict;

@end
