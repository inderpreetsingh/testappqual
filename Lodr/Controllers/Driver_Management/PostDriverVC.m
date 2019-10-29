//
//  PostDriverVC.m
//  Lodr
//
//  Created by c196 on 12/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "PostDriverVC.h"
#import "CellListWithCheckBox.h"
#import "Function.h"
@interface PostDriverVC ()
{
    CellPostEquiFooter *tblfootervw;
    CellPostDriverHeader *tblHeadervw;
    NSArray *arrvisiblity;  
    NSString *visibilityvalue;
    NSMutableArray *arrProfileImage;
    ZSYPopoverListView *listView;
    UIView *overlayview;
}
@end

@implementation PostDriverVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
    NavigationBarHidden(YES);
    arrvisiblity=[[NSArray alloc]initWithObjects:@"Private",@"My Network",@"Everyone", nil];
    visibilityvalue=@"2";
    self.btnBack.hidden=YES;
    self.tblPostDriver.rowHeight = UITableViewAutomaticDimension;
    UINib *nibcell = [UINib nibWithNibName:@"CellWithCV" bundle:nil];
    [[self tblPostDriver] registerNib:nibcell forCellReuseIdentifier:@"CellWithCV"];
    UINib *nibcell2 = [UINib nibWithNibName:@"cellPdfview" bundle:nil];
    [[self tblPostDriver]  registerNib:nibcell2 forCellReuseIdentifier:@"cellPdfview"];
 
    arrProfileImage=[NSMutableArray new];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetWelcomeScreenAddress object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectedWelcomeLocation:) name:NCNamedSetWelcomeScreenAddress object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NCNamedSetWelcomeScreenAddress object:nil];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}
#pragma mark - tableview delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{ 
    return 1; 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{ 
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostDriverHeader" owner:self options:nil];
    tblHeadervw = (CellPostDriverHeader *)[nib objectAtIndex:0]; 
    tblHeadervw.btnOpenSavedDrvier.hidden=YES;
    tblHeadervw.heightVwheading.constant=80;
    tblHeadervw.cellPostDriverHeaderDelegate=self;
    [tblHeadervw.btnDriverVisiblility setTitle:[arrvisiblity objectAtIndex:[visibilityvalue intValue]] forState:UIControlStateNormal];
    return tblHeadervw;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{ 
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CellPostEquiFooter" owner:self options:nil];
    tblfootervw = (CellPostEquiFooter *)[nib objectAtIndex:0]; 
    tblfootervw.btnSaveEqui.hidden=NO;
    tblfootervw.btnPublishEqui.hidden=NO;
    tblfootervw.btnEquiUpdate.hidden=YES;
    tblfootervw.cellPostEquiFooterDelegate=self;
    return tblfootervw;
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
        cell.lblAllphoto.text=@"Profile Picture:";
        cell.lblNoData.text=@"Please click on 'Add Profile Picture' to set your profile picture";
        cell.cvPhotoes.dataSource=self;
        cell.cvPhotoes.delegate=self;
        if(arrProfileImage.count==0)
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
        [cell.btnPdfName setTitle:@"Add Profile Picture" forState:UIControlStateNormal];
        cell.btnPdfName.titleLabel.font =[UIFont fontWithName:@"Arial-BoldMT" size:15];
        [cell.btnPdfName setImage:imgNamed(@"imgplus") forState:UIControlStateNormal];
        cell.btnPdfDelete.hidden=YES;
        cell.cellPdfviewDelegate=self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 
{ 
    return 430;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{ 
    return 190;
}
#pragma mark - Collection view  delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrProfileImage.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellCvPickedImage *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellCvPickedImage" forIndexPath:indexPath];
    cell.btnDeleteImage.tag=indexPath.item;
    cell.cellCvPickedImageDelegate=self;
    cell.imgLarge.image=[arrProfileImage objectAtIndex:indexPath.item];
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
    return UIEdgeInsetsMake(0,(collectionView.frame.size.width-collectionView.frame.size.height)/2, 0, collectionView.center.y);
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
    [arrProfileImage removeObjectAtIndex:[dltsender tag]];
    CellWithCV *cellimages = (CellWithCV*)[_tblPostDriver cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if(arrProfileImage.count > 0)
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
#pragma mark - custom methods
-(void)setSelectedWelcomeLocation:(NSNotification *)anote
{
    NSDictionary *dict = anote.userInfo;
    [tblHeadervw.btnDriverAddrss setTitle:[dict objectForKey:@"SelectedAddress"] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] postNotificationName:NCNamedDismissView object:self];
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
-(ZSYPopoverListView *)showListView :(ZSYPopoverListView *)listviewname withSelectiontext :(NSString *)selectionm widthval:(CGFloat)w heightval :(CGFloat)h
{
    listviewname.backgroundColor=[UIColor whiteColor];
    listviewname = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0,0, w, h)];
    listviewname.calledFor=VisibilityTitle;
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
    [listviewname setCancelButtonTitle:@"" block:^{
    }];
    [self addOverlay];
    [self.view endEditing:YES];
    return listviewname;
}
-(void)showMapViewPopUp:(NSString *)requestName
{
    SPGooglePlacesAutocompleteViewController *googlePlacesVC = [[SPGooglePlacesAutocompleteViewController alloc] init];
    googlePlacesVC.requestMapFor=requestName;
    CQMFloatingController *floatingController = [CQMFloatingController sharedFloatingController];
    [floatingController setFrameColor:[UIColor whiteColor]];
    UIWindow *window1 = [[UIApplication sharedApplication] keyWindow];
    UIView *rootView = [window1.rootViewController view];
    [floatingController showInView:rootView
         withContentViewController:googlePlacesVC
                          animated:YES];
}
#pragma mark - Cell PdfView Delegate
- (IBAction)btnPdfNameClicked:(id)sender 
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) 
                            {
                                [self dismissViewControllerAnimated:YES completion:^{}];
                            }]];       
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                [self takePhoto];
                                //[self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) 
                            {
                                [self choosePhoto];
                               //[self dismissViewControllerAnimated:YES completion:^{}];
                            }]];
    [self presentViewController:actionSheet animated:YES completion:^{    }];
}

-(void) takePhoto{
    
    if (TARGET_IPHONE_SIMULATOR)
    {
        NSLog(@"App Running in Simulator");
    }
    else
    {
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
}
-(void) choosePhoto
{
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    CellWithCV *cellselected=(CellWithCV*)[_tblPostDriver cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImage *img = [Function scaleAndRotateImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [arrProfileImage removeAllObjects];
    [arrProfileImage addObject:img];
  
    [cellselected.cvPhotoes reloadData];
    cellselected.cvPhotoes.hidden=NO;
    cellselected.lblNoData.hidden=YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.allowsEditing = NO;
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
     imagePickerController.navigationBar.barTintColor=[UIColor orangeColor];
    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ClickEventCamera:(id)sender {
    [self takePhoto];
}

- (IBAction)ClickEventGallary:(id)sender {
    [self choosePhoto];
}
#pragma mark - Cell Header Delegate

- (IBAction)btnOpenSavedDrvierClicked:(id)sender
{
    
}
- (IBAction)btnDriverAddressClicked:(id)sender
{
    [self showMapViewPopUp:@"WelcomeScreenAddress"];
}
- (IBAction)btndriverVisibilityClicked:(id)sender
{
    listView= [self showListView:listView withSelectiontext:VisibilityTitle widthval:200 heightval:235];
    [listView show];
}

- (IBAction)btnBackClicked:(id)sender {
}

- (IBAction)btnDrawerClicked:(id)sender {
     [self.view endEditing:YES];
    [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

#pragma mark - popup view delegates
-(CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
    
}
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    @try {
        return arrvisiblity.count;
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
       
        return cell;
    }
    @catch (NSException *exception) {
        
    }
    
}
- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        visibilityvalue=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [tblHeadervw.btnDriverVisiblility setTitle:[arrvisiblity objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [listView dismiss];
        [overlayview removeFromSuperview];
}
#pragma mark - footer delegate
- (IBAction)btnPublishEquiClicked:(id)sender
{
}
- (IBAction)btnSaveEquiClicekd:(id)sender
{
}
- (IBAction)btnUpdateEquiClicked:(id)sender
{
}
@end
