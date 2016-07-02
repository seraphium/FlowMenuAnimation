//
//  ButtonsView.m
//  FlowMenuAnimation
//
//  Created by Bear on 16/6/23.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ButtonsView.h"
#import "SpecialBtn.h"

@interface ButtonsView ()
{
    NSArray         *_btnArray;
    CAShapeLayer    *_pathLayer;
    UIDynamicAnimator *_animator;
}

@end

@implementation ButtonsView



- (instancetype)initWithFrame:(CGRect)frame btnsArray:(NSArray *)btnArray
{
    self = [super initWithFrame:CGRectMake(0, -frame.size.height, frame.size.width, frame.size.height)];
    
    if (self) {
        self.backgroundColor = [[UIColor brownColor] colorWithAlphaComponent:0.4];
        _btnArray = btnArray;
        _aniamtionDuring = 2.0;
        
        _pathLayer = [CAShapeLayer layer];
        
        if (!_animator) {
            _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        }
    }
    
    return self;
}

- (CGFloat)setXX:(CGFloat)xx
{
    CGFloat reffer_width = 896;
    CGFloat returnXX = 1.0 * xx / reffer_width * self.width;
    
    return returnXX;
}


- (void)showBtnsAnimation
{
    [_animator removeAllBehaviors];
    
    _pathLayer.path = _beizerPath.CGPath;
    _pathLayer.fillColor = [UIColor clearColor].CGColor;
    _pathLayer.strokeColor = [UIColor orangeColor].CGColor;
    _pathLayer.lineWidth = 2.0;
    [self.layer addSublayer:_pathLayer];
    
    CGFloat btn_gap = [self setXX:16];
    for (int i = 0; i < [_btnArray count]; i++) {
        
        SpecialBtn *tempBtn = _btnArray[i];
        [self addSubview:tempBtn];
        
        //  设定初始位置
        [tempBtn setX:(tempBtn.width + btn_gap) * ([_btnArray count] - 1 - i) + btn_gap];
        [tempBtn setY:-tempBtn.height];
        
        //  添加球与球之间的附着行为
        if (i > 0) {
//            UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:_btnArray[i] attachedToItem:_btnArray[i - 1]];
//            [attachmentBehavior setLength:tempBtn.width + btn_gap];
//            [attachmentBehavior setDamping:0.9];
//            [attachmentBehavior setFrequency:1];
//            [_animator addBehavior:attachmentBehavior];
            
        }
        
//        if (i == 0) {
//            UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:tempBtn attachedToAnchor:CGPointMake(self.width / 4.0 * 3, -150)];
//            [_animator addBehavior:attachmentBehavior];
//        }
        
        //  重力行为
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
//        gravityBehavior.gravityDirection = CGVectorMake(-0.5, 1);
        [gravityBehavior addItem:tempBtn];

        //  碰撞行为
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
        //    collisitionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        [collisionBehavior addItem:tempBtn];
        [collisionBehavior addBoundaryWithIdentifier:@"path" forPath:_beizerPath];
        
        //  动力元素行为
        UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[tempBtn]];
        itemBehavior.resistance = 0.2;
        itemBehavior.allowsRotation = YES;
        itemBehavior.angularResistance = 0;
        itemBehavior.friction = 0.5;
        
        
        [_animator addBehavior:gravityBehavior];
        [_animator addBehavior:collisionBehavior];
        [_animator addBehavior:itemBehavior];
    }
    
    
//    [self tempBehavior];
    [self tempBehavior_1];
    
}

- (void)tempBehavior_1
{
    
    UIButton *tempBtn = _btnArray[0];
    
    UIPushBehavior * push = [[UIPushBehavior alloc] initWithItems:@[tempBtn] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(200, tempBtn.centerY);
    push.magnitude = 0.1;
    
    [_animator addBehavior:push];
    
    
    
    
//    __block int i = 0;
//    CGFloat duration = 0.1f;   //间隔时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, duration * NSEC_PER_SEC, 0);
//    dispatch_source_set_event_handler(timer, ^{
//        
//        i++;
//        if (i >= [_btnArray count]) {
//            dispatch_source_cancel(timer);  //执行5次后停止
//            NSLog(@"-- end");
//        }else{
//            NSLog(@"-- Method_C i:%d", i);
//            
//            UIButton *tempBtn = _btnArray[i];
//            
//            UIPushBehavior * push = [[UIPushBehavior alloc] initWithItems:@[tempBtn] mode:UIPushBehaviorModeInstantaneous];
//            push.pushDirection = CGVectorMake(20, tempBtn.centerY);
//            push.magnitude = 0.5;
//            
//            [_animator addBehavior:push];
//        }
//    });
//    dispatch_resume(timer);
}


- (void)tempBehavior
{
    UIButton *tempBtn = _btnArray[0];
    
    UIBezierPath *tempPath = [UIBezierPath bezierPath];
    [tempPath moveToPoint:CGPointMake(0, 100)];
    [tempPath addLineToPoint:CGPointMake(300, 200)];
    [tempPath addLineToPoint:CGPointMake(WIDTH, 200)];
    [tempPath addLineToPoint:CGPointMake(WIDTH, 0)];
    [tempPath addLineToPoint:CGPointMake(0, 0)];
    [tempPath closePath];
    
    CAShapeLayer *_pathLayer1 = [CAShapeLayer layer];
    _pathLayer1.path = tempPath.CGPath;
    _pathLayer1.fillColor = [UIColor clearColor].CGColor;
    _pathLayer1.strokeColor = [UIColor greenColor].CGColor;
    _pathLayer1.lineWidth = 2.0;
    [self.layer addSublayer:_pathLayer1];
    
    UIGravityBehavior * gravityBehavior = [[UIGravityBehavior alloc] init];
    [gravityBehavior addItem:tempBtn];
    UIDynamicItemBehavior * itemBehavior = [[UIDynamicItemBehavior alloc] init];
    itemBehavior.resistance = 0.2;
    UICollisionBehavior * collisitionBehavior = [[UICollisionBehavior alloc] init];
    [collisitionBehavior addItem:tempBtn];
    collisitionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [collisitionBehavior addBoundaryWithIdentifier:@"path" forPath:tempPath];

    [_animator addBehavior:collisitionBehavior];
    [_animator addBehavior:itemBehavior];
    [_animator addBehavior:gravityBehavior];
}

- (void)closeBtnsAniamtion
{

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
