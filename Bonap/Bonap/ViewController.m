//
//  ViewController.m
//  BeanapCamera
//
//  Created by 神吉晶 on 2014/08/18.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
	// Do any additional setup after loading the view, typically from a nib.
   //フラグたてとく
    photFlag = TRUE;
    cameraFlag = FALSE;
}

-(void)viewDidAppear:(BOOL)animated{
    //カメラで撮影したあとにpostToTwitterに飛ぶ
    if (cameraFlag) {
        [self postToTwitter];
    }
}


-(void)configureView
{
    //ボタンの用意（カメラ）
    UIButton *customButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    customButton1.frame = CGRectMake(40.0, 160.0, 240.0, 40.0);
    [customButton1 setTitle:@"カメラ" forState:UIControlStateNormal];
    [customButton1 addTarget:self action:@selector(showCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton1];


    //ボタンの用意（アルバム）
    UIButton *customButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    customButton2.frame = CGRectMake(40.0, 260.0, 240.0, 40.0);
    [customButton2 setTitle:@"カメラロール" forState:UIControlStateNormal];
    [customButton2 addTarget:self action:@selector(showPhotoLibrary) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton2];
 
    
}

//カメラの表示
-(void)showCamera
{
    NSLog(@"カメラ表示");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if(![UIImagePickerController isSourceTypeAvailable:sourceType]){
        return;
    }
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion: nil];
}


//フォトライブラリの表示
-(void)showPhotoLibrary
{
    photFlag = FALSE;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if(![UIImagePickerController isSourceTypeAvailable:sourceType]){
        return;
    }
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion: nil];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"カメラ");
    //カメラの画面を引っ込める
    [self dismissViewControllerAnimated:YES completion:nil];
    //画像データを引っこ抜く
    originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //画像をイメージビューに貼る
    customImageView.image = originalImage;
    //画像をフォトライブラリに保存する
    //カメラ撮影のときだけ保存する
    if(photFlag){
    UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil);
    }
    NSLog(@"保存");
    cameraFlag= TRUE;
}



// Twitterに投稿
- (void)postToTwitter {
    NSLog(@"ツイッター");
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [vc setInitialText:@" #Beanap!"];
    
    [vc addImage:originalImage];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    
    vc.completionHandler = ^(SLComposeViewControllerResult result){
        
        switch (result) {
            case SLComposeViewControllerResultDone:
                
                break;
                
            case SLComposeViewControllerResultCancelled:
                break;
            default:
                break;
        }
        
        cameraFlag = FALSE;
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
