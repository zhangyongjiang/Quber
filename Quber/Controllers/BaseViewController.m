//
//  BaseViewController.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "BaseViewController.h"
#import "APBAlertView.h"

@interface BaseViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong, nonatomic)NSString* nontranslatedTitle;
@property(strong, nonatomic)NSMutableArray* operations;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.operations = [[NSMutableArray alloc] init];
    [self createPage];
}

-(void)alertWithTitle:(NSString *)title andMsg:(NSString *)msg {
    [self alertWithTitle:title andMsg:msg handler:nil];
}

-(void)alertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(void (^)(UIAlertAction *action))handler{
    if ([UIAlertController class]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:handler]];
        [self presentViewController:alert animated:YES completion:^{
        }];
    }
    else {
        APBAlertView *alertView = [[APBAlertView alloc]
                                   initWithTitle:title
                                   message:msg
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@[@"OK"]
                                   cancelHandler:^{
                                   }
                                   confirmationHandler:^(NSInteger otherButtonIndex) {
                                       handler(nil);
                                   }];
        [alertView show];
    }
}

-(UIAlertController*)alertWithTitle:(NSString *)title andMsg:(NSString *)msg
            okHandler:(void (^)(UIAlertAction *action))okHandler
            cancelHandler:(void (^)(UIAlertAction *action))cancelHandler
{
    if ([UIAlertController class]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:okHandler]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:cancelHandler]];
        [self presentViewController:alert animated:YES completion:^{
        }];
        return alert;
    }
    else {
        APBAlertView *alertView = [[APBAlertView alloc]
                                   initWithTitle:title
                                   message:msg
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@[@"OK"]
                                   cancelHandler:^{
                                       cancelHandler(nil);
                                   }
                                   confirmationHandler:^(NSInteger otherButtonIndex) {
                                       okHandler(nil);
                                   }];
        [alertView show];
        return nil;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    if (self.transparentNavbar) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        
        //        self.navigationController.navigationBar.translucent = YES;
        //        self.navigationController.view.backgroundColor = [UIColor clearColor];
        //        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    }
    else {
        self.navigationController.navigationBar.tintColor = [UIColor mainColor];
    }
    [super setTitle:self.nontranslatedTitle];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillAppear:animated];
    if(self.view.subviews.count>0) {
        UIView* page = [self.view.subviews objectAtIndex:0];
        if ([page isKindOfClass:[TableViewPage class]]) {
            TableViewPage* tablePage = (TableViewPage*)page;
            [tablePage deselect];
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshControl:) name:NotificationRefreshControl object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationEndOfDisplay:) name:NotificationEndOfDisplay object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushController:) name:NotificationPushController object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPresentController:) name:NotificationPresentController object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged:) name:NotificationLangChanged object:nil];
}

-(void)refreshControl:(NSNotification*)noti {
    UIView* subview = noti.object;
    if([subview isSameViewOrChildOf:self.view]) {
        [self refreshPage];
    }
}

-(void)refreshPage {
}

-(void)createPage {
}

-(void)notificationEndOfDisplay:(NSNotification*)noti {
    UIView* subview = noti.object;
    if([subview isSameViewOrChildOf:self.view]) {
        [self nextPage];
    }
}

-(void)notificationPushController:(NSNotification*)noti {
    if (self.isViewLoaded && self.view.window) {
        UIView* subview = noti.object;
        if([subview isSameViewOrChildOf:self.view]) {
            UIViewController* controller = [noti.userInfo objectForKey:@"controller"];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

-(void)notificationPresentController:(NSNotification*)noti {
    UIView* subview = noti.object;
    if([subview isSameViewOrChildOf:self.view]) {
        UIViewController* controller = [noti.userInfo objectForKey:@"controller"];
        [self.navigationController presentViewController:controller animated:YES completion:^{
        }];
    }
}

-(void)nextPage {
}

-(BOOL)hasNextPage:(int)pageSize current:(int)currentPage currentItems:(NSInteger)currentItems {
    if (currentItems%PageSize != 0 || currentPage*pageSize==currentItems) {
        return NO;
    }
    return YES;
}

-(UIBarButtonItem*)addNavRightButton:(NSString *)text target:(id)target action:(SEL)action {
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:target action:action];
    if (false) {
        self.navigationItem.rightBarButtonItem = btn;
        
        self.navigationItem.rightBarButtonItem.target = target;
        self.navigationItem.rightBarButtonItem.action = action;
        
        UIColor* color = [UIColor mainColor];
        if (self.transparentNavbar) {
            color = [UIColor whiteColor];
        }
        NSDictionary *barButtonAppearanceDict = @{NSFontAttributeName : [UIFont fontWithName:@"GothamRounded-Book" size:15.0], NSForegroundColorAttributeName:color};
        [btn setTitleTextAttributes:barButtonAppearanceDict forState:UIControlStateNormal];
        NSDictionary* textAttributes = [NSDictionary dictionaryWithObject: color
                                                                   forKey: NSForegroundColorAttributeName];
        [btn setTitleTextAttributes:textAttributes forState:UIControlStateDisabled];
        
        return btn;
    }
    else {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0,0,80,24);
        button.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size:15.0];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:text forState: UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        if (self.transparentNavbar) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.rightBarButtonItem = customBarItem;
        return customBarItem;
    }
}

-(UIBarButtonItem*)addNavRightImgButton:(UIImage *)img target:(id)target action:(SEL)action {
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:target action:action];
    self.navigationItem.rightBarButtonItem = btn;
    return btn;
}

-(UIBarButtonItem*)addNavRightIconButton:(UIBarButtonSystemItem)sysItem target:(id)target action:(SEL)action {
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:sysItem target:target action:action];
    self.navigationItem.rightBarButtonItem = btn;
    return btn;
}

-(void)removeNavRightButton {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    [rightButton setImage:nil forState:UIControlStateNormal];
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = btn;
}

-(void)languageChanged:(NSNotification*)noti {
    [super setTitle:nil];
    [super setTitle:self.nontranslatedTitle];
    [self createPage];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super setTitle:@""];
    [super viewWillDisappear:animated];
    if (self.transparentNavbar) {
        [self.navigationController.navigationBar setBackgroundImage:nil
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = nil;
    }
}

-(void)loadCameraOrPhotoLibraryWithDelegate:(id)delegate allowEditing:(BOOL)allowEditing {
    if ([UIAlertController class])
    {
        UIAlertController* alertCtrl = [UIAlertController alertControllerWithTitle:nil
                                                                           message:nil
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
        //Create an action
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action)
                                 {
                                     UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
                                     imagePicker.delegate = delegate;
                                     imagePicker.allowsEditing = allowEditing;
                                     imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                     [self presentViewController:imagePicker animated:YES completion:nil];
                                 }];
        UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"Image Gallery"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action)
                                       {
                                           UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
                                           imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                           imagePicker.delegate = delegate;
                                           imagePicker.allowsEditing = allowEditing;
                                           [self presentViewController:imagePicker animated:YES completion:nil];
                                       }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction *action)
                                 {
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
        
        //Add action to alertCtrl
        [alertCtrl addAction:camera];
        [alertCtrl addAction:imageGallery];
        [alertCtrl addAction:cancel];
        [self presentViewController:alertCtrl animated:YES completion:^{
        }];
    }
    else
    {
        APBAlertView *alertView = [[APBAlertView alloc]
                                   initWithTitle:nil
                                   message:nil
                                   cancelButtonTitle:@"Cancel"
                                   otherButtonTitles:@[@"Camera", @"Image Gallery"]
                                   cancelHandler:^{
                                       [self dismissViewControllerAnimated:YES completion:nil];
                                   }
                                   confirmationHandler:^(NSInteger otherButtonIndex) {
                                       if (otherButtonIndex == 0) {
                                           UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
                                           imagePicker.delegate = delegate;
                                           imagePicker.allowsEditing = allowEditing;
                                           imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                           [self presentViewController:imagePicker animated:YES completion:nil];
                                       }
                                       if (otherButtonIndex == 1) {
                                           UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
                                           imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                           imagePicker.delegate = delegate;
                                           imagePicker.allowsEditing = allowEditing;
                                           [self presentViewController:imagePicker animated:YES completion:nil];
                                       }
                                       if (otherButtonIndex == 2) {
                                           
                                       }
                                   }];
        [alertView show];
    }

}

- (void) loadCameraOrPhotoLibraryWithDelegateOld:(id)delegate allowEditing:(BOOL)allowEditing{
    UIAlertController* alertCtrl = [UIAlertController alertControllerWithTitle:nil
                                                         message:nil
                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    //Create an action
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action)
                             {
                                 UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
                                 imagePicker.delegate = delegate;
                                 imagePicker.allowsEditing = allowEditing;
                                 imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                 [self presentViewController:imagePicker animated:YES completion:nil];
                             }];
    UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"Image Gallery"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
                                       imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                       imagePicker.delegate = delegate;
                                       imagePicker.allowsEditing = allowEditing;
                                       [self presentViewController:imagePicker animated:YES completion:nil];
                                   }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    
    //Add action to alertCtrl
    [alertCtrl addAction:camera];
    [alertCtrl addAction:imageGallery];
    [alertCtrl addAction:cancel];
    [self presentViewController:alertCtrl animated:YES completion:^{
    }];
}

-(void)handleEvent:(NSString *)name fromSource:(NSObject *)obj data:(NSObject *)data {
}

-(void)cancelAllOperations {
    for (AFHTTPRequestOperation* operation in self.operations) {
        if(![operation isFinished]) {
            [operation cancel];
        }
    }
    [self.operations removeAllObjects];
}

-(void)addOperation:(AFHTTPRequestOperation *)operation {
    [self.operations addObject:operation];
}

@end
