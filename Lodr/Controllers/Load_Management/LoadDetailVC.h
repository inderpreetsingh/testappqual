//
//  LoadDetailVC.h
//  Lodr
//
//  Created by Payal Umraliya on 21/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
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
    
    NotAssigned = 0, //Match is there
    Interested,
    Linked,
    Dispatched
    
}LoadStatus;

typedef enum{
    
   LoadDetailsTopSection=0,
   LoadDetailsNotesSection,
   LoadDetailsCommentSection
    
    
}loadDetailsSection;


typedef enum{
    
    CellLoadsDetailTop  = 0,
    CellLoadsDetailMiddle,
    CellLoadsDetailMiddleFields,
    
}loadDetailsTop;

typedef enum{
    CellLoadsWithCV = 0,
    cellLoadsNotes 
    
}loadDetailsNotes;

typedef enum{
    CellLoadsComment = 0,
    CellLoadsLoadMore,
    CellLoadsAddComment
}loadDetailsComments;

@interface LoadDetailVC : BaseVC<UITableViewDelegate,UITableViewDataSource,CellCvPickedImageDelegate,MFMailComposeViewControllerDelegate,LoadDetailFooterDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CellLoadDetailMiddleDelegate,MKMapViewDelegate,CellPdfviewDelegate,CellLoadDetailHeaderDelegate,MWPhotoBrowserDelegate>

@property(nonatomic,assign)id loadDetailVCProtocol;
@property (weak, nonatomic) IBOutlet UITableView *tblLoadDetail;
@property (strong, nonatomic) NSString *strRedirectFrom,*loadStatus,*equipname;
- (IBAction)btnDrawerClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
@property (nonatomic, strong) NSMutableArray *photos;
@property (strong, nonatomic) Loads *selectedLoad;
@property (strong, nonatomic) NSString  *matchorderid,*equipmentid,*matchId,*allothermatchesIdList,*cmpnyphno,*officephno,*myphono, *strCompanyName;

@property (assign) BOOL isFromLoad;

@property BOOL isUnlink;
@end
