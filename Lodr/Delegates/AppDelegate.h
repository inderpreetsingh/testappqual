//
//  AppDelegate.h
//  Lodr
//
//  Created by Payal Umraliya on 10/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerVisualState.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) MMDrawerController *drawerController;
@property(strong,nonatomic)UINavigationController *firstnav;
-(void)setNavigationController:(UINavigationController*)nav;
-(void)setDrawer;
-(void)setDrawerWithCenterViewNamed :(UIViewController *)viewnm;

#pragma mark - Array that Manage persistancy

@property(strong,nonatomic)NSMutableArray *arrAllEquipments;
@property(strong,nonatomic)NSMutableArray *arrAllEspecialEquipments;
@property(strong,nonatomic)NSMutableArray *arrAllLoadByUserId;
@property(strong,nonatomic)NSMutableArray *arrAllScheduledLoadByUserId;
@property(strong,nonatomic)NSMutableDictionary *dicAllMatchByLoadId;
@property(strong,nonatomic)NSMutableArray *arrAllEquipmentByUserId;
@property(strong,nonatomic) NSString *countEquiByUid;
@property(strong,nonatomic) NSString *countLodByUid;
@property(strong,nonatomic)NSMutableArray *arrAllSavedLoadByUserId;
@property(strong,nonatomic)NSMutableArray *arrAllSavedEquipmentByUserId;
@property(strong,nonatomic) NSString *countSavedEquiByUid;
@property(strong,nonatomic) NSString *countSavedLodByUid;
@property(strong,nonatomic) NSString *locationUpdated;
@property(strong,nonatomic) NSString *userCurrentLat;
@property(strong,nonatomic) NSString *userCurrentLon;
@property(strong,nonatomic) NSString *warningseen;
@property(strong,nonatomic) NSTimer *locationtimer;
@property(strong,nonatomic) NSMutableArray *assetTypeArray;
@property (strong, nonatomic) NSString *token;
@end

