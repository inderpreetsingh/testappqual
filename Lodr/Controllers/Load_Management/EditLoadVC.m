//
//  EditLoadVC.m
//  Lodr
//
//  Created by Payal Umraliya on 18/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "EditLoadVC.h"
#import "Medialist.h"
#import "CoreDataAdaptor.h"
#import "WebContentVC.h"
#import "Function.h"
@interface EditLoadVC ()
{
    BOOL isMatched;
    CellPostLoadFooter *tblfootervw;
    CellPostLoadHeader *tblHeadervw;
    UIView *overlay,*overlayview;
    ZSYPopoverListView *listView;
    NSString *pickUpDate,*deliveryDate,*sv_pickupDate,*sv_deliveryDate;
    
    NSString *selectedPopupName,*selectedPickupAddress,*selectedPickupcitystate,*listOfEquis,*listOfEquiSpecials,*selectedDelievryAddress,*selectedDelieverycitystate,*allEids,*allEEids,*pickupcity,*pickupstate,*pickupcountry,*pickuplat,*pickuplon,*delievrycity,*delieverystate,*delievrycountry,*delievrylat,*delievrylon,*visibilityvalue,*equinames,*equiespecialnames,*deletedimageid,*trailerIds,*measureUnit;
    
    NSMutableArray *arrEuipmentList,*arrEspecialEuipmentlist,*equipmentselected,*especialequiSelected,*arrLoadImages,*arrboolSelectionImages,*arrvisibilitySelected,*arrImageIds,*arrDocIds,*arrLoaddocs,*arrAllSubEquipments;
    
    SPGooglePlacesAutocompleteViewController *googlePlacesVC;
    CQMFloatingController *floatingController;
    
    NSDateFormatter *dateFormatter;
    NSArray *arrvisiblity,*arrmeasurement;
    UIActivityIndicatorView *indicator;
    
    NSString *medianame;
    BOOL containDOcument;
}
@end

@implementation EditLoadVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    NavigationBarHidden(YES);
//    pickUpDate = _editLoadDetail.pickupDate;
//
//    deliveryDate = _editLoadDetail.delieveryDate;
   
 //   Matches *objMatches = [_editLoadDetail.matches objectAtIndex:0];
//    NSString *strLoadDispatched = @"0";
//
//    if(objMatches.matchOrderStatus.integerValue >= 2){
//        strLoadDispatched = @"1";
//
//    }
    
    if(_editLoadDetail.loadStatus.integerValue >  0){
          isMatched = true;
        
    }
    else{
     
        for (Matches *objMatches in _editLoadDetail.matches){
            NSLog(@"MATCH ORDER STATUS ===> %@",objMatches.matchOrderStatus);

            if(objMatches.matchOrderStatus.integerValue >= 2){
                isMatched = true;
                break;
            }
        }
    }
    NSLog(@"You got: %@", (isMatched ? @"YES" : @"NO"));
  
    
//    NSLog(@"%ld",_editLoadDetail.matches.count);

    sv_pickupDate = [NSString stringWithFormat:@"%@ %@",[GlobalFunction stringDate:_editLoadDetail.pickupDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd"],_editLoadDetail.pickupTime];
    
    sv_deliveryDate = [NSString stringWithFormat:@"%@ %@",[GlobalFunction stringDate:_editLoadDetail.delieveryDate fromFormat:@"YYYY-MM-dd" toFormat:@"YYYY-MM-dd"],_editLoadDetail.deliveryTime];
    
    pickUpDate = [NSString stringWithFormat:@"%@, %@",[GlobalFunction stringDate:_editLoadDetail.pickupDate fromFormat:@"YYYY-MM-dd" toFormat:@"MMM dd, YYYY"],_editLoadDetail.pickupTime];
    
    deliveryDate = [NSString stringWithFormat:@"%@, %@",[GlobalFunction stringDate:_editLoadDetail.delieveryDate fromFormat:@"YYYY-MM-dd" toFormat:@"MMM dd, YYYY"],_editLoadDetail.deliveryTime];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];  
    [self.view addGestureRecognizer:tap];
    deletedimageid=@"0";
    self.tblEditLIst.rowHeight = UITableViewAutomaticDimension;
    [self registerCustomNibsAndNotifications];
      
    [AppInstance.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
#pragma mark - tableview delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return 1; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return arrLoaddocs.count+2; // 1 for collection view photoes cell and second one is for add photo button
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tblHeadervw==nil)
    {
        tblHeadervw=[[CellPostLoadHeader alloc] initWithFrame:CGRectMake(0, 0, self.tblEditLIst.frame.size.width, 1215)];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostLoadHeader" owner:self options:nil];
        tblHeadervw = (CellPostLoadHeader *)[nib objectAtIndex:0]; 
    }
    
    [tblHeadervw.txtLoadNumber setUserInteractionEnabled:FALSE];
    [tblHeadervw.txtLoadNumber setBackgroundColor:[UIColor lightGrayColor]];
    
    if(isMatched){
        
        [tblHeadervw.txtloadname setBackgroundColor:[UIColor whiteColor]];   //YES
        [tblHeadervw.txtbolpod setBackgroundColor:[UIColor lightGrayColor]];
        
        [tblHeadervw.txtPostLoadvwLoadDesc setBackgroundColor:[UIColor whiteColor]];
        
        [tblHeadervw.txtquantity setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.btnUnitMeasure setBackgroundColor:[UIColor lightGrayColor]];
        
        [tblHeadervw.txtPostLoadLength setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.txtPostLoadWidth setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.txtPostLoadWeight setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.txtPostLoadHeight setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.txtPostLoadOfferrate setBackgroundColor:[UIColor lightGrayColor]];
        
        [tblHeadervw.btnLoadPostIsBestOffer setBackgroundColor:[UIColor lightGrayColor]];
        
        
        [tblHeadervw.btnLoadPostPickupcityState setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.btnLoadPostPickupCityStateMapPin setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.btnLoadPostPickUpTime setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.btnLoadPostPickUpAddress setBackgroundColor:[UIColor lightGrayColor]];
        [tblHeadervw.btnLoadPostPickupAddressMap setBackgroundColor:[UIColor lightGrayColor]];
        
        [tblHeadervw.btnLoadPostDelievrycityState setBackgroundColor:[UIColor whiteColor]];
        [tblHeadervw.btnLoadPostDelievryCityStateMappin setBackgroundColor:[UIColor whiteColor]];
        [tblHeadervw.btnLoadPostDelievryTime setBackgroundColor:[UIColor whiteColor]];
        [tblHeadervw.btnLoadPostDelieveryAddress setBackgroundColor:[UIColor whiteColor]];
        [tblHeadervw.btnLoadPostDelieveryAddressMap setBackgroundColor:[UIColor whiteColor]];
        [tblHeadervw.btnLoadPostDelieveryAddressMap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
//      [tblHeadervw.btnLoadPostVisibility setBackgroundColor:[UIColor lightGrayColor]];
//      [tblHeadervw.btnLoadPostAllowComment setBackgroundColor:[UIColor lightGrayColor]];
    
        [tblHeadervw.txtloadname setUserInteractionEnabled:true];   //YES
        [tblHeadervw.txtbolpod setUserInteractionEnabled:FALSE];

        [tblHeadervw.txtPostLoadvwLoadDesc setUserInteractionEnabled:TRUE];

        [tblHeadervw.txtquantity setUserInteractionEnabled:FALSE];
        [tblHeadervw.btnUnitMeasure setUserInteractionEnabled:FALSE];

        [tblHeadervw.txtPostLoadLength setUserInteractionEnabled:FALSE];
        [tblHeadervw.txtPostLoadWidth setUserInteractionEnabled:FALSE];
        [tblHeadervw.txtPostLoadWeight setUserInteractionEnabled:FALSE];
        [tblHeadervw.txtPostLoadHeight setUserInteractionEnabled:FALSE];
        [tblHeadervw.txtPostLoadOfferrate setUserInteractionEnabled:FALSE];
        
        [tblHeadervw.btnLoadPostIsBestOffer setUserInteractionEnabled:FALSE];
       
        [tblHeadervw.btnLoadPostPickupcityState setUserInteractionEnabled:FALSE];
        [tblHeadervw.btnLoadPostPickupCityStateMapPin setUserInteractionEnabled:FALSE];
        [tblHeadervw.btnLoadPostPickUpTime setUserInteractionEnabled:FALSE];
        [tblHeadervw.btnLoadPostPickUpAddress setUserInteractionEnabled:FALSE];
        [tblHeadervw.btnLoadPostPickupAddressMap setUserInteractionEnabled:FALSE];
     
        [tblHeadervw.btnLoadPostDelievrycityState setUserInteractionEnabled:TRUE];
        [tblHeadervw.btnLoadPostDelievryCityStateMappin setUserInteractionEnabled:TRUE];
        [tblHeadervw.btnLoadPostDelievryTime setUserInteractionEnabled:TRUE];
        [tblHeadervw.btnLoadPostDelieveryAddress setUserInteractionEnabled:TRUE];
        [tblHeadervw.btnLoadPostDelieveryAddressMap setUserInteractionEnabled:TRUE];
        
        [tblHeadervw.btnLoadPostDelievryCityStateMappin setTintColor:[UIColor blackColor]];
//      [tblHeadervw.btnLoadPostDelievryCityStateMappin setTitle:@"1234" forState:UIControlStateNormal];
        
        [tblHeadervw.btnLoadPostVisibility setUserInteractionEnabled:FALSE];
        [tblHeadervw.btnLoadPostAllowComment setUserInteractionEnabled:FALSE];
       
    }
    else{
//        [tblHeadervw.txtLoadNumber setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.txtloadname setBackgroundColor:[UIColor whiteColor]];   //YES
//        [tblHeadervw.txtbolpod setBackgroundColor:[UIColor whiteColor]];
//
//        [tblHeadervw.txtPostLoadvwLoadDesc setBackgroundColor:[UIColor whiteColor]];
//
//        [tblHeadervw.txtquantity setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnUnitMeasure setBackgroundColor:[UIColor whiteColor]];
//
//        [tblHeadervw.txtPostLoadLength setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.txtPostLoadWidth setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.txtPostLoadWeight setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.txtPostLoadHeight setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.txtPostLoadOfferrate setBackgroundColor:[UIColor whiteColor]];
//
//        [tblHeadervw.btnLoadPostIsBestOffer setBackgroundColor:[UIColor whiteColor]];

//        [tblHeadervw.btnLoadPostPickupcityState setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostPickupCityStateMapPin setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostPickUpTime setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostPickUpAddress setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostPickupAddressMap setBackgroundColor:[UIColor whiteColor]];
//
//        [tblHeadervw.btnLoadPostDelievrycityState setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostDelievryCityStateMappin setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostDelievryTime setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostDelieveryAddress setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostDelieveryAddressMap setBackgroundColor:[UIColor whiteColor]];
//
//        [tblHeadervw.btnLoadPostVisibility setBackgroundColor:[UIColor whiteColor]];
//        [tblHeadervw.btnLoadPostAllowComment setBackgroundColor:[UIColor whiteColor]];
//
//        [tblHeadervw.txtLoadNumber setUserInteractionEnabled:FALSE];
//        [tblHeadervw.txtloadname setUserInteractionEnabled:FALSE];   //YES
//        [tblHeadervw.txtbolpod setUserInteractionEnabled:FALSE];
//
//        [tblHeadervw.txtPostLoadvwLoadDesc setUserInteractionEnabled:TRUE];
//
//        [tblHeadervw.txtquantity setUserInteractionEnabled:FALSE];
//        [tblHeadervw.btnUnitMeasure setUserInteractionEnabled:FALSE];
//
//        [tblHeadervw.txtPostLoadLength setUserInteractionEnabled:FALSE];
//        [tblHeadervw.txtPostLoadWidth setUserInteractionEnabled:FALSE];
//        [tblHeadervw.txtPostLoadWeight setUserInteractionEnabled:FALSE];
//        [tblHeadervw.txtPostLoadHeight setUserInteractionEnabled:FALSE];
//        [tblHeadervw.txtPostLoadOfferrate setUserInteractionEnabled:FALSE];
//
//        [tblHeadervw.btnLoadPostIsBestOffer setUserInteractionEnabled:FALSE];
//
//        [tblHeadervw.btnLoadPostPickupcityState setUserInteractionEnabled:FALSE];
//        [tblHeadervw.btnLoadPostPickupCityStateMapPin setUserInteractionEnabled:FALSE];
//        [tblHeadervw.btnLoadPostPickUpTime setUserInteractionEnabled:FALSE];
//        [tblHeadervw.btnLoadPostPickUpAddress setUserInteractionEnabled:FALSE];
//        [tblHeadervw.btnLoadPostPickupAddressMap setUserInteractionEnabled:FALSE];
//
//        [tblHeadervw.btnLoadPostDelievrycityState setUserInteractionEnabled:TRUE];
//        [tblHeadervw.btnLoadPostDelievryCityStateMappin setUserInteractionEnabled:TRUE];
//        [tblHeadervw.btnLoadPostDelievryTime setUserInteractionEnabled:TRUE];
//        [tblHeadervw.btnLoadPostDelieveryAddress setUserInteractionEnabled:TRUE];
//        [tblHeadervw.btnLoadPostDelieveryAddressMap setUserInteractionEnabled:TRUE];
//
//        [tblHeadervw.btnLoadPostVisibility setUserInteractionEnabled:FALSE];
//        [tblHeadervw.btnLoadPostAllowComment setUserInteractionEnabled:FALSE];
        
    }
    tblHeadervw.cellPostLoadHeaderDelegate=self;
    tblHeadervw.btnLoadPostOpenSaved.hidden=YES;
    tblHeadervw.heightVwHeader.constant=80;
    
    tblHeadervw.txtPostLoadWidth.delegate=self;
    tblHeadervw.txtPostLoadHeight.delegate=self;
    tblHeadervw.txtPostLoadWeight.delegate=self;
    tblHeadervw.txtPostLoadLength.delegate=self;
    tblHeadervw.txtPostLoadOfferrate.delegate=self;
    tblHeadervw.txtPostLoadWidth.tag=102;
    tblHeadervw.txtPostLoadHeight.tag=104;
    tblHeadervw.txtPostLoadWeight.tag=103;
    tblHeadervw.txtPostLoadLength.tag=101;
    tblHeadervw.txtPostLoadOfferrate.tag=105;
    tblHeadervw.txtPostLoadvwLoadDesc.tag=1000;
   
        if([_editLoadDetail.isBestoffer isEqualToString:@"0"])
        {
            [tblHeadervw.btnLoadPostIsBestOffer setImage:imgNamed(iconCheckboxSquare)  forState:UIControlStateNormal];
            tblHeadervw.btnLoadPostIsBestOffer.accessibilityLabel=[NSString stringWithFormat:@"0"];
        }
        else
        {
            [tblHeadervw.btnLoadPostIsBestOffer setImage:imgNamed(iconCheckboxSquareSelectedwhitebg) forState:UIControlStateNormal];
            tblHeadervw.btnLoadPostIsBestOffer.accessibilityLabel=[NSString stringWithFormat:@"1"];
        }
        if([_editLoadDetail.isAllowComment isEqualToString:@"0"])
        {
            [tblHeadervw.btnLoadPostAllowComment setImage:imgNamed(iconCheckboxSquare)  forState:UIControlStateNormal];
            tblHeadervw.btnLoadPostAllowComment.accessibilityLabel=[NSString stringWithFormat:@"0"];
        }
        else
        {
            [tblHeadervw.btnLoadPostAllowComment setImage:imgNamed(iconCheckboxSquareSelectedwhitebg) forState:UIControlStateNormal];
           tblHeadervw.btnLoadPostAllowComment.accessibilityLabel=[NSString stringWithFormat:@"1"];
        }
      
        tblHeadervw.lblPostLoadHeading.text=@"Update Load";
        tblHeadervw.txtPostLoadvwLoadDesc.text=_editLoadDetail.loadDescription;
        tblHeadervw.txtPostLoadWidth.text=_editLoadDetail.loadWidth;
        tblHeadervw.txtPostLoadHeight.text=_editLoadDetail.loadHeight;
        tblHeadervw.txtPostLoadLength.text=_editLoadDetail.loadLength;
        tblHeadervw.txtPostLoadWeight.text=_editLoadDetail.loadWeight;
        tblHeadervw.txtPostLoadOfferrate.text=_editLoadDetail.offerRate;
        tblHeadervw.txtloadname.text=_editLoadDetail.loadName;
        tblHeadervw.txtbolpod.text=_editLoadDetail.bolPod;
        tblHeadervw.txtLoadNumber.text = _editLoadDetail.loadNumber;
        [tblHeadervw.btnLoadPostPickUpAddress setTitle:_editLoadDetail.pickupAddress forState:UIControlStateNormal];
        [tblHeadervw.btnLoadPostDelieveryAddress setTitle:_editLoadDetail.deliveryAddress forState:UIControlStateNormal];
    
        [tblHeadervw.btnLoadPostPickUpTime setTitle:pickUpDate forState:UIControlStateNormal];
    
        [tblHeadervw.btnLoadPostDelievryTime setTitle:deliveryDate forState:UIControlStateNormal];
    
        [tblHeadervw.btnLoadPostPickupcityState setTitle:[NSString stringWithFormat:@"%@, %@",_editLoadDetail.pickupCity,_editLoadDetail.pickupState] forState:UIControlStateNormal];
    
        [tblHeadervw.btnLoadPostDelievrycityState setTitle:[NSString stringWithFormat:@"%@, %@",_editLoadDetail.deliveryCity,_editLoadDetail.deliveryState] forState:UIControlStateNormal];
        
        [tblHeadervw.btnLoadPostEquipmentList setTitle:equinames forState:UIControlStateNormal];
    
        [tblHeadervw.btnLoadPostAddEspecialEqui setTitle:equiespecialnames forState:UIControlStateNormal];
      
        if([_editLoadDetail.visiableTo isEqualToString:@"1"])
        {
            [tblHeadervw.btnLoadPostVisibility setTitle:@"My Network" forState:UIControlStateNormal];
        }
        else if([_editLoadDetail.visiableTo isEqualToString:@"2"])
        {
            [tblHeadervw.btnLoadPostVisibility setTitle:@"Everyone" forState:UIControlStateNormal];
        }
        else
        {
            [tblHeadervw.btnLoadPostVisibility setTitle:@"Private" forState:UIControlStateNormal];
        }
        if([_editLoadDetail.measureUnit isEqualToString:@"3"])
        {
            [tblHeadervw.btnUnitMeasure setTitle:@"US Bushels" forState:UIControlStateNormal];
        }
        else if([_editLoadDetail.measureUnit isEqualToString:@"1"])
        {
            [tblHeadervw.btnUnitMeasure setTitle:@"US Gallons" forState:UIControlStateNormal];
        }
        else if([_editLoadDetail.measureUnit isEqualToString:@"2"])
        {
            [tblHeadervw.btnUnitMeasure setTitle:@"US Tons" forState:UIControlStateNormal];
        }
        else
        {
            [tblHeadervw.btnUnitMeasure setTitle:@"Items" forState:UIControlStateNormal];
        }
    return tblHeadervw;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    tblfootervw=[[CellPostLoadFooter alloc] initWithFrame:CGRectMake(0, 0, self.tblEditLIst.frame.size.width, 190)];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostLoadFooter" owner:self options:nil];
    tblfootervw = (CellPostLoadFooter *)[nib objectAtIndex:0]; 
    tblfootervw.btnSaveLoad.hidden=YES;
    tblfootervw.btnPublishLoad.hidden=YES;
    tblfootervw.btnloadUpdate.hidden=NO;
    tblfootervw.cellPostLoadFooterDelegate=self;
    tblfootervw.txtFooterNotes.text=_editLoadDetail.notes;
    tblfootervw.txtFooterNotes.delegate=self;
    tblfootervw.txtFooterNotes.tag=2000;
    return tblfootervw;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20,20)];
    lbl.text=equiespecialnames;
    lbl.numberOfLines=0;
    [lbl sizeToFit];
    CGFloat heigthval=lbl.frame.size.height;
    lbl=nil;
    return 1377+heigthval;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{ 
    return 190;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
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
    else if(indexPath.row==1)
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
        cell.btnPdfName.tag=indexPath.row;
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
        cell.btnPdfName.tag=indexPath.row;
         cell.btnPdfDelete.hidden=NO;
        cell.btnPdfDelete.tag=indexPath.row-2;
        [cell.btnPdfName setTitle:[arrLoaddocs objectAtIndex:indexPath.row-2] forState:UIControlStateNormal];
        [cell.btnPdfName setImage:imgNamed(@"pdfimg") forState:UIControlStateNormal];
        cell.btnPdfName.titleLabel.font =[UIFont fontWithName:@"Arial" size:12];
        cell.btnPdfDelete.accessibilityLabel=[arrDocIds objectAtIndex:indexPath.row-2];
        cell.cellPdfviewDelegate=self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1)
    {
        [self openImagePicker];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 101:
        {
            _editLoadDetail.loadLength=textField.text;
        }
        break;
        case 102:
        {
            _editLoadDetail.loadWidth=textField.text;
        }
            break;
        case 103:
        {
            _editLoadDetail.loadWeight=textField.text;
        }
            break;
        case 104:
        {
            _editLoadDetail.loadHeight=textField.text;
        }
            break;
        case 105:
        {
            _editLoadDetail.offerRate=textField.text;
        }
            break;
        default:
            break;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textField 
{
    if(textField.tag == 1000)
    {
        _editLoadDetail.loadDescription=textField.text;
    }
    else
    {
        _editLoadDetail.notes=textField.text;
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
    cell.cellCvPickedImageDelegate=self;
    if([[arrLoadImages objectAtIndex:indexPath.item] isKindOfClass:[UIImage class]])
    {
        cell.btnDeleteImage.accessibilityLabel=@"0";
        cell.imgLarge.image=[arrLoadImages objectAtIndex:indexPath.item];
        [indicator removeFromSuperview];
    }
    else
    {
        NSString *str=[NSString stringWithFormat:@"%@%@",URLThumbImage,[arrLoadImages objectAtIndex:indexPath.item]];
        NSURL *imgurl=[NSURL URLWithString:str];
        [indicator startAnimating];
        [indicator setCenter:cell.imgLarge.center];
        [cell.contentView addSubview:indicator];
        
        [cell.imgLarge sd_setImageWithURL:imgurl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(image !=nil)
            {
                cell.imgLarge.image=image;
                [indicator removeFromSuperview];
            }
            else
            {
                [indicator removeFromSuperview];
            }
        }];
        
        if([[arrLoadImages objectAtIndex:indexPath.item] containsString:@"doc"]||[[arrLoadImages objectAtIndex:indexPath.item] containsString:@"pdf"])     
        {
            cell.imgLarge.hidden=YES;
            cell.btnDeleteImage.hidden=YES;
        }
        else
        {
            cell.imgLarge.hidden=NO;
            cell.btnDeleteImage.hidden=NO;
            cell.btnDeleteImage.accessibilityLabel=[arrImageIds objectAtIndex:indexPath.item];
        }
    }
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
    if([[arrLoadImages objectAtIndex:[dltsender tag]] isKindOfClass:[NSString class]])
    {
        deletedimageid=[NSString stringWithFormat:@"%@,%@",deletedimageid,dltsender.accessibilityLabel];
        [arrImageIds removeObjectAtIndex:[dltsender tag]];
    }
   
    [arrLoadImages removeObjectAtIndex:[dltsender tag]];
    CellWithCV *cellimages = (CellWithCV*)[_tblEditLIst cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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

-(void)openImagePicker
{
    CellWithCV *cellselected=(CellWithCV*)[_tblEditLIst cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
                 for(int i = 0;i<assets.count;i++)
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
- (IBAction)btnPdfNameClicked:(id)sender 
{
    UIButton *btn=(UIButton *)sender; 
    if(btn.tag > 1)
    {
        NSString *pdfurl=[NSString stringWithFormat:@"%@%@",URLLoadImage,btn.titleLabel.text];
        WebContentVC *objweb=initVCToRedirect(SBMAIN, WEBCONTENTVC);
        objweb.webURL=pdfurl;
        [self.navigationController pushViewController:objweb animated:YES];
    }
    else
    {
         [self openImagePicker];
    }
   
}

- (IBAction)btnPdfDeleteClicked:(id)sender 
{
    UIButton *dltsender=(UIButton *)sender;
    [arrDocIds removeObjectAtIndex:[dltsender tag]];
    [arrLoaddocs removeObjectAtIndex:[dltsender tag]];
    deletedimageid=[NSString stringWithFormat:@"%@,%@",deletedimageid,dltsender.accessibilityLabel];
    [self.tblEditLIst reloadData];
}
#pragma mark - Cell HEADER delegate
- (IBAction)btnLoadPostEquiListClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:EquipmentListPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
    [listView show];
}
- (IBAction)btnLoadPostAddEspecialEquiClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:EspecialEquiPopUpTitle widthval:SCREEN_WIDTH - 100 heightval:SCREEN_HEIGHT-100];
    [listView show];
}
- (IBAction)btnUnitMeasureclicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:UniteMeasurePopUpTitle widthval:SCREEN_WIDTH - 100 heightval:320];
    [listView show];
}

- (IBAction)btnLoadPostOpenSavedClicked:(id)sender
{
    //AllSavedLoadListVC *objsavedlist=initVCToRedirect(SBAFTERSIGNUP, ALLSAVEDLOADLIST);
    //[self.navigationController pushViewController:objsavedlist animated:YES];
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
        senderbtn.accessibilityLabel=[NSString stringWithFormat:@"1"];
    }
    _editLoadDetail.isBestoffer=senderbtn.accessibilityLabel;
    senderbtn.selected = ![senderbtn isSelected];
}

- (IBAction)btnLoadPostPickupcityStateClicked:(id)sender
{
      [self showMapViewPopUp:@"EDITPICKUP"];
}

- (IBAction)btnLoadPostPickupMapPinClicked:(id)sender
{
     [self showMapViewPopUp:@"EDITPICKUP"];
}

- (IBAction)btnLoadPostPickUpTimeClicked:(id)sender
{
    //UIView *headerView=[_tblEditLIst headerViewForSection:0];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MMM dd, YYYY, hh:mm a"];
    
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
//                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
//                                [tblHeadervw.btnLoadPostPickUpTime setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                              
                                
                                sv_pickupDate = [DateFormats getDateStringValueFromDate:picker.date];
                                
                                NSLog(@"%@",sv_pickupDate);
                                
                                NSString *dateString = [df stringFromDate:picker.date];
                                
                                pickUpDate = dateString;
                                NSLog(@"NEW PICKUP DATE == > %@",pickUpDate);
                                
                                [tblHeadervw.btnLoadPostPickUpTime setTitle:pickUpDate forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}

- (IBAction)btnLoadPostPickUpAddressClicked:(id)sender
{
     [self showMapViewPopUp:@"EDITPICKUP"];
}

- (IBAction)btnLoadPostDelievrycityStateClicked:(id)sender
{
       [self showMapViewPopUp:@"EDITDELIEVERY"];
}

- (IBAction)btnLoadPostDelievryTimeClicked:(id)sender
{
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MMM dd, YYYY, hh:mm a"];
    
    [picker setDatePickerMode:UIDatePickerModeDateAndTime];
    picker.timeZone = [NSTimeZone localTimeZone];
    picker.calendar = [NSCalendar currentCalendar];
    [picker setMinimumDate: [NSDate date]];
  
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Delivery Time\n\n\n\n\n\n\n\n\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet.view addSubview:picker];
    
    picker.frame=CGRectMake(actionSheet.view.frame.origin.x+5, actionSheet.view.frame.origin.y+5, actionSheet.view.frame.size.width-10, 300);
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
//                                NSString *dateString = [dateFormatter stringFromDate:picker.date];
//                                [tblHeadervw.btnLoadPostDelievryTime setTitle:dateString forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                
                                sv_deliveryDate = [DateFormats getDateStringValueFromDate:picker.date];
                                
                                NSString *dateString = [df stringFromDate:picker.date];
                                deliveryDate = dateString;
                                
                                [tblHeadervw.btnLoadPostDelievryTime setTitle:deliveryDate forState:UIControlStateNormal];
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}

- (IBAction)btnLoadPostDelievryCityStateMapPinClicked:(id)sender
{
       [self showMapViewPopUp:@"EDITDELIEVERY"];
}

- (IBAction)btnLoadPostPickupAddressMapClicked:(id)sender
{
     [self showMapViewPopUp:@"EDITPICKUP"];
}

- (IBAction)btnLoadPostDelieveryAddressClicked:(id)sender
{
       [self showMapViewPopUp:@"EDITDELIEVERY"];
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
     _editLoadDetail.isAllowComment=senderbtn.accessibilityLabel;
    senderbtn.selected = ![senderbtn isSelected];
}

- (IBAction)btnLoadPostDelieveryAddressMapClicked:(id)sender
{
       [self showMapViewPopUp:@"EDITDELIEVERY"];
}
- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnPublishLoadClicked:(id)sender 
{   
}
- (IBAction)btnSaveLoadClicekd:(id)sender 
{
}
- (IBAction)btnUpdateLoadClicked:(id)sender
{
    [self prepareRequestToUpdateOnServer:@"1"];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"On update load details all linked/interested  assets with this load will reset.You need to link it again." message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* ok = [UIAlertAction
//                         actionWithTitle:@"Update"
//                         style:UIAlertActionStyleDefault
//                         handler:^(UIAlertAction * action)
//                         {
//                             [self prepareRequestToUpdateOnServer:@"1"];
//                         }];
//    UIAlertAction* cancel = [UIAlertAction
//                             actionWithTitle:@"Cancel"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alert dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//    [alert addAction:ok];
//     [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:^{    }];
}

-(void)prepareRequestToUpdateOnServer:(NSString *)ispublish
{
    
    @try {        
        if(
           [self validateTxtLength:tblHeadervw.txtLoadNumber.text withMessage:RequiredLoadNumber] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostEquipmentList.titleLabel.text withMessage:RequiredShippingType] &&
           [self validateTxtLength:tblHeadervw.txtPostLoadvwLoadDesc.text withMessage:RequiredDescription] &&
           [self validateTxtLength:tblHeadervw.txtPostLoadWeight.text withMessage:RequiredWeight] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostPickupcityState.titleLabel.text withMessage:RequiredPickupCityState]&&
           [self validateTxtLength:tblHeadervw.btnLoadPostPickUpTime.titleLabel.text withMessage:RequiredPickupTime] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostPickUpAddress.titleLabel.text withMessage:RequiredPickupAddress] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostDelievrycityState.titleLabel.text withMessage:RequiredDelieveryCityState] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostDelievryTime.titleLabel.text withMessage:RequiredDelieveryTime] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostDelieveryAddress.titleLabel.text withMessage:RequiredDelieveryAddress] &&
           [self validateTxtLength:tblHeadervw.btnLoadPostVisibility.titleLabel.text withMessage:RequiredViewableTo]
           )
        {
            for(int i=0;i<arrLoadImages.count;i++)
           {
               if([[arrLoadImages objectAtIndex:i] isKindOfClass:[NSString class]])
               {
                   [arrLoadImages removeObjectAtIndex:i];
               }
           }
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
            if(arrLoaddocs.count == 0)
            {
                [arrLoaddocs addObject:@""];
            }
            NSLog(@"%@",tblHeadervw.btnLoadPostPickUpTime.titleLabel.text);
            NSLog(@"%@",tblHeadervw.btnLoadPostDelievryTime.titleLabel.text);
           
            NSDate *timeStampPickup = [DateFormats getTimestampFromGivenDate:sv_pickupDate];
            NSLog(@"%@",timeStampPickup);
            
            NSDate *timeStampDelivery = [DateFormats getTimestampFromGivenDate:sv_deliveryDate];
            NSLog(@"%@",timeStampDelivery);
            
            NSString *pickupTimeStamp = [DateFormats getTimeStampfromDate:timeStampPickup];
            NSString *deliveryTimeStamp = [DateFormats getTimeStampfromDate:timeStampDelivery];
            
            NSLog(@"%@ %@",pickupTimeStamp,deliveryTimeStamp);
            
            if(pickupTimeStamp.doubleValue > deliveryTimeStamp.doubleValue){
                [AZNotification showNotificationWithTitle:@"Pickup date is more than delivery date" controller:self notificationType:AZNotificationTypeError];
                return;
                
                
            }
//            if([pickupDate compare:deliverDate] == NSOrderedDescending){
//
//                [AZNotification showNotificationWithTitle:@"Pickup date is more than delivery date" controller:self notificationType:AZNotificationTypeError];
//                return;
//
//            }
            
//            NSString *strDiff = [DateFormats getStringTimeFromStringUTC:strPickupDate DeliveryDate:strDeliveryDate];
//
//            NSLog(@"strDiff == > %@",strDiff);
            
//            if(day > 0){
//
//                [AZNotification showNotificationWithTitle:@"Pickup date is more than delivery date" controller:self notificationType:AZNotificationTypeError];
//
//                return;
//
//            }
            
//            NSString *strLoadDispatched = @"1";
//            if(_editLoadDetail.matches.count > 0){
//
//                Matches *objMatches = [_editLoadDetail.matches objectAtIndex:0];
//                NSString *strLoadDispatched = @"1";
//
//                if(objMatches.matchOrderStatus.integerValue >= 2){
//                    strLoadDispatched = @"0";
//
//                }
//            }

            
            NSString *strLoadDispatched = @"1";
            if(isMatched){
                    strLoadDispatched = @"0";
            }
            

            //if([[_editLoadDetail.matches objectAtIndex:0]])
            NSDictionary *dicupdateLoad=@{
                                        Req_Load_Number:tblHeadervw.txtLoadNumber.text,
                                        Req_access_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedAccessKey],
                                        Req_secret_key:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedSecretKey],
                                        Req_E_Id:allEids,
                                        Req_Es_Id:allEEids,
                                        Req_identifier:_editLoadDetail.internalBaseClassIdentifier,
                                        Req_User_Id:[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId],
                                        Req_Load_Description:tblHeadervw.txtPostLoadvwLoadDesc.text,
                                        Req_Load_Width:tblHeadervw.txtPostLoadWidth.text.length>0 ? tblHeadervw.txtPostLoadWidth.text :_editLoadDetail.loadWidth,
                                        Req_Load_Height:tblHeadervw.txtPostLoadHeight.text.length>0 ? tblHeadervw.txtPostLoadHeight.text :_editLoadDetail.loadHeight,
                                        Req_Load_Length:tblHeadervw.txtPostLoadLength.text.length>0 ? tblHeadervw.txtPostLoadLength.text :_editLoadDetail.loadLength,
                                        Req_Load_Weight:tblHeadervw.txtPostLoadWeight.text,
                                        Req_Offer_Rate :tblHeadervw.txtPostLoadOfferrate.text,
                                        Req_Is_Best_Offer:tblHeadervw.btnLoadPostIsBestOffer.accessibilityLabel,
                                        Req_Pickup_Address :tblHeadervw.btnLoadPostPickUpAddress.titleLabel.text,
                                        Req_Pickup_Time:tblHeadervw.btnLoadPostPickUpTime.titleLabel.text,
                                        Req_Delivery_Address:tblHeadervw.btnLoadPostDelieveryAddress.titleLabel.text,
                                        Req_Delivery_Time:tblHeadervw.btnLoadPostDelievryTime.titleLabel.text,
                                        Req_Is_Allow_Comment :tblHeadervw.btnLoadPostAllowComment.accessibilityLabel,
                                        Req_Notes:tblfootervw.txtFooterNotes.text,
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
                                        Req_Is_Publish:_editLoadDetail.isPublish,
                                        Req_Deleted_img_ids:deletedimageid,
                                        Req_Load_Photo1:[arrLoadImages objectAtIndex:0],
                                        Req_Load_Photo2:[arrLoadImages objectAtIndex:1],
                                        Req_Load_Photo3:[arrLoadImages objectAtIndex:2],
                                        Req_Load_Photo4:[arrLoadImages objectAtIndex:3],
                                        Req_Load_Photo5:[arrLoadImages objectAtIndex:4],
                                        Req_Load_Video:@"",
                                        Req_Load_Doc:[arrLoaddocs objectAtIndex:0],
                                        Req_LoadName: tblHeadervw.txtloadname.text.length>0? tblHeadervw.txtloadname.text:@"",
                                        Req_Qty: tblHeadervw.txtquantity.text.length>0? tblHeadervw.txtquantity.text:@"1",
                                        Req_UnitMeasure: measureUnit.length>0? measureUnit:@"0",
                                        Req_BolPod: tblHeadervw.txtbolpod.text.length>0? tblHeadervw.txtbolpod.text:@"",
                                        Req_is_Load_Dispatched : strLoadDispatched
                                        };
            
            NSLog(@"DIC UPDATE LOAD ===> %@",dicupdateLoad);
            NSLog(@"URL ==> %@",URLUpdateLoadDetails);
                        
            if([[NetworkAvailability instance]isReachable])
            {
                [[WebServiceConnector alloc]
                 init:URLUpdateLoadDetails
                 withParameters:dicupdateLoad
                 withObject:self
                 withSelector:@selector(getUpdateLoadResponse:)
                 forServiceType:@"FORMDATA"
                 showDisplayMsg:@"Updating Load"
                 showProgress:YES];
            }
            else
            {
                [self dismissHUD];
                [AZNotification showNotificationWithTitle:NetworkLost controller:ROOTVIEW notificationType:AZNotificationTypeError];
            }
        }
        
    } @catch (NSException *exception) {
   
        NSLog(@"EXCEOPTION UPLOADING LOAD");
        
    }  
}

-(IBAction)getUpdateLoadResponse:(id)sender
{
    [self dismissHUD];
    if ([sender serviceResponseCode] != 100)
    {
        [AZNotification showNotificationWithTitle:[sender responseError] controller:ROOTVIEW notificationType:AZNotificationTypeError];
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
-(void)initializearrays
{
    arrLoadImages=[NSMutableArray new];
    arrLoaddocs=[NSMutableArray new];
    equipmentselected=[NSMutableArray new];
    especialequiSelected=[NSMutableArray new];
    arrEuipmentList=[NSMutableArray new];
    arrEspecialEuipmentlist=[NSMutableArray new];
    arrvisibilitySelected=[NSMutableArray new];
    arrImageIds=[NSMutableArray new];
    arrDocIds=[NSMutableArray new];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self initAllValues];
    
}
-(void)initAllValues
{
    @try 
    {
    arrEuipmentList =[[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:EquiEspecialEntity]mutableCopy];
//    arrEspecialEuipmentlist=[[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:SubEquiEspecialEntity]mutableCopy];
    arrAllSubEquipments=[NSMutableArray new];
    arrAllSubEquipments=[[CoreDataAdaptor fetchAllDataWhere:nil fromEntity:SubEquiEspecialEntity]mutableCopy];

    NSString *pattern = [NSString stringWithFormat:@"(^|.*,)%@(,.*|$)",
                         [NSRegularExpression escapedPatternForString:_editLoadDetail.eId]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentId MATCHES %@", pattern];
    
    arrEspecialEuipmentlist = [[NSMutableArray alloc]initWithArray:[arrAllSubEquipments filteredArrayUsingPredicate:predicate]];
    arrvisiblity=[[NSArray alloc]initWithObjects:@"Private",@"My Network",@"Everyone", nil];
         arrmeasurement=[[NSArray alloc]initWithObjects:@"Items",@"US Gallons",@"US Tons",@"US Bushels",nil];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.color=[UIColor whiteColor];
    
    for(Medialist *mda in _editLoadDetail.medialist)
    {
        if([mda.mediaName containsString:@"doc"] || [mda.mediaName containsString:@"pdf"])
        {
            containDOcument=YES;
            medianame=mda.mediaName;
            [arrLoaddocs addObject:mda.mediaName];
            [arrDocIds addObject:mda.medialistIdentifier];
        }
        else
        {
            [arrLoadImages addObject:mda.mediaName];
            [arrImageIds addObject:mda.medialistIdentifier];
        }
    }
    pickuplat=_editLoadDetail.pickupLatitude;
    pickuplon=_editLoadDetail.pickupLongitude;
    delievrylat=_editLoadDetail.deliveryLatitude;
    delievrylon=_editLoadDetail.deliveryLongitude;
    pickupcity=_editLoadDetail.pickupCity;
    pickupstate=_editLoadDetail.pickupState;
    pickupcountry=_editLoadDetail.pickupCountry;
    selectedPickupAddress=_editLoadDetail.pickupAddress;
    selectedDelievryAddress=_editLoadDetail.deliveryAddress;
    delievrycity=_editLoadDetail.deliveryCity;
    delieverystate=_editLoadDetail.deliveryState;
    allEids=_editLoadDetail.eId;
    allEEids=_editLoadDetail.esId;
    visibilityvalue=_editLoadDetail.visiableTo;
    trailerIds=_editLoadDetail.esId;
    delievrycountry=_editLoadDetail.deliveryCountry;
    NSArray *arrequi=[_editLoadDetail.eId componentsSeparatedByString:@","];
    NSArray *arrsubqui=[_editLoadDetail.esId componentsSeparatedByString:@","];
    
    for (int i=0; i<arrequi.count; i++) 
    {
        NSString *condition=[NSString stringWithFormat:@"internalBaseClassIdentifier=='%@'",[arrequi objectAtIndex:i]];
        NSMutableArray*arrMatch=[[CoreDataAdaptor fetchAllDataWhere:condition fromEntity:EquiEspecialEntity] mutableCopy];
        if(arrMatch.count >0)
        {
            EquiEspecial *obje=[arrMatch objectAtIndex:0];
            NSString *str=obje.eName;
            equinames=str;
        }
    }
    equiespecialnames=@"";
    for (int i=0; i<arrsubqui.count; i++) 
    {
        NSString *condition=[NSString stringWithFormat:@"internalBaseClassIdentifier=='%@'",[arrsubqui objectAtIndex:i]];
        NSMutableArray*arrMatch=[[CoreDataAdaptor fetchAllDataWhere:condition fromEntity:SubEquiEspecialEntity] mutableCopy];
        if(arrMatch.count >0)
        {
            SubEquiEspecial *obje=[arrMatch objectAtIndex:0];
            NSString *str=obje.esName;
            equiespecialnames=[equiespecialnames stringByAppendingString:[str stringByAppendingString:@","]];
        }
    }
    if(equiespecialnames.length>0)
    {
         equiespecialnames = [equiespecialnames substringToIndex:[equiespecialnames length]-1];
    }
    else
    {
        equiespecialnames=[equiespecialnames stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    
    } @catch (NSException *exception) {
    
    } 
}
-(void)registerCustomNibsAndNotifications
{
    UINib *nibcell = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tblEditLIst] registerNib:nibcell forCellReuseIdentifier:@"CellWithCV"];
    
    UINib *nibcell2 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tblEditLIst]  registerNib:nibcell2 forCellReuseIdentifier:@"cellPdfview"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedEditAddress object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editSelectedLocation:) name:NCNamedEditAddress object:nil];
    [self initializearrays];
}
-(void)dismissKeyboard 
{
    [self.view endEditing:YES];
}
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
-(void)editSelectedLocation:(NSNotification *)anote
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedDismissView object:nil];
  
    NSDictionary *dict = anote.userInfo;
    
    NSString *requestAddressType=[NSString stringWithFormat:@"%@",[dict objectForKey:@"AddressType"]];
    if([requestAddressType isEqualToString:@"EDITPICKUP"])
    {
        pickuplat=[dict objectForKey:@"AddressLatitude"];
        pickuplon=[dict objectForKey:@"AddressLongitude"];
        pickupcountry=[dict objectForKey:@"SelectedCountry"];
        pickupstate=[dict objectForKey:@"SelectedState"];
        pickupcity=[dict objectForKey:@"SelectedCity"];
        selectedPickupcitystate = [NSString stringWithFormat:@"%@,%@",[dict objectForKey:@"SelectedCity"],[dict objectForKey:@"SelectedState"]];
        selectedPickupAddress = [dict objectForKey:@"SelectedAddress"];
        _editLoadDetail.pickupCity=pickupcity;
        _editLoadDetail.pickupAddress=selectedPickupAddress;
        _editLoadDetail.pickupState=pickupstate;
        _editLoadDetail.pickupCountry=pickupcountry;
        _editLoadDetail.pickupLatitude=pickuplat;
        _editLoadDetail.pickupLongitude=pickuplon;
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
        _editLoadDetail.deliveryCountry=delievrycity;
        _editLoadDetail.deliveryCity=selectedDelievryAddress;
        _editLoadDetail.deliveryState=delieverystate;
        _editLoadDetail.deliveryAddress=delievrycountry;
        _editLoadDetail.deliveryLatitude=delievrylat;
        _editLoadDetail.deliveryLongitude=delievrylon;
      [tblHeadervw.btnLoadPostDelieveryAddress setTitle:selectedDelievryAddress forState:UIControlStateNormal];
      [tblHeadervw.btnLoadPostDelievrycityState setTitle:selectedDelieverycitystate forState:UIControlStateNormal];
    }
    
}

-(NSString *)gatherEquipmentIds
{
    NSString *listOfAllEqui = @"";
    EquiEspecial *objequi;
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
    SubEquiEspecial *objequi;
     equiespecialnames=@"";
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
            _editLoadDetail.visiableTo=visibilityvalue;
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
                allEids=listOfEquis;
                _editLoadDetail.eId=allEids;
               
                if(listOfEquis.length > 0)
                {
                    NSString *pattern = [NSString stringWithFormat:@"(^|.*,)%@(,.*|$)",
                                         [NSRegularExpression escapedPatternForString:listOfEquis]];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentId MATCHES %@", pattern];
                    
                    arrEspecialEuipmentlist = [[NSMutableArray alloc]initWithArray:[arrAllSubEquipments filteredArrayUsingPredicate:predicate]];
                     equiespecialnames=@"Add Trailers";
                     _editLoadDetail.esId=@"";
                    [especialequiSelected removeAllObjects];
                    
                }
                [self.tblEditLIst reloadData];
            }
            else  if([selectedPopupName isEqualToString:EspecialEquiPopUpTitle])
            {
                listOfEquiSpecials=@"";
                listOfEquiSpecials = [self gatherEquipmentEspecialIds];
                if(listOfEquiSpecials.length==0)
                {
                    equiespecialnames=@"Add Trailers";
                 
                }
                allEEids=listOfEquiSpecials;
                _editLoadDetail.esId=allEEids;
                 [self.tblEditLIst reloadData];
            }   
        }];
    }
    [self addOverlay];
    [self.view endEditing:YES];
    return listviewname;
}
- (IBAction)btnDrawerClicked:(id)sender {
     [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
#pragma mark -table view delegate datasource for popup view
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
            return arrmeasurement.count;
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
            SubEquiEspecial *objse=[arrEspecialEuipmentlist objectAtIndex:indexPath.row];
          
            cell.lblListName.text=objse.esName;
            if ([especialequiSelected containsObject:indexPath] || [_editLoadDetail.esId containsString:objse.internalBaseClassIdentifier])
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
            
            cell.lblListName.text=[arrmeasurement objectAtIndex:indexPath.row];
        }

        else if([selectedPopupName isEqualToString:EquipmentListPopUpTitle])
        {
            EquiEspecial *obje=[arrEuipmentList objectAtIndex:indexPath.row];
            cell.lblListName.text=obje.eName;
           
            if ([equipmentselected containsObject:indexPath] || [_editLoadDetail.eId containsString:obje.internalBaseClassIdentifier])
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
           
        }
        cell.lblListName.numberOfLines =2;
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
            [especialequiSelected removeAllObjects];
            _editLoadDetail.eId=@"";
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
           // [especialequiSelected removeAllObjects];
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
            _editLoadDetail.eId=@"";
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
          //  [especialequiSelected removeAllObjects];
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
        
        [tblHeadervw.btnUnitMeasure setTitle:[arrmeasurement objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [listView dismiss];
        [overlayview removeFromSuperview];
    }
}

@end
