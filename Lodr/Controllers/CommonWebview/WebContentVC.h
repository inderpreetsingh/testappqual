//
//  WebContentVC.h
//  Lodr
//
//  Created by Payal Umraliya on 16/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebContentVC : BaseVC<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webAllCOntents;
@property (strong, nonatomic) NSString *webURL,*redirectfrom;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnWebviewDrawerClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnWebviewDrawer;
@property (weak, nonatomic) IBOutlet UIView *vwloader;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityview;

@end
