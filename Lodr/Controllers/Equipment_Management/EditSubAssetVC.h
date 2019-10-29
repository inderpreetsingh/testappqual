//
//  EditSubAssetVC.h
//  Lodr
//
//  Created by c196 on 26/06/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"
#import "EquiEspecial.h"
#import "SubEquiEspecial.h"

#import <DKImagePickerController/DKImagePickerController-Swift.h>

#import "cellPdfview.h"
#import "CellWithCV.h"
#import "CellCvPickedImage.h"
#import "CellPostEquiHeader.h"
#import "CellPostEquiFooter.h"
#import "Equipments.h"
@interface EditSubAssetVC : BaseVC<UITableViewDelegate,UITableViewDataSource,CellCvPickedImageDelegate,UICollectionViewDelegate,UICollectionViewDataSource,CellPostEquiHeaderDelegate,CellPdfviewDelegate,CellPostEquiFooterDelegate,DKImagePickerControllerUIDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnpeBack;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UITableView *tbleditEquipment;
@property (strong, nonatomic) Equipments *editEquiDetail;
@end
