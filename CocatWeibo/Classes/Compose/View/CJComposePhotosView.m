//
//  CJComposePhotosView.m
//  CocatWeibo
//
//  Created by chenjie on 3/10/16.
//  Copyright © 2016 atnv. All rights reserved.
//

#import "CJComposePhotosView.h"

@implementation CJComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        UIButton *addImageButton = [[UIButton alloc] init];
        [addImageButton setBackgroundImage:[UIImage imageWithName:@"compose_pic_add"] forState:UIControlStateNormal];
        [addImageButton setBackgroundImage:[UIImage imageWithName:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
        [addImageButton addTarget:self action:@selector(addbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addImageButton];
    }
    
    return self;
}

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self insertSubview:imageView atIndex:self.subviews.count - 1];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    CGFloat imageViewW = 70;
    CGFloat imageViewH = imageViewW;
    int maxColumns = 4; // 一行最多显示4张图片
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewW) / (maxColumns + 1);
    for (int i = 0; i<count; i++)
    {
        UIImageView *imageView = self.subviews[i];
        
        CGFloat imageViewX = margin + (i % maxColumns) * (imageViewW + margin);
        CGFloat imageViewY = (i / maxColumns) * (imageViewH + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
}

- (NSArray *)totalImages
{
    NSMutableArray *images = [NSMutableArray array];
    
    for (UIImageView *imageView in self.subviews)
    {
        [images addObject:imageView.image];
    }
    
    return images;
}

- (void)addbuttonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPhotoButtonClickedWithComposePhotosView:)])
    {
        [self.delegate addPhotoButtonClickedWithComposePhotosView:self];
    }
}

@end
