// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "FBSDKAccessTokenCacheV4.h"

#import "FBSDKDynamicFrameworkLoader.h"
#import "FBSDKInternalUtility.h"
#import "FBSDKKeychainStore.h"

static NSString *const kFBSDKAccessTokenUserDefaultsKey = @"com.facebook.sdk.v4.FBSDKAccessTokenInformationKey";
static NSString *const kFBSDKAccessTokenUUIDKey = @"tokenUUID";
static NSString *const kFBSDKAccessTokenEncodedKey = @"tokenEncoded";

@implementation FBSDKAccessTokenCacheV4
{
  FBSDKKeychainStore *_keychainStore;
}

- (instancetype)init
{
  if ((self = [super init])) {
    NSString *keyChainServiceIdentifier = [NSString stringWithFormat:@"com.facebook.sdk.tokencache.%@", [[NSBundle mainBundle] bundleIdentifier]];
    _keychainStore = [[FBSDKKeychainStore alloc] initWithService:keyChainServiceIdentifier accessGroup:nil];
  }
  return self;
}

- (FBSDKAccessToken *)fetchAccessToken
{
    @try 
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uuid = [defaults objectForKey:kFBSDKAccessTokenUserDefaultsKey];
        
            NSDictionary *dict = [_keychainStore dictionaryForKey:kFBSDKAccessTokenUserDefaultsKey];
            if (![dict[kFBSDKAccessTokenUUIDKey] isEqualToString:uuid]) {
                [self clearCache];
                return nil;
            }
          id tokenData = dict[kFBSDKAccessTokenEncodedKey];
          if ([tokenData isKindOfClass:[NSData class]]) {
            return [NSKeyedUnarchiver unarchiveObjectWithData:tokenData];
          }
          else
          {
            return nil;
          }
    } 
    @catch (NSException *exception) {
        
    } 
}

- (void)cacheAccessToken:(FBSDKAccessToken *)token
{
  if (!token) {
    [self clearCache];
    return;
  }
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *uuid = [defaults objectForKey:kFBSDKAccessTokenUserDefaultsKey];
  if (!uuid) {
    uuid = [[NSUUID UUID] UUIDString];
    [defaults setObject:uuid forKey:kFBSDKAccessTokenUserDefaultsKey];
    [defaults synchronize];
  }
  NSData *tokenData = [NSKeyedArchiver archivedDataWithRootObject:token];
  NSDictionary *dict = @{
                         kFBSDKAccessTokenUUIDKey : uuid,
                         kFBSDKAccessTokenEncodedKey : tokenData
                         };

  [_keychainStore setDictionary:dict
                         forKey:kFBSDKAccessTokenUserDefaultsKey
                  accessibility:[FBSDKDynamicFrameworkLoader loadkSecAttrAccessibleAfterFirstUnlockThisDeviceOnly]];
}

- (void)clearCache
{
  [_keychainStore setDictionary:nil
                         forKey:kFBSDKAccessTokenUserDefaultsKey
                  accessibility:NULL];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults removeObjectForKey:kFBSDKAccessTokenUserDefaultsKey];
  [defaults synchronize];
}
@end
