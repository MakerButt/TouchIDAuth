// A0TouchIDAuthentication.m
//
// Copyright (c) 2014 Auth0 (http://auth0.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "A0TouchIDAuthentication.h"

#ifdef __IPHONE_8_0

#import <LocalAuthentication/LocalAuthentication.h>

#endif

@implementation A0TouchIDAuthentication

- (void)start {
}

+ (BOOL)isTouchIDAuthenticationAvailable {
#if TARGET_IPHONE_SIMULATOR
    return YES;
#elif defined __IPHONE_8_0
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) { //iOS 8
        LAContext *context = [[LAContext alloc] init];
        NSError *error;
        BOOL available = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
        if (!available || error) {
            NSLog(@"TouchID is not available for device. Error: %@", error);
        }
        return available;
    } else { //iOS <= 7.1
        NSLog(@"You need iOS 8 to use TouchID local authentication");
        return NO;
    }
#else
    NSLog(@"You need iOS 8 to use TouchID local authentication");
    return NO;
#endif
}

@end
