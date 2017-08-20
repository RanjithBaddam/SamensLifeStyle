//
//  AppDelegate.m
//  samens
//
//  Created by All time Support on 30/05/17.
//  Copyright © 2017 All time Support. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Google/SignIn.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <MBProgressHUD.h>
#import "homeViewController.h"
@import Firebase;
@import FirebaseInstanceID;
#import "ViewController.h"



#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end
#endif

#ifndef NSFoundationVersionNumber_iOS_9_x_Max
#define NSFoundationVersionNumber_iOS_9_x_Max 1299
#endif


@interface AppDelegate ()<UNUserNotificationCenterDelegate>{
    NSURL *imageURL;
    NSString *imgUrlString;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    [NSThread sleepForTimeInterval:1.0];
   
        NSError* configureError;
        [[GGLContext sharedInstance] configureWithError: &configureError];
        NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
        
       // [GIDSignIn sharedInstance].delegate = self;

        [[FBSDKApplicationDelegate sharedInstance] application:application
                                 didFinishLaunchingWithOptions:launchOptions];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"GoogleService-InfoFirebase" ofType:@"plist"];
    FIROptions *options = [[FIROptions alloc] initWithContentsOfFile:filePath];
    [FIRApp configureWithOptions:options];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
#endif
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        // iOS 7.1 or earlier. Disable the deprecation warnings.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType allNotificationTypes =
        (UIRemoteNotificationTypeSound |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeBadge);
        [application registerForRemoteNotificationTypes:allNotificationTypes];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
#pragma clang diagnostic pop
    } else {
        // iOS 8 or later
        // [START register_for_notifications]
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
            UIUserNotificationType allNotificationTypes =
            (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
            UIUserNotificationSettings *settings =
            [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            [application registerForRemoteNotifications];
            
        } else {
            // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
            UNAuthorizationOptions authOptions =
            UNAuthorizationOptionAlert
            | UNAuthorizationOptionSound
            | UNAuthorizationOptionBadge;
            [[UNUserNotificationCenter currentNotificationCenter]
             requestAuthorizationWithOptions:authOptions
             completionHandler:^(BOOL granted, NSError * _Nullable error) {
             }
             ];
            // For iOS 10 display notification (sent via APNS)
            [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
            // For iOS 10 data message (sent via FCM)
            [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
        }
    }

    return YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"login"]isEqualToString:@"google"]) {
        
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation];
    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"login"]isEqualToString:@"facebook"]){
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
    }else{
        return YES;
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
//    if ([[NSUserDefaults.standardUserDefaults valueForKey:@"login"]isEqualToString:@"google"]) {
//        return [[GIDSignIn sharedInstance] handleURL:url
//                                   sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                          annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//    }else if ([[NSUserDefaults.standardUserDefaults valueForKey:@"login"]isEqualToString:@"facebook"]){
    return [[FBSDKApplicationDelegate sharedInstance] application:app
                                                         openURL:url
                                                sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                       annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//        
//
//
//    
//        
//        
//    }else{
//        return YES;
//    }
}

//- (void)signIn:(GIDSignIn *)signIn
//didSignInForUser:(GIDGoogleUser *)user
//     withError:(NSError *)error {
//   //  Perform any operations on signed in user here.
//    NSString *userId = user.userID;                  // For client-side use only!
//    NSString *idToken = user.authentication.idToken; // Safe to send to the server
//    NSString *fullName = user.profile.name;
//        NSString *email = user.profile.email;
//     [GIDSignIn sharedInstance].shouldFetchBasicProfile = YES;
//    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
//    {
//        NSUInteger dimension = round(50 * [[UIScreen mainScreen] scale]);
//        imageURL = [user.profile imageURLWithDimension:dimension];
//        NSLog(@"%@",imageURL);
//        imgUrlString = [NSString stringWithFormat:@"%@",imageURL];
//        NSLog(@"%@",imgUrlString);
//    }
//    NSLog(@"%@",[FIRInstanceID instanceID].token);
//
//    
//    NSLog(@"%@%@%@%@",userId,idToken,fullName,email);
//   
//    
//    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/registration_ios_social-media.php"];
//    NSURL *url=[NSURL URLWithString:urlInstring];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    NSString *params = [NSString stringWithFormat:@"userid=%@&name=%@&type=%@&image=%@&email=%@&regId=%@",userId,fullName,@"G",imgUrlString,email,[FIRInstanceID instanceID].token];
//    NSLog(@"%@",params);
//    
//    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",requestData);
//    [request setHTTPBody:requestData];
//    
//    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
//    [config setTimeoutIntervalForRequest:30.0];
//    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
//    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//      
//        NSError *err;
//        
//        if (error) {
//            NSLog(@"%@",err);
//            
//            if ([error.localizedDescription isEqualToString:@"The request timed out."]){
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
//                    alertView.tag = 001;
//                    [alertView show];
//                });
//            }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
//                dispatch_async(dispatch_get_main_queue(),^{
//                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
//                    alertView.tag = 002;
//                    [alertView show];
//                });
//            }
//            
//        }else{
//            
//            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//            NSLog(@"%@",response);
//            NSLog(@"%@",jsonData);
//            if([[NSNumber numberWithBool:[[[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] objectForKey:@"success"] boolValue]] isEqualToNumber:[NSNumber numberWithInt:1]]){
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/registration_detail_social-media.php"];
//                    NSURL *url=[NSURL URLWithString:urlInstring];
//                    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//                    [request setHTTPMethod:@"POST"];
//                    NSString *params = [NSString stringWithFormat:@"userid=%@&type=%@",userId,@"G"];
//                    NSLog(@"%@",params);
//                    
//                    NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
//                    NSLog(@"%@",requestData);
//                    [request setHTTPBody:requestData];
//                    
//                    NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
//                    [config setTimeoutIntervalForRequest:30.0];
//                    NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
//                    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                        
//                        NSError *err;
//                        
//                        if (error) {
//                            NSLog(@"%@",err);
//                            
//                            if ([error.localizedDescription isEqualToString:@"The request timed out."]){
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
//                                    alertView.tag = 001;
//                                    [alertView show];
//                                });
//                            }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
//                                dispatch_async(dispatch_get_main_queue(),^{
//                                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
//                                    alertView.tag = 002;
//                                    [alertView show];
//                                });
//                            }
//                            
//                        }else{
//                            
//                            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                            NSLog(@"%@",response);
//                            NSLog(@"%@",jsonData);
//                            NSArray *dammyArray = [jsonData objectForKey:@"categories"];
//                            
//                            for (NSDictionary *eachUser in dammyArray){
//                                [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"api"] forKey:@"api"];
//                                NSLog(@"%@",eachUser);
//                                [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"custid"] forKey:@"custid"];
//                                [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"dor"] forKey:@"dor"];
//                                [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"email"] forKey:@"email"];
//                                [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"mobile"] forKey:@"mobile"];
//                                [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"name"] forKey:@"name"];
//                                NSLog(@"%@",eachUser);
//                                  [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:@"LoggedIn"];
//                            
//                                
//                            }
//                          
//
//                        }
//                    }];
//                    [task resume];
//                    
//                });
//            }else{
//                  dispatch_async(dispatch_get_main_queue(), ^{
//                      NSString *urlInstring =[NSString stringWithFormat:@"http://samenslifestyle.com/samenslifestyle123.com/samens_mob/registration_detail_social-media.php"];
//                      NSURL *url=[NSURL URLWithString:urlInstring];
//                      NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//                      [request setHTTPMethod:@"POST"];
//                      NSString *params = [NSString stringWithFormat:@"userid=%@&type=%@",userId,@"G"];
//                      NSLog(@"%@",params);
//                      
//                      NSData *requestData = [params dataUsingEncoding:NSUTF8StringEncoding];
//                      NSLog(@"%@",requestData);
//                      [request setHTTPBody:requestData];
//                      
//                      NSURLSessionConfiguration *config=[NSURLSessionConfiguration defaultSessionConfiguration];
//                      [config setTimeoutIntervalForRequest:30.0];
//                      NSURLSession *session=[NSURLSession sessionWithConfiguration:config];
//                      NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                          
//                          NSError *err;
//                          
//                          if (error) {
//                              NSLog(@"%@",err);
//                              
//                              if ([error.localizedDescription isEqualToString:@"The request timed out."]){
//                                  dispatch_async(dispatch_get_main_queue(), ^{
//                                      UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The requste timed out. Please try again" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
//                                      alertView.tag = 001;
//                                      [alertView show];
//                                  });
//                              }else if ([error.localizedDescription isEqualToString:@"The Internet connection appears to be offline."]){
//                                  dispatch_async(dispatch_get_main_queue(),^{
//                                      UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"The Internet connection appears to be offline." message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Retry", nil];
//                                      alertView.tag = 002;
//                                      [alertView show];
//                                  });
//                              }
//                              
//                          }else{
//                              
//                              id jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                              NSLog(@"%@",response);
//                              NSLog(@"%@",jsonData);
//                              NSArray *dammyArray = [jsonData objectForKey:@"categories"];
//                              
//                              for (NSDictionary *eachUser in dammyArray){
//                                  [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"api"] forKey:@"api"];
//                                  NSLog(@"%@",eachUser);
//                                  [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"custid"] forKey:@"custid"];
//                                  [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"dor"] forKey:@"dor"];
//                                  [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"email"] forKey:@"email"];
//                                  [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"mobile"] forKey:@"mobile"];
//                                  [NSUserDefaults.standardUserDefaults setValue:[eachUser valueForKey:@"name"] forKey:@"name"];
//                                  NSLog(@"%@",eachUser);
//                                   [[NSUserDefaults standardUserDefaults] setValue:@"yes" forKey:@"LoggedIn"];
//                                  
//                              }
//
//                             
//                          }
//                      }];
//                      [task resume];
//                      
//                
//                  });
//            }
//        }
//    }];
//    [task resume];
//}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(nonnull NSDictionary *)userInfo completionHandler:(nonnull void (^)())completionHandler{
    if ([identifier isEqualToString:@"declineAction"]) {
        
    }else if ([identifier isEqualToString:@"answerAction"]){
        
    }
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    NSString *deviceTokenStr = [[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]
                                stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Device_Token  ------> %@\n",deviceTokenStr);
    [[FIRInstanceID instanceID]setAPNSToken:deviceToken type:FIRInstanceIDAPNSTokenTypeProd];
   
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo{
    NSLog(@"Notification received: %@",userInfo);
    if (application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground ) {
        
        //opened from a push notification when the app was on background
    }
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    NSLog(@"Notification received: %@", userInfo);
    if ([userInfo valueForKey:@"syncdata"]){
        if ([[userInfo valueForKey:@"syncdata"] isEqualToString:@"true"]){
            NSLog(@"have to sync");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SyncTrips" object:userInfo];
        }else{
            NSLog(@"No need of syn");
        }
    }
    if( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO( @"10.0" ) )
    {
        return;
    }
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
    {
        handler( UIBackgroundFetchResultNewData );
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
    {
        handler( UIBackgroundFetchResultNewData );
    }
    else
    {
        handler( UIBackgroundFetchResultNewData );
    }
}
//#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"Message received : %@",notification.request.content.userInfo);
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    if ([[userInfo valueForKey:@"isSync"] isEqualToString:@"true"]){
        NSLog(@"HAVE TO SYNC");
    }else{
        NSLog(@"NO NEED TO SYNC");
    }
    NSLog(@"%@", userInfo);
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
    {
        completionHandler( UNNotificationPresentationOptionAlert );
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
    {
        completionHandler( UNNotificationPresentationOptionAlert );
    }
    else
    {
        completionHandler( UNNotificationPresentationOptionAlert );
    }
}
//
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    
    //    completionHandler(UNNotificationPresentationOptionAlert);
}
//#endif
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0);
{
    NSLog(@"%@",error.localizedDescription);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];


}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
