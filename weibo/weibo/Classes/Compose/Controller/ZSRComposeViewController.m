//
//  ZSRComposeViewController.m
//  weibo
//
//  Created by hp on 15/12/11.
//  Copyright © 2015年 hp. All rights reserved.
//

#import "ZSRComposeViewController.h"
#import "ZSRAccountTool.h"
#import "ZSRTextView.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "ZSRComposeToolbar.h"
#import "ZSRComposePhotosView.h"
#import "ZSREmotionKeyboard.h"

@interface ZSRComposeViewController ()<UITextViewDelegate, ZSRComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入控件 */
@property (nonatomic, weak) ZSRTextView *textView;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) ZSRComposeToolbar *toolbar;
/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) ZSRComposePhotosView *photosView;
//@property (nonatomic, assign) BOOL  picking;

/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;
@end

@implementation ZSRComposeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航栏内容
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    //设置工具条
    [self setupToolbar];
    // 添加相册
    [self setupPhotosView];
    
    // 默认是YES：当scrollView遇到UINavigationBar、UITabBar等控件时，默认会设置scrollView的contentInset
//        self.automaticallyAdjustsScrollViewInsets;

}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //presentViewController出来的will这个item不能点击(目前放在viewWillAppear就能显示disable下的主题)
    self.navigationItem.rightBarButtonItem.enabled = NO;
//    ZSRLog(@"%@", NSStringFromUIEdgeInsets(self.textView.contentInset));
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘）
    [self.textView becomeFirstResponder];
}
- (void)dealloc
{
    [ZSRNotificationCenter removeObserver:self];
}
#pragma mark - 初始化方法

/**
 * 添加相册
 */
- (void)setupPhotosView
{
    ZSRComposePhotosView *photosView = [[ZSRComposePhotosView alloc] init];
    photosView.y = 100;
    photosView.width = self.view.width;
    // 随便写的
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}
/**
 * 添加工具条
 */
- (void)setupToolbar
{
    ZSRComposeToolbar *toolbar = [[ZSRComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    //inputAccessoryView设置显示在键盘顶部的内容
//    self.textView.inputAccessoryView = toolbar;
    //inputView设置键盘
//    self.textView.inputView = [UIButton buttonWithType:UIButtonTypeContactAdd];
}

/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
   
    NSString *name = [ZSRAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        // 自动换行
        titleView.numberOfLines = 0;
        titleView.y = 50;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        
        // 创建一个带有属性的字符串（比如颜色属性、字体属性等文字属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        // 添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
    
    //    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    //    att.image = [UIImage imageNamed:@"vip"];
    //    NSAttributedString *str2 = [NSAttributedString attributedStringWithAttachment:att];
    //    [attrStr appendAttributedStr];ing:str2
    //
    //
    //    [attrStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"哈哈"]];
    
    
    
    //    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:name]];
    //    [attrStr addAttribute:NSBackgroundColorAttributeName value:[UIColor blueColor] range:[str rangeOfString:name]];
    //    NSShadow *shadow = [[NSShadow alloc] init];
    ////    shadow.shadowColor = [UIColor blueColor];
    //    shadow.shadowBlurRadius = 10;
    //    shadow.shadowOffset = CGSizeMake(1, 1);
    //    [attrStr addAttribute:NSStrokeWidthAttributeName value:@1 range:[str rangeOfString:name]];
    //    self.navigationItem.title = [NSString stringWithFormat:@"发微博\r\n%@", [HWAccountTool account].name];
}

/**
 * 添加输入控件
 */
- (void)setupTextView
{
    // 在这个控制器中，textView的contentInset.top默认会等于64
    ZSRTextView *textView = [[ZSRTextView alloc] init];
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    //    textView.placeholderColor = [UIColor redColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 文字改变的通知
    [ZSRNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    // 键盘通知
    // 键盘的frame发生改变时发出的通知（位置和尺寸）
    //    UIKeyboardWillChangeFrameNotification
    //    UIKeyboardDidChangeFrameNotification
    // 键盘显示时发出的通知
    //    UIKeyboardWillShowNotification
    //    UIKeyboardDidShowNotification
    // 键盘隐藏时发出的通知
    //    UIKeyboardWillHideNotification
    //    UIKeyboardDidHideNotification
    [ZSRNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}
#pragma mark - 监听方法
/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    //    if (self.picking) return;
    /**
     notification.userInfo = @{
     // 键盘弹出\隐藏后的frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 352}, {320, 216}},
     // 键盘弹出\隐藏所耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     // 键盘弹出\隐藏动画的执行节奏（先快后慢，匀速）
     UIKeyboardAnimationCurveUserInfoKey = 7
     }
     */
//    ZSRLog(@"%@",notification);
    // 如果正在切换键盘，就不要执行后面的代码
//    if (self.switchingKeybaord) return;
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
//        ZSRLog(@"%@", NSStringFromCGRect(self.toolbar.frame));
    }];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 发布带有图片的微博
 */
- (void)sendWithImage
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [ZSRAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        ZSRLog(@"%ld",(unsigned long)data.length);
        ZSRLog(@"%@",self.photosView.photos);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}


/**
 * 发布没有图片的微博
 */
- (void)sendWithoutImage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [ZSRAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}
/**
 * 监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - UITextViewDelegate
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - ZSRComposeToolbarDelegate
- (void)composeToolbar:(ZSRComposeToolbar *)toolbar didClickButton:(ZSRComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case ZSRComposeToolbarButtonTypeCamera: // 拍照
            [self openCamera];
            break;
            
        case ZSRComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case ZSRComposeToolbarButtonTypeMention: // @
            ZSRLog(@"--- @");
            break;
            
        case ZSRComposeToolbarButtonTypeTrend: // #
            ZSRLog(@"--- #");
            break;
            
        case ZSRComposeToolbarButtonTypeEmotion: // 表情\键盘
             [self switchKeyboard];
            break;
    }
}

#pragma mark - 其他方法
/**
 *  切换键盘
 */
- (void)switchKeyboard
{
    // self.textView.inputView == nil : 使用的是系统自带的键盘
    if (self.textView.inputView == nil) { // 切换为自定义的表情键盘
        ZSREmotionKeyboard *emotionKeyboard = [[ZSREmotionKeyboard alloc] init];
        emotionKeyboard.width = self.view.width;
        emotionKeyboard.height = 216;
        self.textView.inputView = emotionKeyboard;
    } else { // 切换为系统自带的键盘
        self.textView.inputView = nil;
    }
    
    // 开始切换键盘
    self.switchingKeybaord = YES;
    
    // 退出键盘
    [self.textView endEditing:YES];
    //    [self.view endEditing:YES];
    //    [self.view.window endEditing:YES];
    //    [self.textView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
        
        // 结束切换键盘
        self.switchingKeybaord = NO;
    });
}
- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework，利用这个框架可以获得手机上的所有相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    //    self.picking = YES;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 添加图片到photosView中
    [self.photosView addPhoto:image];
    
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.picking = NO;
//        });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        self.picking = NO;
    //    });
}
@end