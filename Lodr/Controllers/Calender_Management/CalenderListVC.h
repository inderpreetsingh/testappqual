//
//  CalenderListVC.h
//  Lodr
//
//  Created by c196 on 29/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

#import "CellCalenderHeader.h"
#import "CellCalenderEvent.h"
#import "CellAllTimes.h"
#import "CellHorizontalScroll.h"
#import "CellCalenderSchedule.h"

@interface CalenderListVC : BaseVC <JTCalendarDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, CellCalenderHeaderDelegate, HorizontalScrollCellDelegate, CellCalenderScheduleDeleagate, CellCalenderEventDelegate>

@property (strong, nonatomic) UICollectionView *collEventTimeHeader;
@property (strong, nonatomic) UICollectionView *collEventTimeHeader2;
@property (strong, nonatomic) UICollectionView *collEventTimeHeader3;
@property (strong, nonatomic) UICollectionView *collEventTimeHeader4;
@property (strong, nonatomic) UICollectionView *collEventTimeHeader5;

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightsuportdispatchloadmore;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calenerMenuView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIView *vwNavbar;
@property (weak, nonatomic) IBOutlet UIView *vwMain;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollMain;

@property (strong, nonatomic) IBOutlet UITableView *tblListOfResources;
@property (strong, nonatomic) IBOutlet UITableView *tblListOfResources2;
@property (strong, nonatomic) IBOutlet UITableView *tblLinkedList;
@property (strong, nonatomic) IBOutlet UITableView *tblLinkedList2;

@property (weak, nonatomic) IBOutlet UITableView *tblLoadCalender;

- (IBAction)btnrefreshclicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *vwListOfLInkeddata;
@property (weak, nonatomic) IBOutlet UIView *vwListOfLinkeddata2;
@property (weak, nonatomic) IBOutlet UIView *vwCalander1;
@property (weak, nonatomic) IBOutlet UIView *vwCalander2;
@property (weak, nonatomic) IBOutlet UIView *vwLoadCalender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwCalender0;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwCalender1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwCalende2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwList1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightVwList2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTbl1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hrightTbl2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTbl4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTbl3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTbl0;
@property (weak, nonatomic) IBOutlet UIButton *btnRefresh;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighvwloadmore3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighvwloadmore4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighvwloadmore1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighvwloadmore2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heighvwloadmore0;

@property (weak, nonatomic) IBOutlet UIButton *btnClickToAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnClickToAdd2;

@property (weak, nonatomic) IBOutlet UIButton *btnHeading0;
@property (weak, nonatomic) IBOutlet UIButton *btnHeading1;
@property (weak, nonatomic) IBOutlet UIButton *btnHeading2;
@property (weak, nonatomic) IBOutlet UIButton *btnHeading3;
@property (weak, nonatomic) IBOutlet UIButton *btnHeading4;
@property (weak, nonatomic) IBOutlet UIButton *btnlaodmore1;
@property (weak, nonatomic) IBOutlet UIButton *btnlaodmore2;
@property (weak, nonatomic) IBOutlet UIButton *btnlaodmore3;
@property (weak, nonatomic) IBOutlet UIButton *btnlaodmore4;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;

@property (weak, nonatomic) IBOutlet UIView *vwloadmore1;
@property (weak, nonatomic) IBOutlet UIView *vwloadmore2;
@property (weak, nonatomic) IBOutlet UIView *vwloadmore3;
@property (weak, nonatomic) IBOutlet UIView *vwloadmore4;
@property (weak, nonatomic) IBOutlet UIView *vwloadcalenderlbl;
@property (weak, nonatomic) IBOutlet UIView *vwloadmoreLoads;
@property (weak, nonatomic) IBOutlet UIView *vwNodatafound0;
@property (weak, nonatomic) IBOutlet UIView *vwNodataFound1;
@property (weak, nonatomic) IBOutlet UIView *vwNodataFound2;
@property (weak, nonatomic) IBOutlet UIView *vwNoDatafound3;
@property (weak, nonatomic) IBOutlet UIView *vwNodataFound4;
@property (weak, nonatomic) NSString *redirectfrom;
@property (strong, nonatomic) IBOutlet UIView *vwnoPowerAsset;
@property (strong, nonatomic) IBOutlet UITableView *tblPowerAsset;
@property (strong, nonatomic) IBOutlet UIButton *btnPowerAsset;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightPowerAsset;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightTblPower;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightPowerLoadmore;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightPowerDispatchLoadmore;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightPowerDispatch;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightTblPowerDispatch;
@property (strong, nonatomic) IBOutlet UIView *vwPowerLoadMore;
@property (strong, nonatomic) IBOutlet UIButton *btnPowerDispatch;
@property (strong, nonatomic) IBOutlet UIView *vwnoPowerDispatch;
@property (strong, nonatomic) IBOutlet UIButton *btnSupport;
@property (strong, nonatomic) IBOutlet UIButton *btnSupportDispatch;
@property (strong, nonatomic) IBOutlet UITableView *tblPowerDispatch;
@property (strong, nonatomic) IBOutlet UITableView *tblSupport;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightTblSupport;
@property (strong, nonatomic) IBOutlet UIView *vwNoSupport;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightSupportLoadmore;
@property (strong, nonatomic) IBOutlet UIView *vwPowerDispatch;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightSupportAsset;
@property (strong, nonatomic) IBOutlet UIView *vwPowerDispatchLoadmore;
@property (strong, nonatomic) IBOutlet UIView *vwsupportdispatch;
@property (strong, nonatomic) IBOutlet UIView *vwsupportdispatchloadmore;
@property (strong, nonatomic) IBOutlet UIView *vwNoSupportdispatch;
@property (strong, nonatomic) IBOutlet UITableView *tblSupportDispatch;

@property (strong, nonatomic) IBOutlet UIView *vwpowerAsset;
- (IBAction)btnBackClciked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *vwsupportloadmore;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightNoSupportDispatch;
- (IBAction)btnDrawerClciked:(id)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightTblSupportDispatch;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightNoSupportdispatch;
@property (strong, nonatomic) IBOutlet UIView *vwSupport;
- (IBAction)btnExpandCollClicked:(id)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightScroll;
- (IBAction)goRightClicked:(id)sender;
- (IBAction)goLeftClicked:(id)sender;
- (IBAction)btnLoadMoreClciked:(id)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightSupportdispatch;
- (IBAction)btnClicktoAddClicked:(id)sender;
@end
