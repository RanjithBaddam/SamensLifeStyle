//
//  CatogorysTableViewCell.m
//  samens
//
//  Created by All time Support on 08/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "CatogorysTableViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "CatProductModel.h"
#import "customProductCollectionViewCell.h"
#import "homeViewController.h"
#import "SubSubViewController.h"
#import "ViewController.h"
#import "IndivisualProductDetailsViewController.h"
#import "SubCategoryModel.h"



@implementation CatogorysTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return CGSizeMake((self.contentView.frame.size.width/2)-3, (self.contentView.frame.size.width/2)-3);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%@",_catModel.product);
    return _catModel.product.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
customProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customProductCollectionViewCell" forIndexPath:indexPath];
    UIImageView *imgView = [cell.contentView viewWithTag:100];
    
    CatProductModel *product = _catModel.product[indexPath.row];
    [imgView setImageWithURL:[NSURL URLWithString:product.image] placeholderImage:nil];
    NSLog(@"%@",imgView);
     
    NSLog(@"%@",product.name);
    cell.productImageNameLabel.text = product.name;
    if ([product.offer isEqualToString:@"yes"] ) {
        cell.priceOffLabel.text = product.off_price;
        NSAttributedString *theAttributedString;
        theAttributedString = [[NSAttributedString alloc] initWithString:cell.priceLabel.text = product.price
                                                              attributes:@{NSStrikethroughStyleAttributeName:
                                                                               [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        [cell.priceLabel setAttributedText:theAttributedString];

        NSString *string = cell.priceOffLabel.text;
        NSLog(@"%@",string);
        float value = [string floatValue];
        NSLog(@"%f",value);
        NSString *string1 = cell.priceLabel.text;
        float value1 = [string1 floatValue];
        NSLog(@"%f",value1);
        float pers = 100;
        float percentage = (pers * value)/value1;
        NSLog(@"%lf",percentage);
        int totalValue = pers - percentage;
        NSLog(@"%d",totalValue);
        NSString *persentage = [NSString stringWithFormat:@"%d%@",totalValue,@"%"];
        NSLog(@"%@",persentage);
        
        cell.offPersentageLabel.text = persentage;
        NSLog(@"%@",cell.offPersentageLabel.text);
        cell.offPersentageLabel.backgroundColor = [UIColor redColor];
        cell.offPersentageLabel.layer.cornerRadius = 13;
        cell.offPersentageLabel.clipsToBounds = YES;
//        cell.offPersentageLabel.layer.borderWidth = 1;
//        cell.offPersentageLabel.layer.borderColor = [UIColor redColor].CGColor;

    }else{
        cell.priceOffLabel.text = product.price;
        cell.priceLabel.text = nil;
        cell.offPersentageLabel.text = nil;
    }
    return cell;
  
        
   
//    NSAttributedString * title =
//    [[NSAttributedString alloc] initWithString:cell.priceOffLabel.text = product.off_price
//                                    attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
//    [cell.priceOffLabel setAttributedText:title];
   
    

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%@",indexPath);
    CatProductModel *model = _catModel.product[indexPath.row];
    NSLog(@"%@",model);
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"TestNotification"
     object:model];
}

@end
