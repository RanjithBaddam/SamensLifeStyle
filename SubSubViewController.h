//
//  SubSubViewController.h
//  samens
//
//  Created by All time Support on 11/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatProductModel.h"
#import "LoginDetailsModel.h"
#import "SubCategoryModel.h"
#import "SliderModel.h"

@interface SubSubViewController : UIViewController
-(void)getId:(NSString *)CategoryId;
-(void)getColor_code:(NSString *)colorCode;

-(void)getItemName:(NSString *)itemName;
-(void)getItemPrice:(NSString *)itemPrice;
@property(nonatomic,strong) NSString *subsubCatId;
@property(nonatomic,strong) NSString *mainColorCode;
@property(nonatomic,strong) NSString *ItemNameData;


@property(nonatomic,strong)IBOutlet UICollectionView *fullViewCollectionView;
@property(nonatomic,weak)IBOutlet UILabel *itemNameLabel;
@property(nonatomic,weak)IBOutlet UILabel *remainingLabel;
@property(nonatomic,weak)IBOutlet UILabel *itemPriceLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceOffLabel;
@property(nonatomic,weak)IBOutlet UILabel *persentageOffLabel;
@property(nonatomic,weak)IBOutlet UILabel *itemDeliveryInfoLabel;
@property(nonatomic,weak)IBOutlet UIButton *itemRatingButton;
-(IBAction)clickOnRating:(UIButton *)sender;
@property(nonatomic,weak)IBOutlet UIScrollView *subItemScrollView;
@property(nonatomic,weak)IBOutlet UICollectionView *sizeCollectionView;
@property(nonatomic,weak)IBOutlet UITableView *DescriptionTableView;

@property(nonatomic,weak)IBOutlet UILabel *QuantityLabel;
@property(nonatomic,weak)IBOutlet UICollectionView *relatedImagesCollectionView;
@property(nonatomic,weak)IBOutlet UIView *RatingPopUpView;
@property(nonatomic,weak)IBOutlet UITextField *CheckPinTextField;
@property(nonatomic,weak)IBOutlet UITextField *ratingTitle;
@property(nonatomic,weak)IBOutlet UITextField *ratingDescription;

@property(nonatomic,weak)IBOutlet UIStepper *quantityStepper;
-(IBAction)ValueChange:(UIStepper *)stepper;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns_outlet;

@property(nonatomic,weak)IBOutlet UICollectionView *colorImageCollectionView;
-(void)getColorImagesPid:(NSString *)colorImgPid;
-(void)getRelatedImageProductIdColorImages:(NSString *)RelatedImages;

-(void)refreshData;
-(IBAction)ClickOnAddToCart:(id)sender;
-(IBAction)ClickOnBuyNow:(id)sender;
@property(nonatomic,weak)IBOutlet UITableView *fetchReviewTableView;

@property(nonatomic,strong)NSMutableArray *loginDetailsArray;
@property(nonatomic,strong)LoginDetailsModel *loginModel;
@property(nonatomic,strong)SubCategoryModel *subCategoryModel;
@property(nonatomic,strong)SliderModel *sliderModel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btn_outlets;
@property(nonatomic,weak)IBOutlet UILabel *rateShowLabel1;
@end
