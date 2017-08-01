//
//  homeViewController.m
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "homeViewController.h"
#import "imageCatagory.h"
#import "ItemsCollectionViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "CategoryModel.h"
#import "CatProductModel.h"
#import "CatogorysTableViewCell.h"
#import "pageSlideCollectionViewCell.h"
#import "ItemsDisplayViewController.h"
#import "SubCategoryModel.h"
#import <MBProgressHUD.h>
#import "SubSubViewController.h"
#import "SliderModel.h"
#import "SearchViewController.h"


@interface homeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>{
    
    UIActivityIndicatorView *imageActivity;
    
    NSMutableArray *pageArrayData;
    NSTimer *timer;
    NSInteger currentAnimationIndex;
    NSMutableArray *sliderImagesData;
    NSString *product_id;
    CategoryModel *catModel;
    SliderModel *subModel;
}
@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *img = [UIImage imageNamed:@"NavigationImage"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setBarTintColor:[UIColor colorWithRed:38.0/255.0 green:47.0/255.0 blue:88.0/255.0 alpha:0]];
    
    timer = [[NSTimer alloc]init];
    _mainArray = [[NSMutableArray alloc]init];
    [self refreshMethod];
    
    imageActivity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
   
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 3000);
    self.tabBarController.delegate = self;
    
    
    NSString *loginModel = [NSUserDefaults.standardUserDefaults valueForKey:@"api"];
    NSLog(@"%@",loginModel);
    
    self.navigationItem.hidesBackButton = YES;
    self.searchBar.delegate = self;
    

    

}
-(void)refreshMethod{
    [self getcatagory];
    [self getAnimationImages];

}
-(void)getAnimationImages{
    dispatch_async(dispatch_get_main_queue(), ^{

    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
    hud.label.text = strloadingText;
    });
    NSDictionary *headers = @{ @"catagory_id": @"catagory_id",
                               @"cache-control": @"no-cache",
                               @"postman-token": @"1508bc44-9828-16e6-258a-472db435fa2f" };
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_slider_image.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    dispatch_async(dispatch_get_main_queue(),^{
                                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                   });

                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                            _pageCollectionView.hidden = YES;
                                                        if ([error.localizedDescription isEqualToString:@"The request timed out."]){
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                               
                                                                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
                                                                alertView.tag = 001;
                                                                [alertView show];
                                                            });
                                                        }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
                                                            dispatch_async(dispatch_get_main_queue(),^{
                                                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                                                alertView.tag = 002;
                                                            [alertView show];
                                                            });
                                                    }
                                                        
                                                }
                                                                    
                                                    
                                                  else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        id SliderImageData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                        NSLog(@"%@",SliderImageData);
                                                        pageArrayData = [[NSMutableArray alloc]init];
                                                        
                                                        NSLog(@"%@",pageArrayData);
                                                        
                                                        NSArray *dummyCatArray = [SliderImageData objectForKey:@"categories"];
                                                        int index;
                                                        
                                                        for (index = 0; index < dummyCatArray.count; index++) {
                                                            NSDictionary *dict = dummyCatArray[index];
                                                            imageCatagory *imgModel = [[imageCatagory alloc]init];
                                                            [imgModel setModelWithDict:dict];
                                                            [pageArrayData addObject:imgModel];
                                                            
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                            [_pageCollectionView reloadData];
                                                            _pageCollectionView.delegate = self;
                                                            _pageCollectionView.dataSource = self;
                                                            timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(performSlideAnimation:) userInfo:nil repeats:true];
                                                            currentAnimationIndex = 0;
                                                            
                                                        });

                                                        
                                                    }
                                                }];

    [dataTask resume];
}

-(IBAction)performSlideAnimation:(id)sender{
    [self.pageCollectionView layoutIfNeeded];
    if (currentAnimationIndex >= pageArrayData.count) {
        currentAnimationIndex = 0;
    }
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentAnimationIndex inSection:0];
    [_pageCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    currentAnimationIndex = currentAnimationIndex + 1;
    
}

-(void)getcatagory{
    dispatch_async(dispatch_get_main_queue(), ^(void){

    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
    hud.label.text = strloadingText;
    });
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/newfetchmaa.php"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    NSURLSession *session1 = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session1 dataTaskWithRequest:request
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     dispatch_async(dispatch_get_main_queue(),^{
                                                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                     });
                                                     if (error) {
                                                        
                                                         NSLog(@"%@", error);
                                                         _collectionView.hidden = YES;
                                                         if ([error.localizedDescription isEqualToString:@"The request timed out."]){
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                
                                                                 UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
                                                                 alertView.tag = 001;
                                                                 [alertView show];
                                                             });
                                                         }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
                                                             dispatch_async(dispatch_get_main_queue(),^{
                                                                 
                                                                 UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                                                 alertView.tag = 002;
                                                                 [alertView show];
                                                             });
                                                         }
                                                         
                                                         

                                                     } else {
                                                         NSHTTPURLResponse *catagoryResponse = (NSHTTPURLResponse *) response;
                                                         NSLog(@"%@", catagoryResponse);
                                                         
                                                         NSArray *catagoryArr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                         NSLog(@"%@",catagoryArr);
                                                         
                                                         NSArray *dammycatagoryArray=[catagoryArr valueForKey:@"categories"];
                                                         NSLog(@"%@",dammycatagoryArray);
                                                        
                                                
                                                         int catIndex;
                                                         for (catIndex = 0; catIndex < dammycatagoryArray.count; catIndex++) {
                                                             NSDictionary *dict = dammycatagoryArray[catIndex];
                                                            catModel = [[CategoryModel alloc]init];
                                                             NSLog(@"%@",dict);
                                                             [catModel setModelWithDict:dict];
                                                             NSLog(@"%@",catModel);
                                                             [_mainArray addObject:catModel];
                                                             NSLog(@"%@",_mainArray);
//                                                            
                                                             
                                                         }
                                                         dispatch_async(dispatch_get_main_queue(), ^(void){
                                                             //Run UI Updates
                                                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                             [_catogorysTableView reloadData];
                                                             _collectionView.dataSource = self;
                                                             _collectionView.delegate = self;
                                                             [_collectionView reloadData];

                                                         });

                                                     
                                                     }
                                                 }];
    [dataTask resume];
 
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView==_collectionView) {
        return 1;
    }else{
        return 1;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView==_collectionView) {
        NSLog(@"%lu",(unsigned long)_mainArray.count);
         return _mainArray.count;
        
    }else{
        return pageArrayData.count;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==_collectionView) {
        
    
        ItemsCollectionViewCell *cell=[_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
       
        catModel = [_mainArray objectAtIndex:indexPath.item];
        cell.itemLabel.text = catModel.category_name;
        [cell.itemImage setImageWithURL:[NSURL URLWithString:catModel.image] placeholderImage:nil];
        
        return cell;
    }else{
        pageSlideCollectionViewCell *pageSlideCell = [_pageCollectionView dequeueReusableCellWithReuseIdentifier:@"pageSlideCollectionViewCell" forIndexPath:indexPath];
        imageCatagory *model = [pageArrayData objectAtIndex:indexPath.row];
        [pageSlideCell.pageSlideImage setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
        
        return pageSlideCell;
    }


}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==_collectionView) {
        NSLog(@"%@",indexPath);
        catModel = [_mainArray objectAtIndex:indexPath.item];
        NSLog(@"%@",catModel);
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ItemsDisplayViewController *items = [story instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
        self.title = catModel.category_name;
        items.loginDetailsArray = self.loginDetailsArray;
        items.loginModel = self.loginModel;
        [items getId:catModel.category_id];
        [items getName:catModel.category_name];
        NSLog(@"%@",catModel.category_name);
        [items getPopUpName:catModel.category_name];
        NSLog(@"%@",catModel);
        items.CatModel = catModel;
        NSLog(@"%@",items.CatModel);
       //items.CatModel = catModel.product[indexPath.row];
        NSLog(@"%@",items.CatModel);
        [NSUserDefaults.standardUserDefaults setValue:@"yes" forKey:@"Direct"];
         [self.navigationController pushViewController:items animated:YES];
    }else{
        
    }
   

}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
       return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)_mainArray.count);
          return _mainArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
        CatogorysTableViewCell *tableViewCell=[tableView dequeueReusableCellWithIdentifier:@"CatogorysTableViewCell"];
        _catogorysTblHeight.constant =  _catogorysTableView.contentSize.height;
       catModel = _mainArray[indexPath.row];
    tableViewCell.catModel = catModel;
    tableViewCell.categoryNameLabel.text = catModel.category_name;
  
    [tableViewCell.categoryButton addTarget:self action:@selector(clickOnAdd:) forControlEvents:UIControlEventTouchUpInside];
    tableViewCell.categoryButton.tag = indexPath.row;
    NSLog(@"%ld",(long)tableViewCell.categoryButton.tag);
        return tableViewCell;
    
}

-(void)clickOnAdd:(UIButton *)sender{
    ItemsDisplayViewController *itemVc = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemsDisplayViewController"];
    [self.navigationController pushViewController:itemVc animated:YES];
    CategoryModel *model1 = [_mainArray objectAtIndex:sender.tag];
    NSLog(@"%@",model1);
    NSLog(@"%@",model1.category_id);
    [itemVc getId:model1.category_id];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_searchBar resignFirstResponder];
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"Home"];
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"LoggedIn"]isEqualToString:@"yes"])
 {
     
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
 }else{
     NSLog(@"NotLoggedin");
 }
}

-(IBAction)receiveTestNotification:(NSNotification *)notification{
    _Catmodel = notification.object;
    NSLog(@"%@",_Catmodel);
    product_id = _Catmodel.pid;
    NSLog(@"%@",product_id);
   
    dispatch_async(dispatch_get_main_queue(), ^(void){
 
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strloadingText = [NSString stringWithFormat:@"Loading Data."];
    hud.label.text = strloadingText;
    });
    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/fetch_indevisuallist_sliderImage.php"];
    NSURL *url=[NSURL URLWithString:urlInstring];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *params = [NSString stringWithFormat:@"product_id=%@",product_id];
    NSLog(@"%@",params);
    
    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",requestData);
    [request setHTTPBody:requestData];
    
    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
    [config setTimeoutIntervalForRequest:30.0];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        NSError *err;
        if (error) {
            NSLog(@"%@",err);

            if ([error.localizedDescription isEqualToString:@"The request timed out."]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
                    alertView.tag = 001;
                    [alertView show];
                });
            }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
                dispatch_async(dispatch_get_main_queue(),^{
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    alertView.tag = 002;
                    [alertView show];
                });
            }
            
        }else{
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"%@",response);
            NSLog(@"%@",jsonData);
            NSArray *dammyArray = [jsonData objectForKey:@"categories"];
            int index;
            sliderImagesData = [[NSMutableArray alloc]init];
            for (index=0; index<dammyArray.count; index++) {
                NSDictionary *dict = dammyArray[index];
            subModel = [[SliderModel alloc]init];
                [subModel getSliderModelWithDict:dict];
                [sliderImagesData addObject:subModel];
                NSLog(@"%@",sliderImagesData);
            
        }
            dispatch_async(dispatch_get_main_queue(), ^(void){
       SubSubViewController *subVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SubSubViewController"];
                [self.navigationController pushViewController:subVc animated:YES];
                subVc.subsubCatId = subModel.pid;
                subVc.mainColorCode = subModel.color_code;
                subVc.ItemNameData = subModel.Name;
                subVc.sliderModel = subModel;
            });
    }
    }];
    [task resume];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
//-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"%lu",(unsigned long)tabBarController.selectedIndex);
//    if (tabBarController.selectedIndex==0) {
//        
////            [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
//        }else{
//            
//        }
//   
//}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 001) {
        [self refreshMethod];
    }else if (buttonIndex == 002){
        [self refreshMethod];
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController *searchBarVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
  [self.navigationController pushViewController:searchBarVc animated:YES];
    return NO;
}

//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    SearchViewController *searchBarVc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
//    [self.navigationController pushViewController:searchBarVc animated:YES];
//    
//}
\

@end
