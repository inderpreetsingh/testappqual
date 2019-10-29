//
//  CompanyAdminRequestVC.h
//  Lodr
//
//  Created by C205 on 26/06/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "BaseVC.h"
#import "CompanyRequest.h"

typedef enum {
    RequestTypeCompany,
    RequestTypeOffice
} RequestType;


@protocol CompanyAdminRequestVCDelegate <NSObject>
@optional
- (void)didAcceptRequest;
@end

@interface CompanyAdminRequestVC : BaseVC

@property (assign, nonatomic) RequestType selRequestType;
@property (weak, nonatomic) id<CompanyAdminRequestVCDelegate> delegate;

@property (strong, nonatomic) NSString *strCompanyId;
@property (strong, nonatomic) NSMutableArray <CompanyRequest *>*arrRequests;

@property (weak, nonatomic) IBOutlet UITableView *tblRequests;

@end
