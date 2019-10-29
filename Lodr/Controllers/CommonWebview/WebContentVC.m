//
//  WebContentVC.m
//  Lodr
//
//  Created by Payal Umraliya on 16/03/17.
//  Copyright © 2017 checkmate. All rights reserved.
//

#import "WebContentVC.h"

@interface WebContentVC ()

@end

@implementation WebContentVC

- (void)viewDidLoad 
{
    [super viewDidLoad];
     [self.btnWebviewDrawer setImage:imgNamed(iconDrawer2) forState:UIControlStateNormal];
  
    NSURL *url = [NSURL URLWithString:self.webURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webAllCOntents loadRequest:requestObj];
    if([_redirectfrom isEqualToString:@"MENUVC"])
    {
        self.btnWebviewDrawer.hidden=YES;
    }
    [self.btnBack setImage:imgNamed(iconBackArrowLong) forState:UIControlStateNormal];
    [_activityview startAnimating];
     _vwloader.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
#pragma mark - webview delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activityview stopAnimating];
    _vwloader.hidden=YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [AZNotification showNotificationWithTitle:error.localizedDescription controller:ROOTVIEW notificationType:AZNotificationTypeSuccess];
    [_activityview stopAnimating];
    _vwloader.hidden=YES;
}
- (IBAction)btnBackClicked:(id)sender
{
    if([_redirectfrom isEqualToString:@"MENUVC"])
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else
    {
         [self.navigationController popViewControllerAnimated:YES];
    }
   
}
- (IBAction)btnWebviewDrawerClicked:(id)sender {
 [AppInstance.drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}
@end
