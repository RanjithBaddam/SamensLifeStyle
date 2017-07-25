//
//  GlobalProgrees.h
//  samens
//
//  Created by All time Support on 07/06/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface GlobalProgrees : MBProgressHUD
+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
+ (void)dismissGlobalHUD;
@end
