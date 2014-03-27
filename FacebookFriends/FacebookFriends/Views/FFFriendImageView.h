#import <UIKit/UIKit.h>

@class FFImageModel;

@interface FFFriendImageView : UIView <IDPModelObserver>
@property (nonatomic, retain)	IBOutlet UIActivityIndicatorView	*spinner;
@property (nonatomic, retain)	IBOutlet UIImageView				*imageView;

@property (nonatomic, retain)	FFImageModel	*model;

@end
