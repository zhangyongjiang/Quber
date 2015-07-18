#import "Page.h"

@interface SendMessagePage : FormPage
{
    @protected
    UIView* containerView;
}

@property(strong,nonatomic)FullWidthField* textFieldSubject;
@property(strong,nonatomic)NSUITextView* textFieldContent;
@property(strong,nonatomic)UIImageView* cameraView;
@property(strong,nonatomic)UILabel* labelAttachment;
@property(strong,nonatomic)NSMutableArray* images;

-(void)addImage:(UIImage*)img;

@end
