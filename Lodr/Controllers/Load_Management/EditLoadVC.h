//
//  EditLoadVC.h
//  Lodr
//
//  Created by Payal Umraliya on 18/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellListWithCheckBox.h"
#import "SPGooglePlacesAutocompleteViewController.h"
#import "CQMFloatingController.h"
#import "HomeVC.h"
#import "EquiEspecial.h"
#import "SubEquiEspecial.h"
#import "ZSYPopoverListView.h"
#import "CellCvPickedImage.h"
#import "Loads.h"
#import <DKImagePickerController/DKImagePickerController-Swift.h>
#import "cellPdfview.h"
#import "CellPostLoadFooter.h"
#import "CellPostLoadHeader.h"
#import "CellWithCV.h"
#import "Matches.h"


@interface EditLoadVC : BaseVC<UITableViewDelegate,UITableViewDataSource,ZSYPopoverListDelegate,ZSYPopoverListDatasource,CellCvPickedImageDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CellPostLoadHeaderDelegate,CellPdfviewDelegate,CellPostLoadFooterDelegate,UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *vwnavbar;
@property (weak, nonatomic) IBOutlet UITableView *tblEditLIst;
- (IBAction)btnDrawerClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
@property (strong, nonatomic) Loads *editLoadDetail;


@end
