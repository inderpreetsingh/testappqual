//
//  EditDriverVC.h
//  Lodr
//
//  Created by c196 on 12/05/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellPostDriverHeader.h"
#import "CellPostEquiFooter.h"
#import "CellWithCV.h"
#import "cellPdfview.h"
#import "CellCvPickedImage.h"
#import "SPGooglePlacesAutocompleteViewController.h"
#import "CQMFloatingController.h"
#import "ZSYPopoverListView.h"
#import "CellListWithCheckBox.h"
#import "Function.h"
@interface EditDriverVC : BaseVC<UITableViewDelegate,UITableViewDataSource,CellPostDriverHeaderDelegate,CellPostEquiFooterDelegate,CellPdfviewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CellCvPickedImageDelegate,ZSYPopoverListDelegate,ZSYPopoverListDatasource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UITableView *tblPostDriver;
@end
