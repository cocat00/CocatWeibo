//
//  CJTextView.m
//  CocatWeibo
//
//  Created by chenjie on 2/24/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJTextView.h"

@interface CJTextView()

@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation CJTextView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.font = self.font;
        placeholderLabel.backgroundColor = [UIColor clearColor];
//        [self addSubview:placeholderLabel];
        [self insertSubview:placeholderLabel atIndex:0];
        _placeholderLabel = placeholderLabel;
        
        // 监听textView文字改变的通知
        [CJNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    
    return self;
}

- (void)dealloc
{
    [CJNotificationCenter removeObserver:self];
}

/**
 *  监听文字改变
 */
- (void)textDidChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    
    if ([placeholder length] > 0)
    {
        //需要显示
        self.placeholderLabel.hidden = NO;
        
        //计算frame
        CGFloat placeholderX = 5;
        CGFloat placeHolderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        CGFloat maxH = self.frame.size.height - 2 * placeHolderY;
        CGSize placeholderSize = [placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(maxW, maxH)];
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeHolderY, placeholderSize.width, placeholderSize.height);
    }
    else
    {
        self.placeholderLabel.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
}


@end
