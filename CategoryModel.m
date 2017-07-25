//
//  CategoryModel.m
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "CategoryModel.h"
#import "CatProductModel.h"

@implementation CategoryModel
-(void)setModelWithDict:(NSDictionary*)dict{
    self.category_id = [dict valueForKey:@"category_id"];
    NSLog(@"%@",self.category_id);
    self.category_name = [dict valueForKey:@"category_name"];
    self.image = [NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/admin_dashboard/category_icon/%@",[dict valueForKey:@"image"]];
    
   
    
    
    NSArray *products = [dict valueForKey:@"product"];
    NSLog(@"%@",products);
    _product = [[NSMutableArray alloc]init];
    int catIndex;
    for (catIndex = 0; catIndex < products.count; catIndex++) {
        NSDictionary *dict = products[catIndex];
        NSLog(@"%@",dict);
        CatProductModel *productModel = [[CatProductModel alloc]init];
        [productModel setModelWithDict:dict];
        [_product addObject:productModel];
        NSLog(@"%@",_product);
        
    }

}

//-(void)setModelWithImgDict:(NSDictionary *)dict{
////NSArray *images = [dict valueForKey:@"image"];
////NSLog(@"%@",images);
//_imgArray = [[NSMutableArray alloc]init];
//int imgIndex;
//for (imgIndex = 0;imgIndex < images.count; imgIndex++) {
//    NSDictionary *dict = images[imgIndex];
//    NSLog(@"%@",dict);
//    CategoryModel *model = [[CategoryModel alloc]init];
//    [model setModelWithImgDict:dict];
//    [_imgArray addObject:model];
//    NSLog(@"%@",_imgArray);
//}

@end






//@interface CategoryProductModel : NSObject
//@property(nonatomic,strong) NSString * name;
//@property(nonatomic,strong) NSString * image;
//-(void)setModelWithDict:(NSDictionary*)dict;
//@end
//
//
//
//
//@implementation CategoryProductModel
//-(void)setModelWithDict:(NSDictionary*)dict{
//    self.image = [dict valueForKey:@"image"];
//    self.name = [dict valueForKey:@"name"];
//}
//@end
