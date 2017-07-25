//
//  FullyImageViewController.m
//  samens
//
//  Created by All time Support on 16/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "FullyImageViewController.h"
#import "FullImageViewCollectionViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface FullyImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
{
    

}
@end

@implementation FullyImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fullImageCollectionView.delegate = self;
    self.fullImageCollectionView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.fullImageModel.sliderImages.count;
 
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FullImageViewCollectionViewCell *cell = [_fullImageCollectionView dequeueReusableCellWithReuseIdentifier:@"FullImageViewCollectionViewCell" forIndexPath:indexPath];
       [cell.fullImageView setImageWithURL:[NSURL URLWithString:[self.fullImageModel.sliderImages objectAtIndex:indexPath.item]] placeholderImage:nil];
    cell.fullImageView.tag = indexPath.item;
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(clickOnPinch:)];
    [cell.fullImageView addGestureRecognizer:pinchGesture];
    
    
    return cell;
}
-(IBAction)clickOnPinch:(UIGestureRecognizer *)sender{
    NSLog(@"PinchGesture");
}
//-(IBAction)clickOnPinch:(UIPinchGestureRecognizer *)sender{
//    CGFloat lastScaleFactor =1;
//    CGFloat factor = [(UIPinchGestureRecognizer *)sender scale];
//    if (factor >1) {
//        sender.transform = CGAffineTransformMakeScale(
//                                                          lastScaleFactor + (factor -1),
//                                                          lastScaleFactor + (factor -1));
//        
//        
//        
//    }else{
//        _imageview.transform = CGAffineTransformMakeScale(
//                                                          lastScaleFactor *factor
//                                                          , lastScaleFactor *factor);
//    }
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        if (factor > 1) {
//            lastScaleFactor += (factor-1);
//            
//        }else{
//            lastScaleFactor *= factor;
//        }
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
