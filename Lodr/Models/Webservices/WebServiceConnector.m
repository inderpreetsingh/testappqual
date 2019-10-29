//
//  WebConnector.m
//  SQLExample
//
//  Created by Prerna on 5/15/15.
//  Copyright (c) 2015 Narola. All rights reserved.
//

#import "WebServiceConnector.h"
#import "WebServiceResponse.h"
#import "WebServiceDataAdaptor.h"
#import "NetworkAvailability.h"
#import "JTProgressHUD.h"
#define DEFAULT_TIMEOUT 30.0f

@implementation WebServiceConnector
@synthesize responseArray,responseError,responseDict,serviceResponseCode,URLRequest;

-(void)showProgressView:(NSString *)str
{
    [JTProgressHUD showWithStyle:JTProgressHUDStyleGradient andText:str];
//    [SVProgressHUD showWithStatus:str];
//    [SVProgressHUD setRingThickness:5.0f];
//    [SVProgressHUD setForegroundColor:ThemeOrangeColor];
//    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}
- (BOOL)checkNetConnection
{
    return [[NetworkAvailability instance] isReachable];
}

-(void)init:(NSString *)WebService
                    withParameters:(NSDictionary *) ParamsDictionary
                    withObject:(id)object
                    withSelector:(SEL)selector
                    forServiceType:(NSString *)serviceType/* serviceType: {GET, POST, JSON} */
                    showDisplayMsg:(NSString *)message
                    showProgress:(BOOL)showProgress
{
    WebServiceResponse *server = [WebServiceResponse sharedMediaServer];
    //ShowNetworkIndicator(YES);
    serviceResponseCode = 100;
    responseError = [[NSString alloc]init];
    responseArray = [[NSArray alloc]init];
    NSLog(@"%@", WebService);
    
    if([serviceType isEqualToString:@"GET"])
    {
        URLRequest = [self getMutableRequestFromGetWS:WebService withParams:ParamsDictionary];
    }
    else if([serviceType isEqualToString:@"POST"])
    {
        URLRequest = [self getMutableRequestForPostWS:WebService withObjects:ParamsDictionary isJsonBody:NO];
    }
    else if([serviceType isEqualToString:@"FORMDATA"])
    {
        if(showProgress==YES)
        {
            [self showProgressView:message];
        }
         URLRequest = [self getMutableRequestForMultipartPostWS:WebService withObjects:ParamsDictionary];
    }
    else if([serviceType isEqualToString:@"JSON"])
    {
        if(showProgress==YES)
        {
           [self showProgressView:message];
        }
        URLRequest = [self getMutableRequestForPostWS:WebService withObjects:ParamsDictionary isJsonBody:YES];
    }
    else if([serviceType isEqualToString:@"PUT"])
    {
        if(showProgress==YES)
        {
           [self showProgressView:message];
        }
        URLRequest = [self getMutableRequestForPutWS:WebService withObjects:ParamsDictionary isJsonBody:YES];
    }
//    NS_LOGStringWithMessage(@"Request URL :%@",URLRequest.URL);
    if (![self checkNetConnection])
    {
        serviceResponseCode = 104;
        self.responseError = NetworkLost;
        [object performSelectorOnMainThread:selector withObject:self waitUntilDone:false];
        return;
    }
    [server initWithWebRequests:URLRequest inBlock:^(NSError *error, id objects, NSString *responseString)
     {
         if (error)
         {
             serviceResponseCode = 101;
             self.responseError = error.localizedDescription;
         }
         else
         {
             if ([responseString isEqualToString:@"Fail"])
             {
                 serviceResponseCode = 102;
                 self.responseError = @"Response Issue From Server";
             }
             else if ([responseString isEqualToString:@"Not Available"])
             {
                 serviceResponseCode = 103;
                 self.responseError = @"No Data Available";
             }
             else
             {
                 serviceResponseCode = 100;
                 responseDict = (NSDictionary *) objects;
                 responseArray = [[WebServiceDataAdaptor alloc]autoParse:responseDict forServiceName:WebService];
             }
             ShowNetworkIndicator(NO);
         }
//       [SVProgressHUD dismiss];
         [object performSelectorOnMainThread:selector withObject:self waitUntilDone:false];
     }
     ];
}

#pragma mark - generate URL Methods
//PU ADDED
-(NSMutableURLRequest *)getMutableRequestForMultipartPostWS:(NSString *)url withObjects: (NSDictionary *)dict
{
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData]; 
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:DEFAULT_TIMEOUT];
    [request setHTTPMethod:@"POST"];
   
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    for (NSString *param in dict) 
    {
        if([dict objectForKey:param]!=nil)
        {
            if( [[dict objectForKey:param] isKindOfClass:[NSString class]])
            {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant]
                                  dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data;name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"%@\r\n", [dict objectForKey:param]]
                                  dataUsingEncoding:NSUTF8StringEncoding]]; 
            }
            else
            {
                UIImage *img = (UIImage *)[dict objectForKey:param];
                NSData *imageData = UIImageJPEGRepresentation(img,0.5);
                NSString *timeStamp =[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
                NSString *strImageName = [NSString stringWithFormat:@"%@_%@.jpeg",timeStamp,[DefaultsValues getStringValueFromUserDefaults_ForKey:SavedUserId]];
                NSString *str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", param,strImageName];
                if(imageData)
                {
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:imageData];
                    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
                } 
            }
        }
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
     [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]]; [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setURL:[NSURL URLWithString:url]];
    return request; 
}

/*** this method can be used when parameters are to be sent as query string ***/
-(NSMutableURLRequest *) getMutableRequestFromGetWS:(NSString *)WebService withParams: (NSDictionary *) ParamsDictionary
{
   //TraceWS(WebService,ParamsDictionary,@"GET")
    NSString *Query;
    if(ParamsDictionary == nil)
    {
        Query = WebService;
    }
    else
    {
        int i = 0;
        for(id key in ParamsDictionary)
        {
            NSString *appendString;
            if(i != ParamsDictionary.count - 1)
                appendString = [NSString stringWithFormat:@"%@=%@&",key,[ParamsDictionary objectForKey:key]];
            else
                appendString = [NSString stringWithFormat:@"%@=%@",key,[ParamsDictionary objectForKey:key]];
            Query = [Query stringByAppendingString:appendString];
            i++;
        }
    }
    Query = [WebService stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:Query]
                                    cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                    timeoutInterval:DEFAULT_TIMEOUT];

    return request;
}

- (NSMutableURLRequest *)getMutableRequestForPostWS:(NSString *)url withObjects:(NSDictionary *)dict isJsonBody:(bool)JSONBody
{
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:urlString]
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:DEFAULT_TIMEOUT];
    NSData *objData;
    if (JSONBody)
    {
        objData = [self dictionaryToJSONData:dict];
        NSDictionary *headers = @{ 
                                   @"accept": @"application/json",
                                   @"User-Agent": @"iOS"};
        [request setAllHTTPHeaderFields:headers];
    }
    else
    {
        objData = [self dictionaryToPostData:dict];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[objData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:objData];
    return request;
}

-(NSMutableURLRequest *)getMutableRequestForPutWS:(NSString *)url withObjects:(NSDictionary *)dict isJsonBody:(bool)JSONBody
{
    NSString *urlString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:urlString]
                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    timeoutInterval:DEFAULT_TIMEOUT];
    NSData *objData;
    if (JSONBody)
    {
        objData = [self dictionaryToJSONData:dict];
        NSDictionary *headers = @{ @"content-type": @"application/json",
                                   @"accept": @"application/json",
                                   @"Authorization":@"Basic dGVzdGluZzp0ZXN0aW5nMTIz"};
        [request setAllHTTPHeaderFields:headers];
    }
    else
    {
        objData = [self dictionaryToPostData:dict];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[objData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:objData];
    return request;
}



#pragma mark - helper methods
-(NSData *)dictionaryToJSONData:(NSDictionary *)dict
{
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:dict] options:0 error:&jsonError];
    if (jsonError!=nil)
    {
        return nil;
    }
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData
                                              encoding:NSUTF8StringEncoding];
//    NS_LOGStringWithMessage(@"Request Json :%@",jsonStr);
    return jsonData;
}

-(NSData *) dictionaryToPostData:(NSDictionary *) ParamsDictionary
{
    int i = 0;
    NSString *postDataString = @"";
    for(id key in ParamsDictionary)
    {
        if(i != ParamsDictionary.count - 1)
            postDataString = [postDataString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[ParamsDictionary objectForKey:key]]];
        else
            postDataString = [postDataString stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,[ParamsDictionary objectForKey:key]]];
        i++;
    }
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:[postDataString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSLog(@"%@",jsonOutput);
    return [postDataString dataUsingEncoding:NSUTF8StringEncoding];
}
/*
 
 NSMutableArray *arrMedia=[dict objectForKey:param];
 [arrMedia enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * _Nonnull stop)
 {
 if([obj isKindOfClass:[UIImage class]])
 {
 UIImage *img = (UIImage *)obj;
 NSData *imageData = UIImageJPEGRepresentation(img,1.0);
 NSString *timeStamp =[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
 NSString *strImageName = [NSString stringWithFormat:@"%@_%@.jpeg",timeStamp,@"1"];
 NSString *str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"Load_Photo",strImageName];
 if(imageData)
 {
 [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:imageData];
 [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
 [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
 }
 }
 }];
 
 
 */
@end
