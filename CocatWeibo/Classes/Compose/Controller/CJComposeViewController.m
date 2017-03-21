//
//  CJComposeViewController.m
//  CocatWeibo
//
//  Created by chenjie on 2/24/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJComposeViewController.h"
#import "CJTextView.h"
#import "AFNetworking.h"
#import "CJAccount.h"
#import "CJAccountTool.h"
#import "MBProgressHUD+CJ.h"
#import "CJComposeToolbar.h"
#import "CJComposePhotosView.h"

@interface CJComposeViewController ()<CJComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CJComposePhotosViewDelegate>

@property (nonatomic, weak) UITextView *textView;

@property (nonatomic, weak) CJComposeToolbar *toolbar;

@property (nonatomic, weak) CJComposePhotosView *photosView;

@end

@implementation CJComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolbar];
    
    // 添加photosView
    [self setupPhotosView];
}

- (void)testMiao
{
    NSLog(@"testMiao");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

/**
 *  添加textView
 */
- (void)setupTextView
{
    // 1.添加
    CJTextView *textView = [[CJTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听textView文字改变的通知
    [CJNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3.监听键盘的通知
    [CJNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [CJNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  添加toolbar
 */
- (void)setupToolbar
{
    CJComposeToolbar *toolbar = [[CJComposeToolbar alloc] init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 *  添加photosView
 */
- (void)setupPhotosView
{
    CJComposePhotosView *photosView = [[CJComposePhotosView alloc] init];
    CGFloat photosW = self.textView.frame.size.width;
    CGFloat photosH = self.textView.frame.size.height;
    CGFloat photosY = 80;
    photosView.frame = CGRectMake(0, photosY, photosW, photosH - photosY);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
    self.photosView.delegate = self;
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(CJComposeToolbar *)toolbar didClickedButton:(CJComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case CJComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case CJComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibrary];
            break;
            
        default:
            break;
    }
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
}

#pragma mark - CJComposePhotosView代理

- (void)addPhotoButtonClickedWithComposePhotosView:(CJComposePhotosView *)photosView
{
    [self openPhotoLibrary];
}

/**
 *  监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

- (void)dealloc
{
    [CJNotificationCenter removeObserver:self];
}

#pragma mark - button response
/**
 *  取消
 */
- (void)cancel
{
    [self.textView resignFirstResponder];

    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发微博
 */
- (void)send
{
    [self.textView resignFirstResponder];

    if (self.photosView.totalImages.count)
    {
        [self sendWithImage];
    }
    else
    {
        [self sendWithOutImage];
    }
 
    // 4.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithImage
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [CJAccountTool account].access_token;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 在发送请求之前调用这个block
        // 必须在这里说明要上传哪些文件
        NSArray *images = [self.photosView totalImages];
        
        if ([images count] == 1)
        {
            NSData *data = UIImageJPEGRepresentation([images lastObject], 0.000001);
            // 发送多张图片用同一个name即可（同一个请求参数名字，服务器利用数组接收即可）
            // 上传的参数名
            NSString * name = [NSString stringWithFormat:@"image%d", 1];
            // 上传fileName
            NSString * fileName = [NSString stringWithFormat:@"%@.jpeg", name];

            /*
             1. 要上传的[二进制数据]
             2. 对应网站上[upload.php中]处理文件的[字段"file"]
             3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
            */
            [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/jpeg"];
        }
        else if ([images count] > 1)
        {
            int count = 0;
            for (UIImage *image in images)
            {
                count++;
                NSData *data = UIImageJPEGRepresentation(image, 0.000001);
                
                NSString * name = [NSString stringWithFormat:@"image%d", count];
                NSString * fileName = [NSString stringWithFormat:@"%@.jpg", name];
                
                // 发送多张图片用同一个name即可（同一个请求参数名字，服务器利用数组接收即可）
                [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/jpeg"];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        CJLog(@"获取用户名称请求失败（图片）——%@",error);
    }];
}

- (void)sendWithOutImage
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [CJAccountTool account].access_token;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [MBProgressHUD showSuccess:@"发送成功"];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD showError:@"发送失败"];
      }];
}

@end
