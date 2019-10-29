//
//  DriverHomeVC.m
//  Lodr
//
//  Created by c196 on 05/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "DriverHomeVC.h"
#import "DriverLoadListVC.h"
#import "DriverReportsStatusVC.h"
#import "Drivers.h"
@interface DriverHomeVC ()
{
    NSArray *arrHomeOptions;
    NSTimer *timer;
    NSDateFormatter *dateformatter,*dateFormatterForDate;
    CellHomeScreenHeader *viewHeader;
}
@end

@implementation DriverHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarHidden(YES);
    dateformatter=[[NSDateFormatter alloc]init];
    dateFormatterForDate=[[NSDateFormatter alloc]init];
    [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [dateformatter setDateFormat:@"hh:mm"];
    [dateFormatterForDate setDateFormat:@"EEEE, MMM dd"];
    arrHomeOptions=[[NSArray alloc]initWithObjects:@"MY LOADS", nil];
    [self.btnDrawer setImage:imgNamed(iconDrawer2) forState:UIControlStateNormal];
    [self layoutHeaderAndFooter];
    if([_strRedirectFrom isEqualToString:@"HOME"])
    {
        [self.btnSettings setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    }
    else
    {
        [self.btnSettings setImage:imgNamed(iconSettings) forState:UIControlStateNormal];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(timer.isValid)
    {
        [timer invalidate];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)layoutHeaderAndFooter
{
    viewHeader=[[CellHomeScreenHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblDriverHome.frame.size.width, 80)];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellHomeScreenHeader" owner:self options:nil];
    
    viewHeader = (CellHomeScreenHeader *)[nib objectAtIndex:0];
    NSString *timeInStringFormated=[dateformatter stringFromDate:[NSDate date]];
    NSString *dateInStringFormated=[dateFormatterForDate stringFromDate:[NSDate date]];
    viewHeader.lblTime.text=timeInStringFormated;
    viewHeader.lblDate.text=[dateInStringFormated uppercaseString];
}
-(void)updateTimer
{
    NSString *timeInStringFormated=[dateformatter stringFromDate:[NSDate date]];
    viewHeader.lblTime.text=timeInStringFormated;
    NSString *dateInStringFormated=[dateFormatterForDate stringFromDate:[NSDate date]];
    viewHeader.lblDate.text=[dateInStringFormated uppercaseString];
}
#pragma mark - tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    return 2; 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    if(section==0)
    {
        return 0;
    }
    else
    {
    return arrHomeOptions.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    static NSString *cellIdentifier = @"CellHomeScreenOptions";
    CellHomeScreenOptions *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) 
    { 
        cell = [[CellHomeScreenOptions alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
    }
    cell.btnHomeScreenOption.tag=indexPath.row;
    cell.cellHomeScreenOptionsDelegate=self;

    [cell.btnHomeScreenOption setTitle:[arrHomeOptions objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    return cell; 
}
- (void)btnHomeScreenOptionClicked:(id)sender 
{
    
    switch ([sender tag]) {
        case 0:
        {
            DriverLoadListVC *obLoadList=initVCToRedirect(SBAFTERSIGNUP, DRIVERLOADLISTVC);
            [self.navigationController pushViewController:obLoadList animated:YES];
        }
            break;
        case 1:
        {
          
        }
            break;
        case 2:
        {
            DriverReportsStatusVC *objstatus=initVCToRedirect(SBAFTERSIGNUP, DRIVERREPORTSTATUSVC);
            [self.navigationController pushViewController:objstatus animated:YES];
        }
            break;
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section>0)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellHomeSwitchOnOff" owner:self options:nil];
        CellHomeSwitchOnOff *tblfootervw = (CellHomeSwitchOnOff *)[nib objectAtIndex:0];
        if([DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDriverData]!=nil)
        {
            Drivers *objd=[DefaultsValues getCustomObjFromUserDefaults_ForKey:SavedDriverData];
            if([objd.dutyStatus isEqualToString:@"0"])
            {
                if(SCREEN_WIDTH > 320 && SCREEN_WIDTH <= 375)
                {
                    tblfootervw.leadingBtnDuty.constant = 184;
                }
                else if(SCREEN_WIDTH > 375)
                {
                    tblfootervw.leadingBtnDuty.constant = 201;
                }
                else
                {
                    tblfootervw.leadingBtnDuty.constant = CGRectGetWidth(tblfootervw.frame) - CGRectGetWidth(tblfootervw.btnOnDuty.frame) - 3;
                }
                
                [tblfootervw.btnOnDuty setBackgroundColor:[UIColor blackColor]];
                [tblfootervw.btnOnDuty setTitle:@"OFF DUTY" forState:UIControlStateNormal];
                [tblfootervw layoutIfNeeded];
            }
            else
            {
                tblfootervw.leadingBtnDuty.constant = 3;
                [tblfootervw.btnOnDuty setBackgroundColor:[UIColor colorWithRed:0/255.0 green:168/255.0 blue:1/255.0 alpha:1]];
                [tblfootervw.btnOnDuty setTitle:@"ON DUTY" forState:UIControlStateNormal];
                [tblfootervw layoutIfNeeded];
            }
        }
        return tblfootervw;
    }
    else
    {
        viewHeader.btnNext.hidden=YES;
        viewHeader.btnPrev.hidden=YES;
        return viewHeader;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    if(section>0)
    {
        return 100;
    }
    else
    {
        return 80;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(SCREEN_WIDTH > 320)
    {
        return 65;
    }
    else
    {
        return 55;
    }
}

- (IBAction)btnSettingsClicked:(id)sender {
    if([_strRedirectFrom isEqualToString:@"HOME"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
    }
}

- (IBAction)btnDraawerClicked:(id)sender {
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
