//
//  UIView+QM.m
//  AppFrame
//

#import "UIView+QM.h"
#import "UIKitGlobalHeader.h"

#import "NSString+QM.h"
#import "UIKitGlobalHeader.h"

@implementation UIView (QM)

- (UIViewController *)rootViewcontroller
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
    CGRect frame = CGRectMake(0, 0, targetSize.width, targetSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = frame;
    layer.path = path.CGPath;
    
    self.layer.mask = layer;
}

- (void)hyb_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius {
    [self hyb_addCorner:corner cornerRadius:cornerRadius size:self.bounds.size];
}

- (void)hyb_addCornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
    [self hyb_addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius size:targetSize];
}

- (void)hyb_addCornerRadius:(CGFloat)cornerRadius {
    [self hyb_addCorner:UIRectCornerAllCorners cornerRadius:cornerRadius];
}

+ (UIView *)configFinishTableFooterVieWithTableView:(UITableView *)tableView {
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20*kWidthScale+9*kFontTimes)];
    view.backgroundColor = kColorWith_RGB_Hex(0xf5f5f5);
    
    UIView * lineLabel = [UIView configLineViewWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.5)];
    [view addSubview:lineLabel];
    
    UILabel * label = [UILabel new];
    label.text = @"已显示全部内容";
    label.font = kFont(9);
    CGFloat width = [label.text getWidthWithSize:CGSizeMake(tableView.frame.size.width, 9*kFontTimes) andFont:kFont(9)];
    label.frame = CGRectMake((tableView.frame.size.width-width)/2.0, 10*kWidthScale, width, 9*kFontTimes);
    label.textColor = kColorWith_RGB_Hex(0xcccccc);
    [view addSubview:label];
    
    for (NSInteger i=0; i<2; i++) {
        UIView * lineLabel = [UIView configLineViewWithFrame:CGRectMake(label.frame.origin.x-12*kWidthScale-5*kWidthScale+(width+22*kWidthScale)*i, view.frame.size.height/2-0.4, 12*kWidthScale, 0.4)];
        [view addSubview:lineLabel];
    }
    
    return view;
}

+ (UIView *)configLineViewWithFrame:(CGRect)frame {
    UIView * label = [[UIView alloc]init];
    label.frame = frame;
    label.backgroundColor = kColorWith_RGB_Hex(0xf0f0f0);
    return label;
}

+ (UIView *)configSpaceViewWithFrame:(CGRect)frame {
    UIView * label = [[UIView alloc]init];
    label.frame = frame;
    label.backgroundColor = kColorWith_RGB_Hex(0xf5f5f5);
    
    [label addSubview:[self configLineViewWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 0.4)]];
    
    return label;
}

+ (UIView *)configSpaceViewWithLineFrame:(CGRect)frame {
    UIView * label = [[UIView alloc]init];
    label.frame = frame;
    label.backgroundColor = kColorWith_RGB_Hex(0xf5f5f5);
    
    [label addSubview:[self configLineViewWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 0.5)]];
    [label addSubview:[self configLineViewWithFrame:CGRectMake(0, CGRectGetHeight(frame)-0.5, KSCREEN_WIDTH, 0.5)]];

    return label;
}

//虚线填充
//lineLength线宽 lineSpacing线间距 lineColor线颜色
+ (void)drawDashLine:(UIView *)lineView pointArray:(NSArray *)pointArr lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为lineColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:0.5];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint point = CGPointFromString(pointArr[0]);
    CGPathMoveToPoint(path, NULL, point.x, point.y);

    for (NSInteger i=1; i<pointArr.count; i++) {
        CGPoint point = CGPointFromString(pointArr[i]);
        CGPathAddLineToPoint(path, NULL, point.x, point.y);
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


// view分类方法
- (UIViewController *)belongViewController {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


- (void)hideBgView:(UIGestureRecognizer *)gesture {
    if (CGRectContainsPoint(CGRectMake((KSCREEN_WIDTH-235*kWidthScale)/2, (kMainScreenHeight-110*kWidthScale)/2, 235*kWidthScale, 110*kWidthScale), [gesture locationInView:gesture.view])) {
        
    } else {
        [gesture.view removeFromSuperview];
    }
}

@end
