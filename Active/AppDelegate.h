//
//  Active ++
//
//  Created by Gellert Kispal, Faraz Bhojani, Adesh Banvait
//  Copyright (c) 2012 Mobile++. All rights reserved.
//
//  Delegate class
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class FacebookViewContoller;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FacebookViewContoller *viewController;

@property (strong, nonatomic) FBSession *session;

@end
