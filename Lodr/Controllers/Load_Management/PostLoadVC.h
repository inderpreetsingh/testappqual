//
//  PostLoadVC.h
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DKImagePickerController/DKImagePickerController-Swift.h>
#import "cellPdfview.h"
#import "CellPostLoadFooter.h"
#import "CellPostLoadHeader.h"
#import "CellWithCV.h"
#import "CellCvPickedImage.h"
#import "ZSYPopoverListView.h"
#import "CellListWithCheckBox.h"
#import "SPGooglePlacesAutocompleteViewController.h"
#import "CQMFloatingController.h"
#import "HomeVC.h"
#import "EquiEspecial.h"
#import "SubEquiEspecial.h"
#import "AllSavedLoadListVC.h"
#import "CoreDataAdaptor.h"
#import "CellChooseTrailers.h"
#import "CellWelcomeFooter.h"
#import "CellWithBtns.h"
@interface PostLoadVC : BaseVC<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,ZSYPopoverListDelegate,ZSYPopoverListDatasource,CellCvPickedImageDelegate,CellPostLoadHeaderDelegate,CellPdfviewDelegate,CellPostLoadFooterDelegate,CellChooseTrailersDelegate,CellWelcomeFooterDelegate,CellWithBtnsDelegate,CellListWithCheckBoxDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnpeBack;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnDrawerClicked:(id)sender;
@property  (strong, nonatomic) NSString *strRedirectFrom;  
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UITableView *tblPostLoad;
@property (weak, nonatomic) IBOutlet UITableView *tblChooseTrailer;
//- (IBAction)btnBackClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblChooseSubTrailer;
- (IBAction)btnBackClickAction:(UIButton *)sender;


@end
