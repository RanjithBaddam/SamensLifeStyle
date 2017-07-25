//
//  ReviewFetchModel.h
//  samens
//
//  Created by All time Support on 30/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewFetchModel : NSObject
@property(nonatomic,strong)NSString *Name1;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *rate;
@property(nonatomic,strong)NSString *review;
@property(nonatomic,strong)NSString *title;
-(void)FetchModelWithDict:(NSDictionary *)dict;
@end
