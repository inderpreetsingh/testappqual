//
//  PostEquipmentVC.h
//  Lodr
//
//  Created by Payal Umraliya on 17/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"
#import "EquiEspecial.h"
#import "SubEquiEspecial.h"
#import "CoreDataAdaptor.h"
#import <DKImagePickerController/DKImagePickerController-Swift.h>
#import "ZSYPopoverListView.h"
#import "cellPdfview.h"
#import "CellWithCV.h"
#import "CellCvPickedImage.h"
#import "CellPostEquiHeader.h"
#import "CellPostEquiFooter.h"
#import "CellListWithCheckBox.h"
#import <CoreLocation/CoreLocation.h>
#import "OfficeDetails.h"

@interface PostEquipmentVC : BaseVC<UITableViewDelegate,UITableViewDataSource,ZSYPopoverListDelegate,ZSYPopoverListDatasource,CellCvPickedImageDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CellPostEquiHeaderDelegate,CellPdfviewDelegate,CellPostEquiFooterDelegate>

@property (strong, nonatomic) OfficeDetails *objOfficeDetails;

@property (weak, nonatomic) IBOutlet UIButton *btnpeBack;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnDrawerClicked:(id)sender;
@property  (strong, nonatomic) NSString *strRedirectFrom;  
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UITableView *tblPostEquipment;
@property (strong, nonatomic) NSString *selectedAssetId,*selectedSubAssetId,*selectedCapacity;
@end
