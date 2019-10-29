//
//  DriverListVC.m
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DriverListVC.h"
#import "DriverProfileVC.h"
@interface DriverListVC ()
{
    NSIndexPath *indexpathAtOpenedRow;
    NSInteger selectedSection;
    CellDriverHeader *headerview;
}
@end

@implementation DriverListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    NavigationBarHidden(YES);
    CGRect rect =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    self.tblDrivers = [[TQMultistageTableView alloc] initWithFrame:rect];
    self.tblDrivers.dataSource = self;
    self.tblDrivers.delegate   = self;
    self.tblDrivers.redirectFrom=@"ALL_DRIVERS";
     self.tblDrivers.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tblDrivers];
    self.tblDrivers.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    if([_strRedirectFrom isEqualToString:@"HOME"])
    {
        [self.btnSettings setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    }
    else
    {
        [self.btnSettings setImage:imgNamed(@"") forState:UIControlStateNormal];
        
    }
   
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view delegate
- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)mTableView
{
    return 5;
}
- (NSInteger)mTableView:(TQMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section
{
    if(section > 0)
    {
        return 70;
    }
    else
    {
        return 210;
    }
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
- (CGFloat)mTableView:(TQMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
- (UITableViewHeaderFooterView *)mTableView:(TQMultistageTableView *)mTableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *nibhead= [[NSBundle mainBundle] loadNibNamed:@"CellDriverHeader" owner:self options:nil];
    CellDriverHeader *header = (CellDriverHeader *)[nibhead objectAtIndex:0];
    if(section > 0)
    {
        header.vwheaderhight.constant=0;
    }
    else
    {
        header.vwheaderhight.constant=140;
    }
    header.lblDistance.text=@"300 mi";
    header.lblDrivername.text=@"JOE";
    header.lblDriverstatusvalue.text=@"OH-IL";
    header.lblLocationName.text=@"OH";
    header.cellDriverHeaderDelegate=self;
    return header;
}
- (UITableViewCell *)mTableView:(TQMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)mTableView:(TQMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Header Open Or Close
- (void)mTableView:(TQMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section
{
    selectedSection=section;
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section
{
}

#pragma mark - Row Open Or Close

- (void)mTableView:(TQMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexpathAtOpenedRow=indexPath;
}

- (void)mTableView:(TQMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)mscrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}
#pragma mark - cell driver header delegate
- (IBAction)btnExpandCollapseClicked:(id)sender
{
    
}
- (IBAction)btnSwitchToMapClicked:(id)sender
{
    
}
- (IBAction)btnSwitchToListClicked:(id)sender
{
    
}
- (IBAction)btnMyProfileClicked:(id)sender
{
    DriverProfileVC *objdrivers=initVCToRedirect(SBAFTERSIGNUP, DRIVERPROFILEVC);
    [self.navigationController pushViewController:objdrivers animated:YES];
}
- (IBAction)btnSortByLocationClicked:(id)sender
{
    
}
- (IBAction)btnSortByStatusClicked:(id)sender
{
    
}
#pragma mark - click events
- (IBAction)btnSettingClicked:(id)sender 
{
    if([_strRedirectFrom isEqualToString:@"HOME"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
    }
}

- (IBAction)btnDrawerClicked:(id)sender 
{
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
