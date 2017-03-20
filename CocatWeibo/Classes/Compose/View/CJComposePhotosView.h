//
//  CJComposePhotosView.h
//  CocatWeibo
//
//  Created by chenjie on 3/10/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJComposePhotosView;

@protocol CJComposePhotosViewDelegate <NSObject>
@optional

- (void)addPhotoButtonClickedWithComposePhotosView:(CJComposePhotosView *)photosView;

@end

@interface CJComposePhotosView : UIView

@property (nonatomic, weak) id<CJComposePhotosViewDelegate>delegate;

/**
 *  添加一张新的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有的图片
 */
- (NSArray *)totalImages;

@end
