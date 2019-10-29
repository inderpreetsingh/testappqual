//
//  CellLoadDetailTop.h
//  Lodr
//
//  Created by Payal Umraliya on 20/04/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellLoadDetailTop : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblLoadCode;
@property (weak, nonatomic) IBOutlet UIView *vwFromAddressData;
@property (weak, nonatomic) IBOutlet UIView *vwToAddressData;

@property (weak, nonatomic) IBOutlet UILabel *lblFromValue;
@property (weak, nonatomic) IBOutlet UILabel *lblToValue;
@property (weak, nonatomic) IBOutlet UILabel *lblfromstatecode;
@property (weak, nonatomic) IBOutlet UILabel *lblfromaddress;
@property (weak, nonatomic) IBOutlet UILabel *lblfromphone;
@property (weak, nonatomic) IBOutlet UILabel *lblfromopentime;
@property (weak, nonatomic) IBOutlet UILabel *lblfromheadingpickup;
@property (weak, nonatomic) IBOutlet UILabel *lblpickuptime;
@property (weak, nonatomic) IBOutlet UILabel *lbltostatecode;
@property (weak, nonatomic) IBOutlet UILabel *lbltoaddress;
@property (weak, nonatomic) IBOutlet UILabel *lbltophone;
@property (weak, nonatomic) IBOutlet UILabel *lbltoopentime;

@property (weak, nonatomic) IBOutlet UILabel *lbltoheadingdelievey;
@property (weak, nonatomic) IBOutlet UILabel *lblfromcompnayname;
@property (weak, nonatomic) IBOutlet UILabel *lbldelieveytime;
@property (weak, nonatomic) IBOutlet UILabel *lbltodate;
@property (weak, nonatomic) IBOutlet UILabel *lbltocompanyname;
@property (weak, nonatomic) IBOutlet UILabel *lblfromdate;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;

@property (weak, nonatomic) IBOutlet UITextView *lblfromtextvw;
@property (weak, nonatomic) IBOutlet UITextView *lbltotextvw;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topCode;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightlbltocompnyname;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightlblFromcompnyname;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightlblfromphone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightlbltoopentime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightlblfromopentime;

@property (weak, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (weak, nonatomic) IBOutlet UIButton *btnFromAddressHide;
@property (weak, nonatomic) IBOutlet UIButton *btnToAddressHide;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightlbltophone;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightcodelbl;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heightvaluecode;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topcodeval;
@end
