//
//  CatogorysTableViewCell.h
//  samens
//
//  Created by All time Support on 08/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
#import "SubCategoryModel.h"

@interface CatogorysTableViewCell : UITableViewCell<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) CategoryModel *catModel;

@property(nonatomic,weak)IBOutlet UILabel *categoryNameLabel;
@property(nonatomic,weak)IBOutlet UIButton *categoryButton;




@end
