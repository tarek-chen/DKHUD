//
//  HUDContentView.m
//  DKHUD
//
//  Created by easy on 2018/6/22.
//  Copyright © 2018年 简单互娱. All rights reserved.
//

#import "HUDContentView.h"
#import "DKHUDMacro.h"

@interface HUDContentView ()

@property (nonatomic, strong)   UIView *blackView;
@property (nonatomic, strong)   UILabel *textLabel;
@property (nonatomic, strong)   CALayer *shadowLayer;
@property (nonatomic, strong)   UITapGestureRecognizer *tapGes;
@property (nonatomic, strong)   UILongPressGestureRecognizer *longPress;

@end

@implementation HUDContentView
static NSInteger kFont = 13;
static NSInteger kTextTopBottom = 15;
static NSInteger kTextLeftRight = 10;



+ (instancetype)viewWithText:(NSString *)text {
    HUDContentView *contentView = [HUDContentView new];
    [contentView loadGesture];
    contentView.text = text;
    return contentView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setSubviewsFrame];
}

#pragma mark - UI组件
- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [UIView new];
        _blackView.backgroundColor = [UIColor blackColor];
        [self addSubview:_blackView];
    }
    return _blackView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont systemFontOfSize:kFont];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.textAlignment = NSTextAlignmentLeft;
        _textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _textLabel.numberOfLines = 0;
        [self.blackView addSubview:_textLabel];
    }
    return _textLabel;
}

- (CALayer *)shadowLayer {
    if (!_shadowLayer) {
        _shadowLayer = [CALayer layer];
    }
    return _shadowLayer;
}

#pragma mark - 布局微调
static CGFloat heightSingleLine = 0;
- (void)setSubviewsFrame {
    CGFloat blackWidth = DKScreenWidth - 60;
    
    CGFloat textWidth = blackWidth - kTextLeftRight*2;
    CGFloat textHeight = [self textSizeWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) font:kFont text:self.text].height;
    if (heightSingleLine == 0) {
        heightSingleLine = [self textSizeWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) font:kFont text:@"正"].height;
    }
    if (textHeight <= heightSingleLine) {
        textWidth = [self textSizeWithSize:CGSizeMake(CGFLOAT_MAX, textHeight) font:kFont text:self.text].width;
        blackWidth = textWidth + kTextLeftRight*2;
    }
    
    // 计算文字高
    {
        CGFloat allBarHeight = kTopHeight + kTabBarHeight + kSafeAreaBottomHeight;
        CGFloat maxTextHeight = DKScreenHeight - kTextTopBottom *2 - allBarHeight;
        textHeight = textHeight > maxTextHeight ? maxTextHeight : textHeight;
    }
    // 黑色背景frame
    CGRect blacFrame = CGRectMake(0, 0, blackWidth, textHeight +kTextTopBottom*2);
    self.blackView.frame = blacFrame;
    self.blackView.center = self.center;
    
    // 字frame
    CGRect textFrame = CGRectMake(kTextLeftRight, kTextTopBottom, textWidth, textHeight);
    self.textLabel.frame = textFrame;
    [self addShadowToView:_blackView withOpacity:1 shadowRadius:15 andCornerRadius:8];

}

- (CGSize)textSizeWithSize:(CGSize)size font:(CGFloat)font text:(NSString *)text {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize textSize = [text boundingRectWithSize:size  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)   attributes:attribute context:nil].size;
    return textSize;
}

#pragma mark -- 阴影效果
- (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius {
    //////// shadow /////////
    self.shadowLayer.frame = view.layer.frame;
    
    _shadowLayer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _shadowLayer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    _shadowLayer.shadowOpacity = shadowOpacity;//0.8;//阴影透明度，默认0
    _shadowLayer.shadowRadius = shadowRadius;//8;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = _shadowLayer.bounds.size.width;
    float height = _shadowLayer.bounds.size.height;
    float x = _shadowLayer.bounds.origin.x;
    float y = _shadowLayer.bounds.origin.y;
    
    CGPoint topLeft      = _shadowLayer.bounds.origin;
    CGPoint topRight     = CGPointMake(x + width, y);
    CGPoint bottomRight  = CGPointMake(x + width, y + height);
    CGPoint bottomLeft   = CGPointMake(x, y + height);
    
    CGFloat offset = -1.f;
    [path moveToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    [path addArcWithCenter:CGPointMake(topLeft.x + cornerRadius, topLeft.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    [path addLineToPoint:CGPointMake(topRight.x - cornerRadius, topRight.y - offset)];
    [path addArcWithCenter:CGPointMake(topRight.x - cornerRadius, topRight.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 * 3 endAngle:M_PI * 2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomRight.x + offset, bottomRight.y - cornerRadius)];
    [path addArcWithCenter:CGPointMake(bottomRight.x - cornerRadius, bottomRight.y - cornerRadius) radius:(cornerRadius + offset) startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y + offset)];
    [path addArcWithCenter:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y - cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    
    //设置阴影路径
    _shadowLayer.shadowPath = path.CGPath;
    
    //////// cornerRadius /////////
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [view.superview.layer insertSublayer:self.shadowLayer below:view.layer];
}

#pragma mark -  交互
- (void)loadGesture {
    [self addGestureRecognizer:self.tapGes];
    [self addGestureRecognizer:self.longPress];
}

// 点击后使hud消失
- (UITapGestureRecognizer *)tapGes {
    if (!_tapGes) {
        _tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    }
    return _tapGes;
}

// 长按手势 使hud禁止消失，持续展示
- (UILongPressGestureRecognizer *)longPress {
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    }
    return _longPress;
}

#pragma mark - 激活
- (void)showOnView:(UIView *)superView {
    [superView addSubview:self];
    self.frame = superView.bounds;
    self.alpha = 1;
    self.textLabel.text = self.text;
    [self setSubviewsFrame];
}

- (void)dismiss {
    [self dismiss:nil];
}

- (void)dismiss:(UIGestureRecognizer *)ges {
    // 长按手势松开前，将持续性展示提示信息
    UIGestureRecognizerState state = _longPress.state;
    if (UIGestureRecognizerStateBegan == state ||
        UIGestureRecognizerStateChanged == state) {
        return;
    }
    [UIView animateWithDuration:.5f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dismissAfterDelay:(CGFloat)delay {
    [self performSelector:@selector(dismiss:) withObject:nil afterDelay:delay];
}

@end
