

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  创建一个拥有2张图片的item
 *
 *  @param image     普通图片
 *  @param highImage 高亮图片
 *  @param target    点击item后会调用target的action方法
 *  @param action    点击item后会调用target的action方法
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
