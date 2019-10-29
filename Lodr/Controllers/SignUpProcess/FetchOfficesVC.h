//
//  FetchOfficesVC.h
//  Lodr
//
//  Created by C205 on 15/05/19.
//  Copyright © 2019 checkmate. All rights reserved.
//

#import "BaseVC.h"
#import "OfficeDetails.h"

@protocol FetchOfficesVCDelegate <NSObject>

@optional

- (void)didSelectOffice:(id)officeDetails;

@end


@interface FetchOfficesVC : BaseVC

@property (strong, nonatomic) NSArray *arrOffices;
@property (weak, nonatomic) id<FetchOfficesVCDelegate> delegate;

@end
