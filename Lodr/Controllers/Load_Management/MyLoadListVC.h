//
//  MyLoadListVC.h
//  Lodr
//
//  Created by Payal Umraliya on 20/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "TQMultistageTableView.h"
#import "ResourceContainerView.h"
#import "CellMatchesContainer.h"
#import "MatchDetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "LoadDetailVC.h"
#import <MessageUI/MessageUI.h>
#import "LoadListDetailsVC.h"
#import "AddLoadPopupVC.h"


@interface MyLoadListVC : BaseVC<TQTableViewDataSource,TQTableViewDelegate,ResourceContainerViewDelegate,MatchDetailViewDelegate,CellMatchesContainerDelegate,MFMailComposeViewControllerDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet TQMultistageTableView *mTableView;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;
- (IBAction)btnSettingsClicked:(id)sender;
- (IBAction)btnLoadmoreclicked:(id)sender;
@property (strong, nonatomic) IBOutlet TQMultistageTableView *tblScheduledList;
- (IBAction)btnAddLoadClicked:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollContent;
@property  (strong, nonatomic) NSString *strRedirectFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadmore;
@end
