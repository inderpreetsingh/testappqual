//
//  AppDelegate.m
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "AppDelegate.h"
#import "Firebase.h"
//#import <FirebaseAuth/FirebaseAuth.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "RegistrationVC.h"
#import "MenuVC.h"
#import "HomeVC.h"
#import "LoginVC.h"
#import "DotRegistrationVC.h"
#import "Matches.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <UserNotifications/UserNotifications.h>
@import Firebase;
@interface AppDelegate ()

@end

@implementation AppDelegate
//

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@",[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]);
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:@"_UIConstraintBasedLayoutLogUnsatisfiable"];
    [self registerForRemoteNotifications];
    #pragma mark - firebase configure
 //   [Fabric with:@[[Twitter class]]];
    [Fabric with:@[[Crashlytics class], [Twitter class]]];
    [FIRApp configure];
    AppInstance.warningseen =@"No";
    #pragma mark - G+ configure
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    
    #pragma mark - FB configure
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    //    #pragma mark - Twitter configure
    NSString *key = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"consumerKey"],
    *secret = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"consumerSecret"];
    if ([key length] && [secret length]) {
        [[Twitter sharedInstance] startWithConsumerKey:key consumerSecret:secret];
    }
    
    #pragma mark push notification setting
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//
//    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
//    [application registerUserNotificationSettings:notificationSettings];
//    [application registerForRemoteNotifications];
    
    #pragma mark - Setting Up Drawer
    if([DefaultsValues getBooleanValueFromUserDefaults_ForKey:SavedSignedIn] == YES)
    {
        User *objuser = [DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedUserData];
        if(objuser.userAccount.count > 0)
        {
            
            HomeVC *objhmvc=initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
            [self setDrawerWithCenterViewNamed:objhmvc];
        }
        else
        {
             [DefaultsValues removeObjectForKey:SavedDOTData];
            DotRegistrationVC *objwelcomevc=initVCToRedirect(SBMAIN, DOTREGISTRATIONVC);
            //objwelcomevc.redirectfrom=@"APPDELEGATE";
           [self setDrawerWithCenterViewNamed:objwelcomevc];
        }
    }
    else
    {
        LoginVC *objloginvc=initVCToRedirect(SBMAIN, LOGINVC);
        [self setDrawerWithCenterViewNamed:objloginvc];
   }
    return YES;
}
-(void)setDrawer
{
    if(AppInstance.drawerController)
    {
        AppInstance.drawerController = nil;
    }
    if(!AppInstance.drawerController)
    {
        MenuVC *objMenuVC = initVCToRedirect(SBMAIN, MENUVC);
        HomeVC *objhomeVC =  initVCToRedirect(SBMAIN, HOMEVC);
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:objhomeVC];
        AppInstance.drawerController= [[MMDrawerController alloc] initWithCenterViewController:navigationController rightDrawerViewController:objMenuVC];
        [AppInstance.drawerController setRightDrawerViewController:objMenuVC];
        if(SCREEN_WIDTH>320 && SCREEN_WIDTH < 400)
        {
            [_drawerController setMaximumRightDrawerWidth:280.0f];
        }
        else if(SCREEN_WIDTH>400)
        {
            [_drawerController setMaximumRightDrawerWidth:300.0f];
        }
        else
        {
            [_drawerController setMaximumRightDrawerWidth:250.0f];
        }

        [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [AppInstance.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [AppInstance.window setRootViewController:AppInstance.drawerController];
        /**
         swingingDoorVisualStateBlock
         slideAndScaleVisualStateBlock
         slideVisualStateBlock
         parallaxVisualStateBlockWithParallaxFactor
         **/
        [AppInstance.drawerController setDrawerVisualStateBlock:[MMDrawerVisualState swingingDoorVisualStateBlock]];
    }
}
-(void)setDrawerWithCenterViewNamed :(UIViewController *)viewnm
{
    if (self.drawerController)
    {
        self.drawerController = nil;
    }
    
    if(!AppInstance.drawerController)
    {
        
        MenuVC *objMenuVC = initVCToRedirect(SBMAIN, MENUVC);
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewnm];
        navigationController.navigationBarHidden=YES;
        AppInstance.drawerController= [[MMDrawerController alloc] initWithCenterViewController:navigationController rightDrawerViewController:objMenuVC];
        [AppInstance.drawerController setRightDrawerViewController:objMenuVC];
        [AppInstance.drawerController setShowsShadow:NO];
        if(SCREEN_WIDTH>320 && SCREEN_WIDTH < 400)
        {
            [_drawerController setMaximumRightDrawerWidth:310.0f];
        }
        else if(SCREEN_WIDTH>400)
        {
            [_drawerController setMaximumRightDrawerWidth:350.0f];
        }
        else
        {
            [_drawerController setMaximumRightDrawerWidth:260.0f];
        }
        UIView *blurview=[[UIView alloc]initWithFrame:self.window.screen.bounds];
        blurview.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];//pu
        [AppInstance.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];//pu
        [AppInstance.window setRootViewController:AppInstance.drawerController];
      
        [AppInstance.drawerController
         setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
             
             if(percentVisible > 0 && blurview.superview == nil)
             {
                 [drawerController.centerViewController.view addSubview:blurview];
             }
             if(percentVisible == 0)
             {
                 [blurview removeFromSuperview];
             }
//             UIViewController * sideDrawerViewController;
//            if(drawerSide == MMDrawerSideRight){
//                 sideDrawerViewController = drawerController.centerViewController;
//             }
//             [sideDrawerViewController.view setAlpha:percentVisible];
         }];
    }
}
-(void)setNavigationController:(UINavigationController*)nav
{
    [self.window setRootViewController:nav];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"RESIGN");
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
     NSLog(@"BACK");
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
     application.applicationIconBadgeNumber = 0;
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
- (BOOL)application:(nonnull UIApplication *)application
            openURL:(nonnull NSURL *)url
            options:(nonnull NSDictionary<NSString *, id> *)options 
{
    if ([[GIDSignIn sharedInstance] handleURL:url
                            sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                   annotation:options[UIApplicationOpenURLOptionsAnnotationKey]]) 
    {
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                          annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }
    else if([[Twitter sharedInstance] application:application openURL:url options:options])
    {
       return [[Twitter sharedInstance] application:application openURL:url options:options];
    }
    else
    {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url                                                sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                           annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }
    
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // [END old_delegate]
    if ([[GIDSignIn sharedInstance] handleURL:url
                            sourceApplication:sourceApplication
                                   annotation:annotation])
    {
        return YES;
    }
    else
    {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
    }
}


#pragma mark -
#pragma mark - REGISTER FOR REMOTE NOTIFICATIONS


-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    [application registerForRemoteNotifications];
}

- (void)registerForRemoteNotifications {
    
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
        }];
    }
    else {
        
        // Code for old versions
        
    }
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"deviceToken: %@", deviceToken);
    _token = [NSString stringWithFormat:@"%@", deviceToken];
    
    //Format token as you need:
    
    _token = [_token stringByReplacingOccurrencesOfString:@" " withString:@""];
    _token = [_token stringByReplacingOccurrencesOfString:@">" withString:@""];
    _token = [_token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    
    if(_token.length>0)
    {
        [DefaultsValues setStringValueToUserDefaults:_token ForKey:SavedDeviceToken];
    }
    else
    {
        [DefaultsValues setStringValueToUserDefaults:@"0" ForKey:SavedDeviceToken];
    }

    
    NSLog(@"TOKEN == > %@",_token);
    
}
/*
#pragma mark - push handling

 - (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *tokenval = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    tokenval = [tokenval stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(tokenval.length>0)
    {
        [DefaultsValues setStringValueToUserDefaults:tokenval ForKey:SavedDeviceToken];
    }
    else
    {
        [DefaultsValues setStringValueToUserDefaults:@"0" ForKey:SavedDeviceToken];
    }
}*/


#pragma mark -
#pragma mark - RECEIVE REMOTE NOTIFICATIONS

//Called when a notification is delivered to a foreground app.

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
    NSMutableDictionary *dicUserInfo = notification.request.content.userInfo.mutableCopy;
    [GlobalFunction ShowAlert:@"PUSH" Message:@"PUSH"];
    
    //1 - foreground  0 == bg
    
   // [self performActionForNotification:dicUserInfo appState:@"1"];
    
}

//Called to let your app know which action was selected by the user for a given notification.

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
    NSMutableDictionary *dicUserInfo = response.notification.request.content.userInfo.mutableCopy;
    
     [GlobalFunction ShowAlert:@"PUSH" Message:@"PUSH"];
//    [self performActionForNotification:dicUserInfo appState:@"0"];
    //back
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *msgval=[[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
     [GlobalFunction ShowAlert:@"PUSH" Message:@"PUSH"];
//    NSString *loadid=[[userInfo objectForKey:@"aps"] objectForKey:@"load_id"];
//    NSString *equiid=[[userInfo objectForKey:@"aps"] objectForKey:@"equipment_id"];
//
//    NSMutableArray *arrmatches=[_dicAllMatchByLoadId valueForKey:[NSString stringWithFormat:@"%@",loadid]];
//        if(arrmatches.count >0)
//        {
//            [arrmatches enumerateObjectsUsingBlock:^(Matches *objmatch, NSUInteger idx, BOOL * _Nonnull stop) {
//                if ([objmatch.matchEquiid isEqualToString:equiid])
//                {
//                    objmatch.matchOrderStatus=@"1";
//                    [arrmatches replaceObjectAtIndex:idx withObject:objmatch];
//                }
//            }];
//            
//            [_dicAllMatchByLoadId setObject:arrmatches forKey:[NSString stringWithFormat:@"%@",loadid]];
//        }
//    [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedRefreshLoadTable object:nil];
     [AZNotification showNotificationWithTitle:msgval controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
   
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}
@end
