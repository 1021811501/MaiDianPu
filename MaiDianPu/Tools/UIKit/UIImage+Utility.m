//
//  UIImage+Utility.m
//  Study_iOS
//
//  Created by Joe on 16/6/26.
//  Copyright © 2016年 Joe. All rights reserved.
//

#import "UIImage+Utility.h"
#import <AVFoundation/AVFoundation.h>
#import <Accelerate/Accelerate.h>
@implementation UIImage (Utility)

+ (UIImage *)captureImageWithVideoURL:(NSURL *)videoURL {
  AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
  AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
  generate.appliesPreferredTrackTransform = YES;
  NSError *error = NULL;
  CMTime time = CMTimeMake(1, 60);
  CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&error];
  NSLog(@"err==%@, imageRef==%@", error, imgRef);
  
  return [[UIImage alloc] initWithCGImage:imgRef];
}


+ (UIImage *)imageWithView:(UIView *)view {
  return [self imageWithView:view size:view.bounds.size];
}

+ (UIImage *)imageWithView:(UIView *)view size:(CGSize)size {
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

+ (UIImage *)staticPlaceholderImage {
  static UIImage *placeholderImage = nil;
  if (!placeholderImage) {
    placeholderImage = [UIImage imageNamed:@"ico_friend_profile.png"];
  }
  
  return placeholderImage;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
  UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
  [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
  UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return reSizeImage;
}

- (UIImage *)rotateAndScaleWithRatio:(CGFloat)ratio {
  CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
  
  UIGraphicsBeginImageContext(newSize);   // a CGSize that has the size you want
	[self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

- (UIImage *)convertToGrayImage {
  
  // Create image rectangle with current image width/height
  CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
  
  // Grayscale color space
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
  
  // Create bitmap content with current image size and grayscale colorspace
  CGContextRef context = CGBitmapContextCreate(nil, self.size.width, self.size.height, 8, 0, colorSpace, kCGBitmapByteOrderDefault);
  
  // Draw image into current context, with specified rectangle
  // using previously defined context (with grayscale colorspace)
  CGContextDrawImage(context, imageRect, [self CGImage]);
  
  // Create bitmap image info from pixel data in current context
  CGImageRef imageRef = CGBitmapContextCreateImage(context);
  
  // Create a new UIImage object
  UIImage *newImage = [UIImage imageWithCGImage:imageRef];
  
  // Release colorspace, context and bitmap information
  CGColorSpaceRelease(colorSpace);
  CGContextRelease(context);
  CFRelease(imageRef);
  
  // Return the new grayscale image
  return newImage;
}

- (UIImage *)fixOrientation {
  
  // No-op if the orientation is already correct
  if (self.imageOrientation == UIImageOrientationUp) return self;
  
  // We need to calculate the proper transformation to make the image upright.
  // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
  CGAffineTransform transform = CGAffineTransformIdentity;
  
  switch (self.imageOrientation) {
    case UIImageOrientationDown:
    case UIImageOrientationDownMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
      transform = CGAffineTransformRotate(transform, M_PI);
      break;
      
    case UIImageOrientationLeft:
    case UIImageOrientationLeftMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, 0);
      transform = CGAffineTransformRotate(transform, M_PI_2);
      break;
      
    case UIImageOrientationRight:
    case UIImageOrientationRightMirrored:
      transform = CGAffineTransformTranslate(transform, 0, self.size.height);
      transform = CGAffineTransformRotate(transform, -M_PI_2);
      break;
    case UIImageOrientationUp:
    case UIImageOrientationUpMirrored:
      break;
  }
  
  switch (self.imageOrientation) {
    case UIImageOrientationUpMirrored:
    case UIImageOrientationDownMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, 0);
      transform = CGAffineTransformScale(transform, -1, 1);
      break;
      
    case UIImageOrientationLeftMirrored:
    case UIImageOrientationRightMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.height, 0);
      transform = CGAffineTransformScale(transform, -1, 1);
      break;
    case UIImageOrientationUp:
    case UIImageOrientationDown:
    case UIImageOrientationLeft:
    case UIImageOrientationRight:
      break;
  }
  
  // Now we draw the underlying CGImage into a new context, applying the transform
  // calculated above.
  CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                           CGImageGetBitsPerComponent(self.CGImage), 0,
                                           CGImageGetColorSpace(self.CGImage),
                                           CGImageGetBitmapInfo(self.CGImage));
  CGContextConcatCTM(ctx, transform);
  switch (self.imageOrientation) {
    case UIImageOrientationLeft:
    case UIImageOrientationLeftMirrored:
    case UIImageOrientationRight:
    case UIImageOrientationRightMirrored:
      // Grr...
      CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
      break;
      
    default:
      CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
      break;
  }
  
  // And now we just create a new UIImage from the drawing context
  CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
  UIImage *img = [UIImage imageWithCGImage:cgimg];
  CGContextRelease(ctx);
  CGImageRelease(cgimg);
  return img;
}
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur <0.f || blur > 1.f)
    {
        blur = 0.5f;
    }
    //判断曝光度
    int boxSize = (int)(blur * 100);//放大100 小数点后面2位有效
    boxSize = boxSize - (boxSize % 2) + 1;//如果是偶数 变奇数
    CGImageRef img = image.CGImage;//获取图片指针
    vImage_Buffer inBuffer,outBuffer;//获取缓冲区
    vImage_Error error;//一个错误类，调用画图函数的时候调用
    void *pixelBuffer;
    CGDataProviderRef inprovider = CGImageGetDataProvider(img);//放回一个数组图片
    CFDataRef inbitmapData = CGDataProviderCopyData(inprovider);//拷贝数据
    inBuffer.width = CGImageGetWidth(img);//放回位图的宽度
    inBuffer.height = CGImageGetHeight(img);//放回位图的高度
    
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);//算出位图的字节
    
    inBuffer.data = (void*)CFDataGetBytePtr(inbitmapData);//填写图片信息
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));//创建一个空间
    
    if (pixelBuffer == NULL)
    {
        NSLog(@"NO Pixelbuffer");
    }
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error)
    {
        NSLog(@"%zd",error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inbitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    //描述一个矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    
    //渲染上下文
    CGContextFillRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
