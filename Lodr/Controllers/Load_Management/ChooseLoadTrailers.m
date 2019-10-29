//
//  ChooseLoadTrailers.m
//  Lodr
//
//  Created by c196 on 28/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "ChooseLoadTrailers.h"
#import "HomeVC.h"
#import "PostLoadVC.h"
@interface ChooseLoadTrailers ()
{
    CellWelcomeFooter *tblfooter;
    CellChooseTrailers *tblHeader;
    NSArray *arroptions,*arrbtnInstrucitons;
    NSMutableArray *arrBtnHeadings;
}
@end

@implementation ChooseLoadTrailers

- (void)viewDidLoad 
{
    [super viewDidLoad];
    NavigationBarHidden(YES);
    arroptions=[NSArray arrayWithObjects:@"Any",@"I don't know",@"Choose trailer", nil];
    arrBtnHeadings=[NSMutableArray arrayWithObjects:@"What type of freight are you shipping?",@"What type of trailer do you need?",nil];
    arrbtnInstrucitons=[NSArray arrayWithObjects:@"",@"You can choose more that one",nil];
    [self registerCustomNibForAllcell];
    self.tblChooseTrailer.hidden=NO;
    self.tblChooseSubTrailer.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark - custom methods
-(void)registerCustomNibForAllcell
{
    UINib *nibcell = [UINib nibWithNibName:@"CellWithBtns" bundle:nil];
    [[self tblChooseTrailer] registerNib:nibcell forCellReuseIdentifier:@"CellWithBtns"];
    [[self tblChooseSubTrailer] registerNib:nibcell forCellReuseIdentifier:@"CellWithBtns"];
    
    UINib *nibcell2 = [UINib nibWithNibName:@"CellListWithCheckBox" bundle:nil];
    [[self tblChooseTrailer]  registerNib:nibcell2 forCellReuseIdentifier:@"CellListWithCheckBox"];
    
    self.tblChooseTrailer.rowHeight = UITableViewAutomaticDimension;
    self.tblChooseTrailer.estimatedRowHeight = 120.0; 
    
    self.tblChooseSubTrailer.rowHeight = UITableViewAutomaticDimension;
    self.tblChooseSubTrailer.estimatedRowHeight = 120.0;     
}

#pragma mark - tableview delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{ 
    return 1; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    if(tableView==_tblChooseTrailer)
    {
        return arroptions.count+arrBtnHeadings.count;
    }
    else
    {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    @try
    {
        if(tableView==_tblChooseTrailer)
        {
            if(indexPath.row==0)
            {
                static NSString *cellIdentifier = @"CellWithBtns";
                CellWithBtns *cell = (CellWithBtns*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) 
                { 
                    cell = [[CellWithBtns alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
                }
                cell.lblButtonHeading.text=[arrBtnHeadings objectAtIndex:indexPath.row];
                cell.lblFieldInstrtuctions.text=[arrbtnInstrucitons objectAtIndex:indexPath.row];
                cell.heightvwButtonValue.constant=65;
                cell.vwButtonValue.clipsToBounds=YES;
                return cell; 
            }
            else if(indexPath.row==1)
            {
                static NSString *cellIdentifier = @"CellWithBtns";
                CellWithBtns *cell = (CellWithBtns*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) 
                { 
                    cell = [[CellWithBtns alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
                }
                cell.lblButtonHeading.text=[arrBtnHeadings objectAtIndex:indexPath.row];
                cell.lblFieldInstrtuctions.text=[arrbtnInstrucitons objectAtIndex:indexPath.row];
                cell.heightvwButtonValue.constant=0;
                cell.vwButtonValue.clipsToBounds=YES;
                return cell;
            }
            else
            {
                static NSString *cellIdentifier = @"CellListWithCheckBox";
                CellListWithCheckBox *cell = (CellListWithCheckBox*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) 
                { 
                    cell = [[CellListWithCheckBox alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
                }
                cell.vwCheckboxsubtext.hidden=YES;
                cell.lblsubtext.text=@"";
                [cell.lblsubtext sizeToFit];
                cell.vwCellMain.backgroundColor=[UIColor clearColor];
                cell.contentView.backgroundColor=[UIColor clearColor];
                cell.backgroundColor=[UIColor clearColor];
                cell.lblListName.textColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderColor=[UIColor whiteColor].CGColor;
                cell.btnCheckbox.layer.borderWidth=1.0f;
                cell.btnCheckbox.layer.cornerRadius=1.5f;
                cell.btnCheckbox.clipsToBounds=YES;
                cell.lblListName.text=[arroptions objectAtIndex:indexPath.row-2];
                
                return cell;
            }
        }
        else
        {
            static NSString *cellIdentifier = @"CellWithBtns";
            CellWithBtns *cell = (CellWithBtns*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[CellWithBtns alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            cell.lblButtonHeading.text=[arrBtnHeadings objectAtIndex:1];
            cell.lblFieldInstrtuctions.text=[arrbtnInstrucitons objectAtIndex:1];
            return cell; 
        }
    } 
    @catch (NSException *exception) {
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if(tblHeader==nil)
//    {
        NSArray *nibheader = [[NSBundle mainBundle] loadNibNamed:@"CellChooseTrailers" owner:self options:nil];
        tblHeader = (CellChooseTrailers *)[nibheader objectAtIndex:0];
//    }
 
    tblHeader.heightEditTrtailer.constant=0;
    tblHeader.vwEditTrailers.clipsToBounds=YES;
    tblHeader.cellChooseTrailersDelegate=self;
    if(tableView==_tblChooseTrailer)
    {
        tblHeader.heightChoosentype.constant=0;
        tblHeader.vwChoosenType.clipsToBounds=YES;
        tblHeader.btnChooseTrailers.hidden=YES;
        return tblHeader;
    }
    else
    {
        tblHeader.heightChoosentype.constant=98;
        tblHeader.vwChoosenType.clipsToBounds=YES;
        tblHeader.btnChooseTrailers.hidden=NO;
        tblHeader.btnOpenSaved.hidden=YES;
        return tblHeader;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    if(tableView==_tblChooseTrailer)
    {
        return 130.0f; 
    }
    else
    {
        return 230;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{  
    NSArray *nibfooter = [[NSBundle mainBundle] loadNibNamed:@"welcomeFooter" owner:self options:nil];
    tblfooter = (CellWelcomeFooter *)[nibfooter objectAtIndex:0];
    tblfooter.backgroundColor=[UIColor clearColor];
    tblfooter.vwFootercompany.backgroundColor=[UIColor clearColor];
    tblfooter.cellWelcomeFooterDelegate=self;
    tblfooter.heightvwWelocmeFooter.constant=0;
    tblfooter.heightOfficeFooter.constant=0;
    tblfooter.heightSummaryFooter.constant=0;
    tblfooter.vwSummaryFooter.clipsToBounds=YES;
    tblfooter.vwFootercompany.clipsToBounds=YES;
    tblfooter.vwOfficeInfoFooter.clipsToBounds=YES;
    tblfooter.heightcmpnyFooter.constant=150;
    if(tableView==_tblChooseTrailer)
    {
        [tblfooter.btncmpnayback setTitle:@"CANCEL" forState:UIControlStateNormal];
        tblfooter.btncmpnynext.tag=100;
    }
    else
    {
        [tblfooter.btncmpnayback setTitle:@"BACK" forState:UIControlStateNormal];
         tblfooter.btncmpnynext.tag=200;
    }
    return tblfooter;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    return 150; 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - welcome footer delegate
- (IBAction)btncmpnybackclicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if([btn.titleLabel.text  isEqualToString: @"BACK"])
    {
        self.tblChooseTrailer.hidden=NO;
        self.tblChooseSubTrailer.hidden=NO;
        
        [self viewWithAnimationFormView:self.tblChooseTrailer Toview:self.tblChooseSubTrailer transitionType:@"POPVIEW" withAnimation:YES];
    }
    else
    {
        HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
        AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objHomeVC];
        [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
    }
}
- (IBAction)btncmpnynextclicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if(btn.tag == 100)
    {
        self.tblChooseTrailer.hidden=NO;
        self.tblChooseSubTrailer.hidden=NO;
//        [self.tblChooseSubTrailer reloadData];
         [self viewWithAnimationFormView:self.tblChooseTrailer Toview:self.tblChooseSubTrailer transitionType:@"PUSHVIEW" withAnimation:YES];
    }
    else
    {
        PostLoadVC *postload=initVCToRedirect(SBAFTERSIGNUP, POSTLOADVC);
        [self.navigationController pushViewController:postload animated:YES];
    }
}
#pragma mark - choose trailer header delgate
- (IBAction)btnOpenSavedClicked:(id)sender
{
    
}
- (IBAction)btnChoosenTypeClicked:(id)sender
{
    
}
- (IBAction)btnEditTrailersClicked:(id)sender
{
    
}
#pragma mark - click events
- (IBAction)btnSettingClicked:(id)sender {
}

- (IBAction)btnDrawerClicked:(id)sender {
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
