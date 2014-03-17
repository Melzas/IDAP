//
//  FFMainViewController.m
//  FacebookFriends
//
//  Created by Anton Rayev on 3/17/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

#import "FFMainViewController.h"

#import "FFMainView.h"

@interface FFMainViewController ()
@property (nonatomic, readonly)	FFMainView	*mainView;

@end

@implementation FFMainViewController

@dynamic mainView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(FFMainView, mainView);

@end
