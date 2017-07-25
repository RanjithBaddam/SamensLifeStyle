//
//  GlobalProgrees.m
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "GlobalProgrees.h"

@implementation GlobalProgrees

+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    __block MBProgressHUD *hud;
    dispatch_async(dispatch_get_main_queue(), ^{
        hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.label.text = title;
    });
    return hud;
}
+ (void)dismissGlobalHUD {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:window animated:YES];
    });
}

@end
