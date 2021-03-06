//
//  UIImage+Resize.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


//此算法中先找出image宽和高中缩放程度较小者作为整个图片的缩放比例，
//这样必然有一因素（宽或者高）缩放的程度不够，使其超过期望值，我们再
//将图片放入drawInRect函数的rect的中央，最后将超过的那一因素裁剪得到
//缩放后的图片，在使用此函数时应该检查返回值是否为nil
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (UIImage *)imageByScalingWithMaxWidth:(CGFloat)maxWidth{
    if (self.size.width < maxWidth) return self;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (self.size.width > self.size.height) {
        btHeight = maxWidth;
        btWidth = self.size.width * (maxWidth / self.size.height);
    } else {
        btWidth = maxWidth;
        btHeight = self.size.height * (maxWidth / self.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSize:targetSize];
}

- (UIImage*)resizeImageToSize:(CGSize)newSize resizeMode:(SvResizeMode)resizeMode
{
    CGRect drawRect = [self caculateDrawRect:newSize resizeMode:resizeMode];
    
    UIGraphicsBeginImageContext(newSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, newSize.width, newSize.height));
    
    CGContextSetInterpolationQuality(context, 0.8);
    
    [self drawInRect:drawRect blendMode:kCGBlendModeNormal alpha:1];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// caculate drawrect respect to specific resize mode
- (CGRect)caculateDrawRect:(CGSize)newSize resizeMode:(SvResizeMode)resizeMode
{
    CGRect drawRect = CGRectMake(0, 0, newSize.width, newSize.height);
    
    CGFloat imageRatio = self.size.width / self.size.height;
    CGFloat newSizeRatio = newSize.width / newSize.height;
    
    switch (resizeMode) {
        case enSvResizeScale:
        {
            // scale to fill
            break;
        }
        case enSvResizeAspectFit:                    // any remain area is white
        {
            CGFloat newHeight = 0;
            CGFloat newWidth = 0;
            if (newSizeRatio >= imageRatio) {        // max height is newSize.height
                newHeight = newSize.height;
                newWidth = newHeight * imageRatio;
            }
            else {
                newWidth = newSize.width;
                newHeight = newWidth / imageRatio;
            }
            
            drawRect.size.width = newWidth;
            drawRect.size.height = newHeight;
            
            drawRect.origin.x = newSize.width / 2 - newWidth / 2;
            drawRect.origin.y = newSize.height / 2 - newHeight / 2;
            
            break;
        }
        case enSvResizeAspectFill:
        {
            CGFloat newHeight = 0;
            CGFloat newWidth = 0;
            if (newSizeRatio >= imageRatio) {        // max height is newSize.height
                newWidth = newSize.width;
                newHeight = newWidth / imageRatio;
            }
            else {
                newHeight = newSize.height;
                newWidth = newHeight * imageRatio;
            }
            
            drawRect.size.width = newWidth;
            drawRect.size.height = newHeight;
            
            drawRect.origin.x = newSize.width / 2 - newWidth / 2;
            drawRect.origin.y = newSize.height / 2 - newHeight / 2;
            
            break;
        }
        default:
            break;
    }
    
    return drawRect;
}

@end
