//
//  UIImage+Resize.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
enum {
    enSvResizeScale,            // image scaled to fill 拉伸填充。即不管目标尺寸中宽高的比例如何，我们都将对原图进行拉伸，使之充满整个目标图像
    enSvResizeAspectFit,        // image scaled to fit with fixed aspect. remainder is transparent 保持比例显示。即缩放后尽量使原图最大，同事维持原图本身的比例，剩余区域将会做全透明的填充。这个类似于UIImageView中contentMode中的UIViewContentModeScaleAspectFit模式
    enSvResizeAspectFill,       // image scaled to fill with fixed aspect. some portion of content may be cliped 保持比例填充。即缩放后的图像依旧保持原图比例的基础上进行填充，部分图片可能会被裁剪。这个类似于UIImageView中contentMode中的UIViewContentModeScaleAspectFill模式
};
typedef NSInteger SvResizeMode;
@interface UIImage (Resize)
- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (UIImage *)imageByScalingWithMaxWidth:(CGFloat)maxWidth;

- (UIImage*)resizeImageToSize:(CGSize)newSize resizeMode:(SvResizeMode)resizeMode;
@end
