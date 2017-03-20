//
//  CJComposeToolbar.h
//  CocatWeibo
//
//  Created by chenjie on 3/1/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJComposeToolbar;

typedef enum {
    CJComposeToolbarButtonTypeCamera,
    CJComposeToolbarButtonTypePicture,
    CJComposeToolbarButtonTypeMention,
    CJComposeToolbarButtonTypeTrend,
    CJComposeToolbarButtonTypeEmotion
} CJComposeToolbarButtonType;

@protocol CJComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(CJComposeToolbar *)toolbar didClickedButton:(CJComposeToolbarButtonType)buttonType;
@end

@interface CJComposeToolbar : UIView

@property (weak, nonatomic) id<CJComposeToolbarDelegate> delegate;

@end

