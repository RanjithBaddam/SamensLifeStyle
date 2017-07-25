//
//  ItemSizeViewController.h
//  samens
//
//  Created by All time Support on 20/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemSizeViewController : UIViewController
-(void)GetProductid:(NSString *)productid;

@property(nonatomic,weak)IBOutlet UICollectionView *sizeCollectionView;
@end
