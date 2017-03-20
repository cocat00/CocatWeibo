//
//  CJPhotosView.h
//  CocatWeibo
//
//  Created by chenjie on 1/30/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJPhotosView : UIView

/**
 *  需要展示的图片(数组里面装的都是IWPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;

@end
