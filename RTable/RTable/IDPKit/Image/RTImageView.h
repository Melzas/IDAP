#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

@class IDPImageModel;

@interface RTImageView : UIView <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UIActivityIndicatorView	*spinner;
@property (nonatomic, retain)	IBOutlet UIImageView				*imageView;

@property (nonatomic, retain)	IDPImageModel	*model;

@end
