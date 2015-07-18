//
//  BaseViewController.h
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface BaseViewController : UIViewController

@property(assign,nonatomic)BOOL transparentNavbar;

-(void)alertWithTitle:(NSString*)title andMsg:(NSString *)msg;
-(void)alertWithTitle:(NSString*)title andMsg:(NSString*)msg handler:(void (^)(UIAlertAction *action))handler;
-(UIAlertController*)alertWithTitle:(NSString *)title andMsg:(NSString *)msg
                          okHandler:(void (^)(UIAlertAction *action))okHandler
                      cancelHandler:(void (^)(UIAlertAction *action))cancelHandler;

-(void)createPage;
-(void)refreshPage;
-(void)nextPage;
-(BOOL)hasNextPage:(int)pageSize current:(int)currentPage currentItems:(NSInteger)currentItems;

-(UIBarButtonItem*)addNavRightButton:(NSString*)text target:(id)target action:(SEL)action;
-(UIBarButtonItem*)addNavRightImgButton:(UIImage*)img target:(id)target action:(SEL)action;
-(UIBarButtonItem*)addNavRightIconButton:(UIBarButtonSystemItem)sysItem target:(id)target action:(SEL)action;
-(void)removeNavRightButton;

-(void)languageChanged:(NSNotification*)noti;

-(void)loadCameraOrPhotoLibraryWithDelegate:(id)delegate allowEditing:(BOOL)allowEditing;

-(void)handleEvent:(NSString *)name fromSource:(NSObject *)source data:(NSObject *)data;

-(void)addOperation:(AFHTTPRequestOperation*)operation;
-(void)cancelAllOperations;
@end
