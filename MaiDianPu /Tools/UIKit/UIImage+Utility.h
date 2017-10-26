//
//  UIImage+Utility.h
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)

/**
 * Capture Video to UIImage with videoURL
 **/
+ (UIImage *)captureImageWithVideoURL:(NSURL *)videoURL;

/**
 * Capture UIView to UIImage
**/
+ (UIImage *)imageWithView:(UIView *)view;

/**
 * Capture UIView to UIImage with Size
 **/
+ (UIImage *)imageWithView:(UIView *)view size:(CGSize)size;

/**
 * return static image for friend profile placeholder image
 **/
+ (UIImage *)staticPlaceholderImage;

/**
 * resize 图片
 **/
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

/**
 * !!Note: Somehow the image captured by device camera will be rotated,
 * this method can fix it to the correct position.
 *
 * @param ratio: ratio < 1 means make image smaller; ration > 1 means bigger
**/
- (UIImage *)rotateAndScaleWithRatio:(CGFloat)ratio;

/**
 * Return gray image
 **/
- (UIImage *)convertToGrayImage;

- (UIImage *)fixOrientation;
//高斯模糊效果,
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
