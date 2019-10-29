//
//  DriverLoadDetailsVC.h
//  Lodr
//
//  Created by C225 on 19/05/18.
//  Copyright © 2018 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MapKit/MapKit.h>
#import "Loads.h"
#import "CellLoadDetailHeader.h"
#import "CellLoadDetailTop.h"
#import "CellLoadDetailMiddle.h"
#import "CellLoadDetailMiddleFields.h"
#import "CellWithCV.h"
#import "CellCvPickedImage.h"
#import "cellPdfview.h"
#import "LoadDetailFooter.h"
#import "MWPhotoBrowser.h"
#import "LoadNotes.h"
#import "LoadCommentsCell.h"
#import "AddCommentCell.h"
#import "Comments.h"
#import "LoadMoreCell.h"
#import "LoadReportStatusCell.h"

@protocol loadDetailVCProtocol <NSObject>
@optional

-(void)sendDataToLDriveroadListvc:(NSArray *)str;
-(void)callWsAgain_FetchLoad;
@end/*
     0 = not_assigned (only mach is there)
     1 = interested
     2 = linked
     3 = dispatch
     */

typedef enum{
    
    NotAssignedListDriver = 0, //Match is there
    InterestedListDriver,
    LinkedListDriver,
    DispatchedListDriver
    
}LoadStatusListDriver;

typedef enum{
    
    LoadDetailsTopSectionListDriver =0,
    LoadDetailsNotesSectionListDriver,
    LoadDetailsCommentSectionListDriver
    
    
}loadDetailsSectionListDriver;


typedef enum{
    
    CellLoadsDetailTopListDriver  = 0,
    CellLoadsDetailMiddleListDriver,
    CellLoadsDetailMiddleFieldsListDriver,
    
}loadDetailsTopListDriver;

typedef enum{
    CellLoadsWithCVListDriver = 0,
    LoadDetailsAddPhotosListDriver,
    cellLoadsNotesListDriver
    
}loadDetailsNotesListDriver;

typedef enum{
    CellLoadsCommentListDriver = 0,
    CellLoadsLoadMoreListDriver,
    CellLoadsAddCommentListDriver
}loadDetailsCommentsListDriver;

@interface DriverLoadDetailsVC : BaseVC<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,CellCvPickedImageDelegate,MFMailComposeViewControllerDelegate,LoadDetailFooterDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CellLoadDetailMiddleDelegate,MKMapViewDelegate,CellPdfviewDelegate,CellLoadDetailHeaderDelegate,MWPhotoBrowserDelegate>

@property(nonatomic,assign)id loadDetailVCProtocol;
@property (weak, nonatomic) IBOutlet UITableView *tblLoadDetail;
@property (strong, nonatomic) NSString *strRedirectFrom,*loadStatus,*equipname;
- (IBAction)btnDrawerClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
@property (nonatomic, strong) NSMutableArray *photos;
@property (strong, nonatomic) Loads *selectedLoad;
@property (strong, nonatomic) NSString  *matchorderid,*equipmentid,*matchId,*allothermatchesIdList,*cmpnyphno,*officephno,*myphono;

@property (assign) BOOL isFromLoad;

@property BOOL isUnlink;

@end
