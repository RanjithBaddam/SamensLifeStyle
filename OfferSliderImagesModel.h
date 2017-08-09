//
//  OfferSliderImagesModel.h
//  samens
//
//  Created by All time Support on 02/08/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferSliderImagesModel : NSObject
@property(nonatomic,strong)NSString *category_id;
@property(nonatomic,strong)NSString *image;

-(void)getOfferSliderImagesModelWithDictionary:(NSDictionary *)dict;

@end
