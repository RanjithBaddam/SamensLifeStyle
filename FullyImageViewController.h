//
//  FullyImageViewController.h
//  samens
//
//  Created by All time Support on 16/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderModel.h"

@interface FullyImageViewController : UIViewController
@property(nonatomic,weak)IBOutlet UICollectionView *fullImageCollectionView;
@property(nonatomic,strong) SliderModel*fullImageModel;
@end
