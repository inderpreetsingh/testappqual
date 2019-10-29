//
//  PostLoadVC.m
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "PostLoadVC.h"
#import "Function.h"

#import "CDSubEspecialEquiList.h"

@interface PostLoadVC ()
{
    UIView *overlay,*overlayview;
    int noOfPhotos;
    
    NSString *selectedPopupName,*selectedPickupAddress,*selectedPickupcitystate,*listOfEquis,*listOfEquiSpecials,*selectedDelievryAddress,*selectedDelieverycitystate,*allEids,*allEEids,*pickupcity,*pickupstate,*pickupcountry,*pickuplat,*pickuplon,*delievrycity,*delieverystate,*delievrycountry,*delievrylat,*delievrylon,*visibilityvalue,*equinames,*equiespecialnames,*listforany,*measureUnit;
    
    NSMutableArray *arrEuipmentList,*arrEspecialEuipmentlist,*equipmentselected,*especialequiSelected,*arrLoadImages,*arrboolSelectionImages,*arrvisibilitySelected,*arrBtnHeadings,*arrAllSubEquipments;
    NSInteger selectedRow;
    NSDateFormatter *dateFormatter;
    NSArray *arrvisiblity,*arroptions,*arrbtnInstrucitons,*arrMesurement;
    NSDate *choosenPickUpdate;
    CellWelcomeFooter *tblfooter;
    CellChooseTrailers *tblHeader;
    CellPostLoadFooter *tblfootervw;
    CellPostLoadHeader *tblHeadervw;
    CellChooseTrailers *tblHeadingHeader;
    SPGooglePlacesAutocompleteViewController *googlePlacesVC;
    CQMFloatingController *floatingController;
    ZSYPopoverListView *listView;
    
    NSString *strTimeStamp;
}
@end

@implementation PostLoadVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    NavigationBarHidden(YES);
    
    strTimeStamp = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970] * 1000];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    if([_strRedirectFrom isEqualToString:@"CALENDER"])
    {
        [self.btnpeBack setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    }
    else
    {
        [self.btnpeBack setImage:imgNamed(@"") forState:UIControlStateNormal];
    }
    choosenPickUpdate=[NSDate date];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetAddress object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectedLocation:) name:NCNamedSetAddress object:nil];
    [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    selectedRow=2;
    visibilityvalue=@"2";
     measureUnit=@"0";
    _tblChooseTrailer.delegate=self;
    _tblChooseTrailer.dataSource=self;
    [self registerCustomNibForAllcell];
  
}
-(void)initArrays
{
    arrLoadImages=[NSMutableArray new];
    equipmentselected=[NSMutableArray new];
    especialequiSelected=[NSMutableArray new];
    arrEuipmentList=[NSMutableArray new];
    arrEspecialEuipmentlist=[NSMutableArray new];
    arrvisibilitySelected=[NSMutableArray new];
    arrAllSubEquipments=[NSMutableArray new];
    arrEuipmentList =[[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:EquiEspecialEntity]mutableCopy];
    arrAllSubEquipments=[[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:SubEquiEspecialEntity]mutableCopy];
    
    arrvisiblity=[[NSArray alloc]initWithObjects:@"Private",@"My Network",@"Everyone", nil];
    arrMesurement=[[NSArray alloc]initWithObjects:@"Items",@"US Gallons",@"US Tons",@"US Bushels",nil];
    arroptions=[NSArray arrayWithObjects:@"Any",@"I don't know",@"Choose trailer", nil];
    arrBtnHeadings=[NSMutableArray arrayWithObjects:@"What type of freight are you shipping?",@"What type of trailer do you need?",nil];
    arrbtnInstrucitons=[NSArray arrayWithObjects:@"",@"You can choose more that one",nil];
}
-(void)registerCustomNibForAllcell
{
    UINib *nibcellcv = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tblPostLoad] registerNib:nibcellcv forCellReuseIdentifier:@"CellWithCV"];
    
    UINib *nibcellpdf = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tblPostLoad]  registerNib:nibcellpdf forCellReuseIdentifier:@"cellPdfview"];
    
    UINib *nibcellbtn = [UINib nibWithNibName:@"CellWithBtns" bundle:nil];
    [[self tblChooseTrailer] registerNib:nibcellbtn forCellReuseIdentifier:@"CellWithBtns"];
    [[self tblChooseSubTrailer] registerNib:nibcellbtn forCellReuseIdentifier:@"CellWithBtns"];
    
    UINib *nibcellcb = [UINib nibWithNibName:@"CellListWithCheckBox" bundle:nil];
    [[self tblChooseTrailer]  registerNib:nibcellcb forCellReuseIdentifier:@"CellListWithCheckBox"];
    
    self.tblChooseTrailer.rowHeight = UITableViewAutomaticDimension;
    self.tblChooseTrailer.estimatedRowHeight = 120.0; 
    
    self.tblChooseSubTrailer.rowHeight = UITableViewAutomaticDimension;
    self.tblChooseSubTrailer.estimatedRowHeight = 120.0;  
    
    
    [self initArrays];
}
-(void)dismissKeyboard 
{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(arrEuipmentList.count ==0 || arrAllSubEquipments.count==0)
    {
        [self getAllEquipmentsBase];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
#pragma mark - tableview delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ 
    if(tableView == _tblPostLoad)
    {
        return 2;
    }
    else
    {
        return 1; 
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    if(tableView==_tblChooseTrailer)
    {
        return arroptions.count+arrBtnHeadings.count;
    }
    else if(tableView == _tblChooseSubTrailer)
    {
        return 1;
    }
    else 
    {
        if(section==0)
        {
            return 0;
        }
        else
        {
            return 2;
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == _tblChooseTrailer)
    {
//        if(tblHeader==nil)
//        {
            NSArray *nibheader = [[NSBundle mainBundle] loadNibNamed:@"CellChooseTrailers" owner:self options:nil];
            tblHeader = (CellChooseTrailers *)[nibheader objectAtIndex:0];
       // }
       
        tblHeader.heightEditTrtailer.constant=0;
        tblHeader.vwEditTrailers.clipsToBounds=YES;
        tblHeader.cellChooseTrailersDelegate=self;
        tblHeader.heightChoosentype.constant=0;
        tblHeader.vwChoosenType.clipsToBounds=YES;
        tblHeader.btnChooseTrailers.hidden=YES;
        return tblHeader;
       
    }
    else if(tableView == _tblChooseSubTrailer)
    {
//        if(tblHeader==nil)
//        {
            NSArray *nibheader = [[NSBundle mainBundle] loadNibNamed:@"CellChooseTrailers" owner:self options:nil];
            tblHeader = (CellChooseTrailers *)[nibheader objectAtIndex:0];
      //  }
       
        tblHeader.heightEditTrtailer.constant=0;
        tblHeader.vwEditTrailers.clipsToBounds=YES;
        tblHeader.cellChooseTrailersDelegate=self;
        tblHeader.heightChoosentype.constant=98;
        tblHeader.vwChoosenType.clipsToBounds=YES;
        tblHeader.btnChooseTrailers.hidden=NO;
        tblHeader.btnOpenSaved.hidden=YES;
        
        [tblHeader.btnChoosenType setTitle:[equinames uppercaseString] forState:UIControlStateNormal];
        return tblHeader;
    }
    else
    {
        if(section==0)
        {
//           if( tblHeadingHeader==nil)
//           {
               NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellChooseTrailers" owner:self options:nil];
               tblHeadingHeader= (CellChooseTrailers *)[nib objectAtIndex:0]; 
          // }
           
            tblHeadingHeader.cellChooseTrailersDelegate=self;
            tblHeadingHeader.btnOpenSaved.hidden=YES;
            tblHeadingHeader.lblCreateLoad.text=@"Add New Load";
            [tblHeadingHeader.btnChooseTrailers setTitle:@"Load Description" forState:UIControlStateNormal];
            tblHeadingHeader.lblShippingType.text=@"Trailers:";
            if(equiespecialnames.length==0)
            {
              
                tblHeadingHeader.lblChoosenType.text=listforany;
            }
            else
            {
                tblHeadingHeader.lblChoosenType.text=equiespecialnames;
            }
              tblHeadingHeader.lblChoosenType.textAlignment=NSTextAlignmentCenter;
            tblHeadingHeader.lblChoosenType.numberOfLines=0;
            [tblHeadingHeader.lblChoosenType sizeToFit];
//            [tblHeadingHeader.btnChoosenType setFont:[UIFont fontWithName:@"Arial-Regular" size:15]];
            tblHeadingHeader.btnChoosenType.backgroundColor=[UIColor clearColor];
            tblHeadingHeader.btnChoosenType.hidden=YES;
//            tblHeadingHeader.btnChoosenType.titleLabel.textAlignment=NSTextAlignmentCenter;
            return tblHeadingHeader;
        }
        else
        {
            if (tblHeadervw == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostLoadHeader" owner:self options:nil];
                tblHeadervw = (CellPostLoadHeader *)[nib objectAtIndex:0]; 
            }
            
            [tblHeadervw.txtLoadNumber setEnabled:NO];
            tblHeadervw.txtLoadNumber.text = strTimeStamp;
            
            tblHeadervw.cellPostLoadHeaderDelegate = self;
            tblHeadervw.heightVwHeader.constant = 0;
            tblHeadervw.heightvwchoosentEspecials.constant = 0;
            tblHeadervw.txtPostLoadOfferrate.delegate = self;
            
            [tblHeadervw.vwEquimentSelection addConstraint:[NSLayoutConstraint constraintWithItem:tblHeadervw.vwEquimentSelection
                                                                                        attribute:NSLayoutAttributeHeight
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:nil
                                                                                        attribute: NSLayoutAttributeNotAnAttribute
                                                                                       multiplier:1
                                                                                         constant:0]];
            
            tblHeadervw.viewHeading .clipsToBounds = YES;
            tblHeadervw.vwEquimentSelection.backgroundColor = [UIColor redColor];
            tblHeadervw.vwEquimentSelection.clipsToBounds = YES;
            if (tblHeadervw.btnLoadPostIsBestOffer.selected)
            {
                tblHeadervw.btnLoadPostIsBestOffer.accessibilityLabel = @"1";
            }
            else
            {
                tblHeadervw.btnLoadPostIsBestOffer.accessibilityLabel = @"0";
            }
            
            if (tblHeadervw.btnLoadPostAllowComment.selected)
            {
                tblHeadervw.btnLoadPostAllowComment.accessibilityLabel = @"1";
            }
            else
            {
                tblHeadervw.btnLoadPostAllowComment.accessibilityLabel = @"0";
            }
            
            [tblHeadervw.btnLoadPostVisibility setTitle:[arrvisiblity objectAtIndex:[visibilityvalue intValue]] forState:UIControlStateNormal];
            [tblHeadervw.btnUnitMeasure setTitle:[arrMesurement objectAtIndex:[measureUnit intValue]] forState:UIControlStateNormal];
            
            return tblHeadervw;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    
    if(tableView==_tblChooseTrailer)
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
        [tblfooter.btncmpnayback setTitle:@"CANCEL" forState:UIControlStateNormal];
        tblfooter.btncmpnynext.tag=100;
        return tblfooter;
    }
    else if(tableView == _tblChooseSubTrailer)
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
        [tblfooter.btncmpnayback setTitle:@"BACK" forState:UIControlStateNormal];
        tblfooter.btncmpnynext.tag=200;
        return tblfooter;
    }
    else
    {
        if(section==0)
        {
            return [[UIView alloc]initWithFrame:CGRectZero];
        }
        else
        {
            tblfootervw=[[CellPostLoadFooter alloc] initWithFrame:CGRectMake(0, 0, self.tblPostLoad.frame.size.width, 190)];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostLoadFooter" owner:self options:nil];
            tblfootervw = (CellPostLoadFooter *)[nib objectAtIndex:0]; 
            tblfootervw.btnSaveLoad.hidden=NO;
            tblfootervw.btnPublishLoad.hidden=NO;
            tblfootervw.btnloadUpdate.hidden=YES;
            tblfootervw.cellPostLoadFooterDelegate=self;
            return tblfootervw;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
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
            cell.heightvwButtonValue.constant=50;
            cell.cellWithBtnsDelegate=self;
            cell.vwButtonValue.clipsToBounds=YES;
            cell.btnFieldValue.tag=1000;
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
             cell.cellWithBtnsDelegate=self;
            cell.vwButtonValue.clipsToBounds=YES;
            cell.btnFieldValue.tag=1001;
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
            if (indexPath.row == selectedRow)
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;                
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
            cell.vwCellMain.backgroundColor=[UIColor clearColor];
            cell.contentView.backgroundColor=[UIColor clearColor];
            cell.backgroundColor=[UIColor clearColor];
            cell.lblListName.textColor=[UIColor whiteColor];
          
            cell.btnCellClick.tag=indexPath.row;
            cell.cellListWithCheckBoxDelegate=self;
            cell.lblListName.text=[arroptions objectAtIndex:indexPath.row-2];
            cell.btnCellClick.userInteractionEnabled=YES;
            cell.lblListName.numberOfLines =2;
            return cell;
        }
    }
    else if(tableView == _tblChooseSubTrailer)
    {
        static NSString *cellIdentifier = @"CellWithBtns";
        CellWithBtns *cell = (CellWithBtns*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) 
        { 
            cell = [[CellWithBtns alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
        }
         cell.cellWithBtnsDelegate=self;
        cell.lblButtonHeading.text=[arrBtnHeadings objectAtIndex:1];
        cell.lblFieldInstrtuctions.text=[arrbtnInstrucitons objectAtIndex:1];
         cell.btnFieldValue.tag=1002;
        return cell; 
    }
    else
    {
        if(indexPath.row==0)
        {
            static NSString *cellIdentifier = @"CellWithCV";
            CellWithCV *cell = (CellWithCV*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[CellWithCV alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            
            cell.cvPhotoes.dataSource=self;
            cell.cvPhotoes.delegate=self;
            if(arrLoadImages.count==0)
            {
                cell.cvPhotoes.hidden=YES;
                cell.lblNoData.hidden=NO;
            }
            else
            {
                cell.cvPhotoes.hidden=NO;
                cell.lblNoData.hidden=YES;
            }
            return cell;
        }
        else
        {
            static NSString *cellIdentifier = @"cellPdfview";
            cellPdfview *cell = (cellPdfview*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) 
            { 
                cell = [[cellPdfview alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]; 
            }
            [cell.btnPdfName setTitle:@"Add Pictures" forState:UIControlStateNormal];
            cell.btnPdfName.titleLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:15];
            [cell.btnPdfName setImage:imgNamed(@"imgplus") forState:UIControlStateNormal];
            cell.btnPdfDelete.hidden=YES;
            cell.cellPdfviewDelegate=self;
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (IBAction)btnCellClicked:(id)sender
{
     
    selectedRow=[sender tag];
    if(selectedRow !=4)
    {
        equiespecialnames=@"";
        [self.tblPostLoad reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        [especialequiSelected removeAllObjects];
      
        [self.tblChooseSubTrailer reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
    [self.tblChooseTrailer reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tblPostLoad)
    {
        if(indexPath.row==0)
        {
            return 150;
        }
        else
        {
            return 30;
        }
    }
    else
    {
        if(tableView==_tblChooseTrailer)
        {
            if (indexPath.row >= 2)
            {
                return 35;
            }
            else
            {
                 return UITableViewAutomaticDimension;
            }
        }
        else
        {
             return UITableViewAutomaticDimension;
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    if(tableView==_tblChooseTrailer)
    {
        return 130.0f; 
    }
    else if(tableView ==_tblChooseSubTrailer)
    {
        return 230;
    }
    else
    {
        if(section==0)
        {
            UILabel *lbl=[UILabel new];
            lbl.text=equiespecialnames;
            lbl.numberOfLines=0;
            [lbl sizeToFit];
            if(lbl.frame.size.height > 70)
            {
                return 350;
            }
            else
            {
                return 300;
            }
            lbl=nil;
        }
        else
        {
            return 1177 ;
        }
    }
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    if(tableView == _tblPostLoad)
    {
        if(section==0)
        {
            return 0;
        }
        else
        {
            return 190;
        }
    }
    else
    {
        return 150;
    }
}

#pragma mark - Collection view  delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrLoadImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellCvPickedImage *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCvPickedImage" forIndexPath:indexPath];
    cell.btnDeleteImage.tag=indexPath.item;
    cell.cellCvPickedImageDelegate = self;
    cell.imgLarge.image = [arrLoadImages objectAtIndex:indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.height,collectionView.frame.size.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}
- (void)btnDeleteImageClicked:(id)sender
{
    UIButton *dltsender=(UIButton *)sender;
    [arrLoadImages removeObjectAtIndex:[dltsender tag]];
    CellWithCV *cellimages = (CellWithCV*)[_tblPostLoad cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if(arrLoadImages.count > 0)
    {
        [cellimages.cvPhotoes reloadData];
        cellimages.lblNoData.hidden=YES;
        cellimages.cvPhotoes.hidden=NO;
    }
    else
    {
        cellimages.lblNoData.hidden=NO;
        cellimages.cvPhotoes.hidden=YES;
    }
    
}
#pragma mark - Cell FOOTER delegate
- (IBAction)btnPdfNameClicked:(id)sender 
{
    [self openImagePicker];
}
-(void)openImagePicker
{
    CellWithCV *cellselected=(CellWithCV*)[_tblPostLoad cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    if(arrLoadImages.count<5)
    {
        DKImagePickerController *pickerController = [DKImagePickerController new];
        pickerController.assetType = DKImagePickerControllerAssetTypeAllPhotos;
        pickerController.showsCancelButton = YES;
        pickerController.showsEmptyAlbums = NO;
        pickerController.allowMultipleTypes = YES;
        pickerController.maxSelectableCount=5-arrLoadImages.count;
        pickerController.defaultSelectedAssets = @[];
        pickerController.sourceType = DKImagePickerControllerSourceTypeBoth;
        pickerController.navigationBar.barTintColor=[UIColor orangeColor];
        pickerController.navigationBar.tintColor=[UIColor whiteColor];
        [pickerController setDidSelectAssets:^(NSArray * __nonnull assets)
         {
             for(int i =0;i<assets.count;i++)
             {
                 DKAsset * asset=[assets objectAtIndex:i];
                 [asset fetchOriginalImageWithCompleteBlock:^(UIImage * img, NSDictionary * dic) 
                  {
                     img = [Function scaleAndRotateImage:img];
                      [arrLoadImages addObject:img];
                      if(i == (assets.count -1))
                      {
                          [cellselected.cvPhotoes reloadData];
                          cellselected.cvPhotoes.hidden=NO;
                          cellselected.lblNoData.hidden=YES;
                      }
                  }];
             }
         }];
        [self presentViewController:pickerController animated:YES completion:nil];
    }
    else
    {
        [AZNotification showNotificationWithTitle:MaxLimitPhoto controller:ROOTVIEW notificationType:AZNotificationTypeError];
    }
}

#pragma mark - Cell delegate Click Events 
- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnDrawerClicked:(id)sender {
     [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
#pragma mark - welcome footer delegate
- (IBAction)btncmpnybackclicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if([btn.titleLabel.text  isEqualToString: @"BACK"])
    {       
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
    if (btn.tag == 100)
    {
        if ([self validateTxtLength:equinames withMessage:RequiredShippingType])
        {
            if (selectedRow == 4)
            {
                [self viewWithAnimationFormView:self.tblChooseTrailer Toview:self.tblChooseSubTrailer transitionType:@"PUSHVIEW" withAnimation:YES];
            }
            else
            {
                [self viewWithAnimationFormView:self.tblChooseTrailer Toview:self.tblPostLoad transitionType:@"PUSHVIEW" withAnimation:YES];
                self.tblChooseSubTrailer.alpha = 0;
            }
        }
    }
    else
    {
        if([self validateTxtLength:equiespecialnames withMessage:RequiredTrailersType])
        {
            [self viewWithAnimationFormView:self.tblChooseSubTrailer Toview:self.tblPostLoad transitionType:@"PUSHVIEW" withAnimation:YES];
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField isEqual:tblHeadervw.txtPostLoadOfferrate])
    {
        if(textField.text.length >0)
        {
            tblHeadervw.btnLoadPostIsBestOffer.selected=YES;
           
        }
        else
        {
             tblHeadervw.btnLoadPostIsBestOffer.selected=NO;
        }
         [self btnLoadPostBestOfferClicked:tblHeadervw.btnLoadPostIsBestOffer];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField isEqual:tblHeadervw.txtPostLoadOfferrate])
    {
        tblHeadervw.btnLoadPostIsBestOffer.selected=YES;
        [self btnLoadPostBestOfferClicked:tblHeadervw.btnLoadPostIsBestOffer];
    }
}
 
#pragma mark - cell with button delegate
- (IBAction)btnFiedlValueClicked:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if([btn tag] == 1000)
    {
        listView= [self showListView:listView withSelectiontext:EquipmentListPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
        [listView show];
    }
    else if([btn tag]==1002)
    {
        
        listView= [self showListView:listView withSelectiontext:EspecialEquiPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
        [listView show];
    }
}
#pragma mark - choose trailer header delgate

- (IBAction)btnOpenSavedClicked:(id)sender
{
    AllSavedLoadListVC *objsavedlist=initVCToRedirect(SBAFTERSIGNUP, ALLSAVEDLOADLIST);
    [self.navigationController pushViewController:objsavedlist animated:YES];
}
- (IBAction)btnChoosenTypeClicked:(id)sender
{
    
}
- (IBAction)btnEditTrailersClicked:(id)sender
{
    if(selectedRow == 4)
    {
          [self viewWithAnimationFormView:self.tblChooseSubTrailer Toview:self.tblPostLoad transitionType:@"POPVIEW" withAnimation:YES];
    }
    else
    {
        [self viewWithAnimationFormView:self.tblChooseTrailer Toview:self.tblPostLoad transitionType:@"POPVIEW" withAnimation:YES];
        self.tblChooseSubTrailer.alpha=0;
       
    }
    
}

#pragma mark - Cell HEADER delegate
- (IBAction)btnLoadPostEquiListClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:EquipmentListPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
    [listView show];
}
- (IBAction)btnLoadPostAddEspecialEquiClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:EspecialEquiPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT/2];
    [listView show];
}
- (IBAction)btnUnitMeasureclicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:UniteMeasurePopUpTitle widthval:SCREEN_WIDTH - 100 heightval:320];
    [listView show];
}
- (IBAction)btnLoadPostOpenSavedClicked:(id)sender
{
        AllSavedLoadListVC *objsavedlist=initVCToRedirect(SBAFTERSIGNUP, ALLSAVEDLOADLIST);
        [self.navigationController pushViewController:objsavedlist animated:YES];
}

- (IBAction)btnLoadPostBestOfferClicked:(id)sender
{
    UIButton *senderbtn=(UIButton*)sender;
    if(senderbtn.selected)
    {
        [senderbtn setImage:imgNamed(iconCheckboxSquare)  forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=[NSString stringWithFormat:@"0"];
    }
    else
    {
        [senderbtn setImage:imgNamed(iconCheckboxSquareSelectedwhitebg) forState:UIControlStateNormal];
        tblHeadervw.txtPostLoadOfferrate.text=@"";
        senderbtn.accessibilityLabel=[NSString stringWithFormat:@"1"];
    }
    senderbtn.selected = ![senderbtn isSelected];
}

- (IBAction)btnLoadPostPickupcityStateClicked:(id)sender
{
    [self showMapViewPopUp:@"PICKUP"];
}

- (IBAction)btnLoadPostPickupMapPinClicked:(id)sender
{
    [self showMapViewPopUp:@"PICKUP"];
}

- (IBAction)btnLoadPostPickUpTimeClicked:(id)sender
{
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    [picker setDatePickerMode:UIDatePickerModeDateAndTime];
    picker.timeZone = [NSTimeZone localTimeZone];
    picker.calendar = [NSCalendar currentCalendar];
    [picker setMinimumDate: [NSDate date]];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Pickup Time\n\nPickup time used for finding available assets against calander.\n\n\n\n\n\n\n\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    picker.frame=CGRectMake(actionSheet.view.frame.origin.x, actionSheet.view.frame.origin.y+50, actionSheet.view.frame.size.width, 300);
    [actionSheet.view addSubview:picker];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
                                
//                                NSString *dateString = [GlobalFunction getDateStringFromDate:picker.date withFormate:@"MMM dd,yyyy, hh:mm a"];
//                                [tblHeadervw.btnLoadPostPickUpTime setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                 NSString *dateString = [GlobalFunction getDateStringFromDate:picker.date withFormate:@"MMM dd,yyyy, hh:mm a"];
                                choosenPickUpdate=picker.date;
                                [tblHeadervw.btnLoadPostPickUpTime setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}

- (IBAction)btnLoadPostPickUpAddressClicked:(id)sender
{
    [self showMapViewPopUp:@"PICKUP"];
}

- (IBAction)btnLoadPostDelievrycityStateClicked:(id)sender
{
    [self showMapViewPopUp:@"DELIEVERY"];
}

- (IBAction)btnLoadPostDelievryTimeClicked:(id)sender
{
    if(tblHeadervw.btnLoadPostPickUpTime.titleLabel.text.length==0)
    {
        [AZNotification showNotificationWithTitle:PickupTimeSelectFirst controller:ROOTVIEW notificationType:AZNotificationTypeError];
        return;
    }
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    
    [picker setDatePickerMode:UIDatePickerModeDateAndTime];
    picker.timeZone = [NSTimeZone localTimeZone];
    picker.calendar = [NSCalendar currentCalendar];
    
    [picker setMinimumDate: [choosenPickUpdate dateByAddingTimeInterval:30*60]];
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Delivery Time\n\n\n\n\n\n\n\n\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet.view addSubview:picker];
    picker.frame=CGRectMake(actionSheet.view.frame.origin.x+5, actionSheet.view.frame.origin.y+5, actionSheet.view.frame.size.width-10, 300);
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
//                                 NSString *dateString = [GlobalFunction getDateStringFromDate:picker.date withFormate:@"MMM dd,yyyy, hh:mm a"];
//                                [tblHeadervw.btnLoadPostDelievryTime setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                NSString *dateString = [GlobalFunction getDateStringFromDate:picker.date withFormate:@"MMM dd,yyyy, hh:mm a"];
                                [tblHeadervw.btnLoadPostDelievryTime setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}

- (IBAction)btnLoadPostDelievryCityStateMapPinClicked:(id)sender
{
    [self showMapViewPopUp:@"DELIVERY"];
}

- (IBAction)btnLoadPostPickupAddressMapClicked:(id)sender
{
    [self showMapViewPopUp:@"PICKUP"];
}

- (IBAction)btnLoadPostDelieveryAddressClicked:(id)sender
{
    [self showMapViewPopUp:@"DELIVERY"];
}

- (IBAction)btnLoadPostVisibilityClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:VisibilityTitle widthval:200 heightval:235];
    [listView show];
}

- (IBAction)btnLoadPostAllowCommentClicked:(id)sender
{
    UIButton *senderbtn=(UIButton*)sender;
    if(senderbtn.selected)
    {
        [senderbtn setImage:imgNamed(iconCheckboxSquare)  forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=[NSString stringWithFormat:@"0"];
    }
    else
    {
        [senderbtn setImage:imgNamed(iconCheckboxSquareSelectedwhitebg) forState:UIControlStateNormal];
        senderbtn.accessibilityLabel=[NSString stringWithFormat:@"1"];
    }
    senderbtn.selected = ![senderbtn isSelected];
}

- (IBAction)btnLoadPostDelieveryAddressMapClicked:(id)sender
{
    [self showMapViewPopUp:@"DELIEVERY"];
}
- (IBAction)btnPublishLoadClicked:(id)sender 
{
      [self prepareRequestToSaveOnServer:@"1"]; 
}
- (IBAction)btnSaveLoadClicekd:(id)sender 
{
    [self prepareRequestToSaveOnServer:@"0"]; 
}
- (IBAction)btnUpdateLoadClicked:(id)sender
{}


-(void)prepareRequestToSaveOnServer:(NSString *)ispublish
{
    @try {        
        if(
[self validateTxtLength:tblHeadervw.txtLoadNumber.text withMessage:RequiredLoadNumber] &&
           [self validateTxtLength:tblHeadervw.txtPostLoadvwLoadDesc.text withMessage:RequiredDescription] &&
           [self validateTxtLength:tblHeadervw.txtPostLoadWeight.text withMessage:RequiredWeight] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostPickupcityState.titleLabel.text withMessage:RequiredPickupCityState]&&
           [self validateTxtLength:tblHeadervw.btnLoadPostPickUpTime.titleLabel.text withMessage:RequiredPickupTime] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostPickUpAddress.titleLabel.text withMessage:RequiredPickupAddress] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostDelievrycityState.titleLabel.text withMessage:RequiredDelieveryCityState] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostDelievryTime.titleLabel.text withMessage:RequiredDelieveryTime] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostDelieveryAddress.titleLabel.text withMessage:RequiredDelieveryAddress] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostVisibility.titleLabel.text withMessage:RequiredViewableTo])
        {
            
            switch (arrLoadImages.count) {
                case 0:
                {
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                }
                    break;
                case 1:
                {
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                }
                    break;
                case 2:
                {
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                }
                    break;
                case 3:
                {
                    [arrLoadImages addObject:@""];
                    [arrLoadImages addObject:@""];
                }
                    break;
                case 4:
                {
                    [arrLoadImages addObject:@""];
                }
                    break;
                default:
                    break;
            }
            NSString *offerrate,*notesval;
            if(tblHeadervw.txtPostLoadOfferrate.text.length==0)
            {
                offerrate=@"0";
            }
            else
            {
                offerrate=tblHeadervw.txtPostLoadOfferrate.text;
            }
            if(tblfootervw.txtFooterNotes.text.length==0)
            {
                notesval=@"No notes available";
            }
            else
            {
                notesval=tblfootervw.txtFooterNotes.text;
            }
            
           // NSString *doc;
            NSDictionary *dicsaveLoad=@{
                                          Req_Load_Number:tblHeadervw.txtLoadNumber.text,
                                          Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                          Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                          Req_E_Id:allEids,
                                          Req_Es_Id:allEEids,
                                          Req_identifier:@"",
                                          Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                          Req_Load_Description:tblHeadervw.txtPostLoadvwLoadDesc.text,
                                          Req_Load_Width:tblHeadervw.txtPostLoadWidth.text.length>0 ? tblHeadervw.txtPostLoadWidth.text :@"0",
                                          Req_Load_Height:tblHeadervw.txtPostLoadHeight.text.length>0 ? tblHeadervw.txtPostLoadHeight.text :@"0",
                                          Req_Load_Length:tblHeadervw.txtPostLoadLength.text.length>0 ? tblHeadervw.txtPostLoadLength.text :@"0",
                                          Req_Load_Weight:tblHeadervw.txtPostLoadWeight.text,
                                          Req_Offer_Rate :offerrate,
                                          Req_Is_Best_Offer:tblHeadervw.btnLoadPostIsBestOffer.accessibilityLabel,
                                          Req_Pickup_Address :tblHeadervw.btnLoadPostPickUpAddress.titleLabel.text,
                                          Req_Pickup_Time:tblHeadervw.btnLoadPostPickUpTime.titleLabel.text,
                                          Req_Delivery_Address:tblHeadervw.btnLoadPostDelieveryAddress.titleLabel.text,
                                          Req_Delivery_Time:tblHeadervw.btnLoadPostDelievryTime.titleLabel.text,
                                          Req_Is_Allow_Comment :tblHeadervw.btnLoadPostAllowComment.accessibilityLabel,
                                          Req_Notes:notesval,
                                          Req_Pickup_City:pickupcity,
                                          Req_Pickup_State:pickupstate,
                                          Req_Pickup_Country:pickupcountry,
                                          Req_Pickup_Latitude:pickuplat,
                                          Req_Pickup_Longitude:pickuplon,
                                          Req_Delivery_City:delievrycity,
                                          Req_Delivery_State:delieverystate,
                                          Req_Delivery_Country:delievrycountry,
                                          Req_Delivery_Latitude :delievrylat,
                                          Req_Delivery_Longitude:delievrylon,
                                          Req_Visible_To :visibilityvalue,
                                          Req_Is_Publish:ispublish,
                                          Req_Load_Video_Thumb:@"",
                                          Req_Load_Doc_Thumb:@"",
                                          Req_Load_Photo1:[arrLoadImages objectAtIndex:0],
                                          Req_Load_Photo2:[arrLoadImages objectAtIndex:1],
                                          Req_Load_Photo3:[arrLoadImages objectAtIndex:2],
                                          Req_Load_Photo4:[arrLoadImages objectAtIndex:3],
                                          Req_Load_Photo5:[arrLoadImages objectAtIndex:4],
                                          Req_Load_Video:@"",
                                          Req_Load_Doc:@"",
                                          Req_LoadName: tblHeadervw.txtloadname.text.length>0? tblHeadervw.txtloadname.text:@"",
                                          Req_Qty: tblHeadervw.txtquantity.text.length>0? tblHeadervw.txtquantity.text:@"1",
                                          Req_UnitMeasure: measureUnit.length>0? measureUnit:@"0",
                                          Req_BolPod: tblHeadervw.txtbolpod.text.length>0? tblHeadervw.txtbolpod.text:@""
                                          };   
        if([[NetworkAvailability instance]isReachable])
        {
            [[WebServiceConnector alloc]
             init:URLPostNewLoad
             withParameters:dicsaveLoad
             withObject:self
             withSelector:@selector(getPostLoadResponse:)
             forServiceType:@"FORMDATA"
             showDisplayMsg:@"Saving Load"
             showProgress:YES];
        }
        else
        {
            [self dismissHUD];
            [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
   }
        
    } @catch (NSException *exception) 
    {
        NSLog(@"Exception :%@",exception.description);
        NSString *str=[NSString stringWithFormat:@"Line : 1109  |  Vc - PostLoadVC  |  Function PrepareRequestToSaveOnServer  |  Exception - %@",exception.description];
        [self crashReporter:str];
    }  
}


-(IBAction)getPostLoadResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];
        [arrLoadImages removeAllObjects];
    }
    else
    {
        if([APIResponseStatus isEqualToString:APISuccess])
        {
           [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
            if([APIIsPublished isEqualToString:@"1"])
            {
                AppInstance.arrAllLoadByUserId=nil;
                AppInstance.dicAllMatchByLoadId=nil;
                AppInstance.countLodByUid=@"0";
                AppInstance.arrAllEquipmentByUserId=nil;
                AppInstance.countEquiByUid=@"0";
            }
            HomeVC *objHomeVC =initVCToRedirect(SBAFTERSIGNUP, HOMEVC);
            AppInstance.firstnav = [[UINavigationController alloc] initWithRootViewController:objHomeVC];
            [AppInstance.drawerController setCenterViewController:AppInstance.firstnav];
        }
        else
        {
            [AZNotification showNotificationWithTitle:APIResponseMessage controller:ROOTVIEW notificationType:AZNotificationTypeError];
        }
    }
}

#pragma mark - custom methods
-(void)addOverlay
{
    overlayview = [[UIView alloc] initWithFrame:CGRectMake(0,  0,self.view.frame.size.width, SCREEN_HEIGHT)];
    [overlayview setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    UITapGestureRecognizer *overlayTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(onOverlayTapped)];
    [overlayview addGestureRecognizer:overlayTap];
    [self.view.window addSubview:overlayview];
}
- (void)onOverlayTapped
{
    @try {
        [UIView animateWithDuration:0.2f animations:^{
            overlayview.alpha=0;
            [listView dismiss];
        }completion:^(BOOL finished) {
            [overlayview removeFromSuperview];
        }];
    } @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception.description);
    } 
   
}
-(void)showMapViewPopUp:(NSString *)requestName
{
    @try {
        googlePlacesVC = [[SPGooglePlacesAutocompleteViewController alloc] init];
        googlePlacesVC.requestMapFor=requestName;
        floatingController = [CQMFloatingController sharedFloatingController];
        [floatingController setFrameColor:[UIColor whiteColor]];
        UIWindow *window1 = [[UIApplication sharedApplication] keyWindow];
        UIView *rootView = [window1.rootViewController view];
        [floatingController showInView:rootView
             withContentViewController:googlePlacesVC
                              animated:YES];
    } 
    @catch (NSException *exception)
    {
        NSLog(@"Exception :%@",exception.description);
        NSString *str=[NSString stringWithFormat:@"Line : 1187  |  Vc - PostLoadVC  |  Function - showMapViewPopUp  |  Exception - %@",exception.description];
        [self crashReporter:str];
    } 
    
}
-(void)setSelectedLocation:(NSNotification *)anote
{
    @try
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedDismissView object:nil];
        
        NSDictionary *dict = anote.userInfo;
        
        NSString *requestAddressType=[NSString stringWithFormat:@"%@",[dict objectForKey:@"AddressType"]];
        if([requestAddressType isEqualToString:@"PICKUP"])
        {
            pickuplat=[dict objectForKey:@"AddressLatitude"];
            pickuplon=[dict objectForKey:@"AddressLongitude"];
            pickupcountry=[dict objectForKey:@"SelectedCountry"];
            pickupstate=[dict objectForKey:@"SelectedState"];
            pickupcity=[dict objectForKey:@"SelectedCity"];
            selectedPickupcitystate = [NSString stringWithFormat:@"%@,%@",[dict objectForKey:@"SelectedCity"],[dict objectForKey:@"SelectedState"]];
            selectedPickupAddress = [dict objectForKey:@"SelectedAddress"];
            
            [tblHeadervw.btnLoadPostPickUpAddress setTitle:selectedPickupAddress forState:UIControlStateNormal];
            
            [tblHeadervw.btnLoadPostPickupcityState setTitle:selectedPickupcitystate forState:UIControlStateNormal];
        }
        else
        {
            delievrylat=[dict objectForKey:@"AddressLatitude"];
            delievrylon=[dict objectForKey:@"AddressLongitude"];
            delievrycountry=[dict objectForKey:@"SelectedCountry"];
            delieverystate=[dict objectForKey:@"SelectedState"];
            delievrycity=[dict objectForKey:@"SelectedCity"];
            
            selectedDelieverycitystate = [NSString stringWithFormat:@"%@,%@",[dict objectForKey:@"SelectedCity"],[dict objectForKey:@"SelectedState"]];
            selectedDelievryAddress = [dict objectForKey:@"SelectedAddress"];
            
            [tblHeadervw.btnLoadPostDelieveryAddress setTitle:selectedDelievryAddress forState:UIControlStateNormal];
            [tblHeadervw.btnLoadPostDelievrycityState setTitle:selectedDelieverycitystate forState:UIControlStateNormal];
        }

    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception :%@",exception.description);
        NSString *str=[NSString stringWithFormat:@"Line : 1225  |  Vc - PostLoadVC  |  Function - setSelectedLocation  |  Exception - %@",exception.description];
        [self crashReporter:str];
    } 
       
}

-(NSString *)gatherEquipmentIds
{
    NSString *listOfAllEqui = @"";
    EquiEspecial *objequi;
    equinames=@"";
    for(NSIndexPath *index in equipmentselected)
    {
        objequi=[arrEuipmentList objectAtIndex:index.row];
        NSString *eID =[NSString stringWithFormat:@"%@",objequi.internalBaseClassIdentifier];
        NSString *eIDname =[NSString stringWithFormat:@"%@",objequi.eName];
        
        if([equipmentselected lastObject]!=index)
        {
            listOfAllEqui = [listOfAllEqui stringByAppendingString:[eID stringByAppendingString:@","]];
        }
        else
        {
            listOfAllEqui = [listOfAllEqui stringByAppendingString:eID];
        }
        equinames=eIDname;
    }
    return listOfAllEqui;
}

-(NSString *)gatherEquipmentEspecialIds
{
    NSString *listOfEspecialEquis = @"";
    equiespecialnames=@"";
    SubEquiEspecial *objequi;
    for(NSIndexPath *index in especialequiSelected)
    {
        objequi=[arrEspecialEuipmentlist objectAtIndex:index.row];
        NSString *eIDname =[NSString stringWithFormat:@"%@",objequi.esName];
        NSString *eeID =[NSString stringWithFormat:@"%@",objequi.internalBaseClassIdentifier];
        if([especialequiSelected lastObject]!=index)
        {
            listOfEspecialEquis = [listOfEspecialEquis stringByAppendingString:[eeID stringByAppendingString:@","]];
            equiespecialnames= [equiespecialnames stringByAppendingString:[eIDname stringByAppendingString:@","]];
        }
        else
        {
            listOfEspecialEquis = [listOfEspecialEquis stringByAppendingString:eeID];
            equiespecialnames= [equiespecialnames stringByAppendingString:eIDname];
        }
      
    }
    tblHeadingHeader.lblChoosenType.text=equiespecialnames;
    tblHeadingHeader.lblChoosenType.numberOfLines=0;
    [tblHeadingHeader.lblChoosenType sizeToFit];
    [self.tblPostLoad reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone ];
    return listOfEspecialEquis;
}

-(ZSYPopoverListView *)showListView :(ZSYPopoverListView *)listviewname withSelectiontext :(NSString *)selectionm widthval:(CGFloat)w heightval :(CGFloat)h
{
    selectedPopupName=selectionm;
    listviewname.backgroundColor=[UIColor whiteColor];
    listviewname = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0,0, w, h)];
    listviewname.calledFor=selectedPopupName;
    listviewname.center=self.view.center;
    listviewname.titleName.backgroundColor=[UIColor whiteColor];
    listviewname.titleName.text = [NSString stringWithFormat:@"%@",selectionm];
    listviewname.datasource = self;
    listviewname.delegate = self;
    listviewname.layer.cornerRadius=3.0f;
    listviewname.clipsToBounds=YES;
    
    [listviewname setDoneButtonWithTitle:@"" block:^{
        [overlayview removeFromSuperview];
    }];
    if([selectedPopupName isEqualToString:VisibilityTitle])
    {
          [listviewname setCancelButtonTitle:@"" block:^{
          }];
    }
    else
    {
        [listviewname setCancelButtonTitle:@"Done" block:^{
            [overlayview removeFromSuperview];
            if([selectedPopupName isEqualToString:EquipmentListPopUpTitle])
            {
                listOfEquis=@"";
                listOfEquis = [self gatherEquipmentIds];
               CellWithBtns *btncell=(CellWithBtns *)[self.tblChooseTrailer cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                if(listOfEquis.length==0)
                {
                    [btncell.btnFieldValue setTitle:@"" forState:UIControlStateNormal];
                   // [tblHeadervw.btnLoadPostEquipmentList setTitle:@"" forState:UIControlStateNormal];
                }
                else
                {
                     [btncell.btnFieldValue setTitle:equinames  forState:UIControlStateNormal];
                   // [tblHeadervw.btnLoadPostEquipmentList setTitle:equinames forState:UIControlStateNormal];
                }
                [especialequiSelected removeAllObjects];
                equiespecialnames=@"";
                
                
//                NSString *searchID = @"1";
                NSString *pattern = [NSString stringWithFormat:@"(^|.*,)%@(,.*|$)",
                                     [NSRegularExpression escapedPatternForString:listOfEquis]];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentId MATCHES %@", pattern];
             
                arrEspecialEuipmentlist = [[NSMutableArray alloc]initWithArray:[arrAllSubEquipments filteredArrayUsingPredicate:predicate]];
                
                CellWithBtns *btncell2=(CellWithBtns *)[self.tblChooseSubTrailer cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                [btncell2.btnFieldValue setTitle:@"" forState:UIControlStateNormal];
                 [self.tblChooseSubTrailer reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                allEids=listOfEquis;
                
                if(arrEspecialEuipmentlist.count > 0)
                {
                    allEEids=@"";
                    listforany=@"";
                    for(CDSubEspecialEquiList *cd in arrEspecialEuipmentlist)
                    {
                        NSString *eeID =[NSString stringWithFormat:@"%@",cd.internalBaseClassIdentifier];
                        allEEids=[allEEids stringByAppendingString:[eeID stringByAppendingString:@","]];
                        listforany=[listforany stringByAppendingString:[cd.esName stringByAppendingString:@","]];
                    }
                    allEEids = [allEEids substringToIndex:[allEEids length]-1];
                    listforany = [listforany substringToIndex:[listforany length]-1];
                    [self.tblPostLoad reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                }
               
            }
            else  if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
            {
                CellWithBtns *btncell=(CellWithBtns *)[self.tblChooseSubTrailer cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                listOfEquiSpecials=@"";
                listOfEquiSpecials = [self gatherEquipmentEspecialIds];
                if(listOfEquiSpecials.length==0)
                {
//                    [tblHeadervw.btnLoadPostAddEspecialEqui setTitle:@"Add Especial Equipment" forState:UIControlStateNormal];
                     [btncell.btnFieldValue setTitle:@"" forState:UIControlStateNormal];
                }
                else
                {
//                    [tblHeadervw.btnLoadPostAddEspecialEqui setTitle:equiespecialnames forState:UIControlStateNormal];
                     [btncell.btnFieldValue setTitle:equiespecialnames  forState:UIControlStateNormal];
                }
                allEEids=@"";
                allEEids=listOfEquiSpecials;
              
            }    
            else  if([selectedPopupName isEqualToString:UniteMeasurePopUpTitle])
            {
            }  
        }];
    }
    [self addOverlay];
    [self.view endEditing:YES];
    return listviewname;
}

#pragma mark - popup view delegates
-(CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
    
}
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try {
        
        if([selectedPopupName isEqualToString:EquipmentListPopUpTitle])
        {
            return arrEuipmentList.count;
        }
        else if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
        {
            return arrEspecialEuipmentlist.count;
        }
        else if([selectedPopupName isEqualToString:UniteMeasurePopUpTitle])
        {
            return arrMesurement.count;
        }
        else
        {
            return arrvisiblity.count;
        }
    }
    @catch (NSException *exception) {
        
    }
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        static NSString *customTableIdentifier = @"CellListWithCheckBox";
        
        CellListWithCheckBox *cell = (CellListWithCheckBox *)[tableView dequeueReusablePopoverCellWithIdentifier:customTableIdentifier];
        
        if (nil == cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellListWithCheckBox" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.vwCheckboxsubtext.hidden=YES;
        cell.lblsubtext.text=@"";
        [cell.lblsubtext sizeToFit];
        cell.btnCellClick.userInteractionEnabled=NO;
        if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
        {
            if ([especialequiSelected containsObject:indexPath])
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
            SubEquiEspecial *objse=[arrEspecialEuipmentlist objectAtIndex:indexPath.row];
            cell.lblListName.text=objse.esName;
        }
        else if([selectedPopupName isEqualToString:VisibilityTitle])
        {
            if([visibilityvalue intValue] == indexPath.row)
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
            
            cell.lblListName.text=[arrvisiblity objectAtIndex:indexPath.row];
        }
        else if([selectedPopupName isEqualToString:UniteMeasurePopUpTitle])
        {
            if([measureUnit intValue] == indexPath.row)
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
            
            cell.lblListName.text=[arrMesurement objectAtIndex:indexPath.row];
        }

        else if([selectedPopupName isEqualToString:EquipmentListPopUpTitle])
        {
            if ([equipmentselected containsObject:indexPath])
            {
                [cell.btnCheckbox setImage:imgNamed(imgTrueCorrectIcon) forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor orangeColor];
                cell.btnCheckbox.layer.borderWidth=0.0f;
            }
            else
            {
                [cell.btnCheckbox setImage:nil forState:UIControlStateNormal];
                cell.btnCheckbox.backgroundColor=[UIColor whiteColor];
                cell.btnCheckbox.layer.borderWidth=1.0f;
            }
            EquiEspecial *obje=[arrEuipmentList objectAtIndex:indexPath.row];
            cell.lblListName.text=obje.eName;
        }
        return cell;
    }
    @catch (NSException *exception) {
        
    }
    
}
- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedPopupName isEqualToString:EquipmentListPopUpTitle])
    {
        if ([equipmentselected containsObject:indexPath])
        {
            [equipmentselected removeObject:indexPath];
        }
        else
        {
            [equipmentselected removeAllObjects];
            [equipmentselected addObject:indexPath];
        }
    }
    else if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
    {
        if ([especialequiSelected containsObject:indexPath])
        {
            [especialequiSelected removeObject:indexPath];
        }
        else
        {
            [especialequiSelected addObject:indexPath];
        }
    }
    
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([selectedPopupName isEqualToString:EquipmentListPopUpTitle])
    {
        if ([equipmentselected containsObject:indexPath])
        {
            [equipmentselected removeObject:indexPath];
        }
        else
        {
            [equipmentselected removeAllObjects];
            [equipmentselected addObject:indexPath];
        }      
    }
    else if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
    {
        if ([especialequiSelected containsObject:indexPath])
        {
            [especialequiSelected removeObject:indexPath];
        }
        else
        {
            [especialequiSelected addObject:indexPath];
        }      
    }
    else if([selectedPopupName isEqualToString:VisibilityTitle])
    {
        visibilityvalue=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
         [tblHeadervw.btnLoadPostVisibility setTitle:[arrvisiblity objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [listView dismiss];
        [overlayview removeFromSuperview];
    }
    else if([selectedPopupName isEqualToString:UniteMeasurePopUpTitle])
    {
        measureUnit=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [tblHeadervw.btnUnitMeasure setTitle:[arrMesurement objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [listView dismiss];
        [overlayview removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBackClickAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
    
}
@end
