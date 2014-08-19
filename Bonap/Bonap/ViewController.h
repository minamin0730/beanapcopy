//
//  ViewController.h
//  BeanapCamera
//
//  Created by 神吉晶 on 2014/08/18.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *customImageView;
    //フラグの変数
    BOOL cameraFlag,photFlag;
    //写真もってる変数
    UIImage* originalImage;
}
-(void)configureView;
-(void)showCamera;


@end
