//
//  TermsAndConditionsViewController.m
//  samens
//
//  Created by All time Support on 13/07/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "TermsAndConditionsViewController.h"

@interface TermsAndConditionsViewController (){
    IBOutlet UITextView *textView;
    
}

@end

@implementation TermsAndConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    textView.text = @"TERMS & CONDITIONS\n\nSamens Lifestyle, a company incorporated in India is in the business of wholesaling and retailing various categories of goods across India through various modes of distribution channel (“Products” and/or “Services”). All transactions or the products order by you on the website www.samenslifestyle.com (“Website”), shall be fulfilled.\n\nTERMS & CONDITIONS FOR SALE\n\n 1. These Terms sets forth the terms and conditions that apply to the sale and purchase of the products between Samens Lifestyle and you. Change in law or changes in Samens Lifestyle business may require changes to be made to the Terms from time to time (“Revised Terms”). It is your responsibility to carefully read, agree with and accept the terms or any other terms and condition.\n\n2. You agree that Samens Lifestyle makes no warranty as to the accuracy, comprehensiveness, or correctness of any Product(s) on the Website www.samenslifestyle.com (Website) and provides all Product(s) on an as is basis.\n\n3. The products/services and information displayed on the Website is an invitation to offer to public at large. Your order for purchase constitutes your offer which shall be subject to acceptance or rejection by Samens Lifestyle and shall further subject to the terms and conditions as listed below. All accepted offers shall be fulfilled by Samens Lifestyle. If you have supplied your valid email address or contact number, Samens Lifestyle will notify you by email or through SMS (as the case may be) as soon as possible to confirm receipt of your order and email you again to confirm details and therefore process the order. Acceptance of your order will take place upon dispatch of the Product(s) ordered. No act or omission of Samens Lifestyle prior to the actual dispatch of the Product(s) ordered will constitute acceptance of your offer.\n\n4. Persons who are incompetent to contract under the Indian Contract Act, 1872 including minors, un-discharged insolvents etc. or otherwise barred by law are not eligible to place the order for the product or use or transact on the Website. Persons under the age of 18 years cannot transact through or use the Website. Website is freely accessible to the all the end user however subject to the terms of use and privacy policy or any other terms and conditions.";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
