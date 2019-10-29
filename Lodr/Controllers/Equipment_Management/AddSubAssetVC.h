//
//  AddSubAssetVC.h
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DKImagePickerController/DKImagePickerController-Swift.h>
#import "CellPostEquiHeader.h"
#import "CellPostEquiFooter.h"
#import "cellPdfview.h"
#import "CellWithCV.h"
#import "CellCvPickedImage.h"
#import "Function.h"
#import <CoreLocation/CoreLocation.h>
#import "OfficeDetails.h"


@interface AddSubAssetVC : BaseVC<UITableViewDelegate,UITableViewDataSource,CellPostEquiFooterDelegate,CellPostEquiHeaderDelegate,CellPdfviewDelegate,CellCvPickedImageDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) OfficeDetails *objOfficeDetails;

@property (weak, nonatomic) IBOutlet UITableView *tbladdform;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
- (IBAction)btnDrawerclicked:(id)sender;
- (IBAction)btnBackclciked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnback;
@property (strong, nonatomic) NSString *selectedAssetId,*selectedAssetName,*selectedsubassetId,*selectedsubassetname;

@end
