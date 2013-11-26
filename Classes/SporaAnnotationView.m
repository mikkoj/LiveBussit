

#import "SporaAnnotationView.h"
#import "SporaItem.h"
#import <math.h>

@implementation SporaAnnotationView

static inline double radians (double degrees) { return degrees * M_PI/180; }

@synthesize title, subtitle;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
        CGRect frame = self.frame;
        frame.size = CGSizeMake(50.0, 50.0);
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        
        //self.centerOffset = CGPointMake(6.0, 0.0);
        self.calloutOffset = CGPointMake(1.0, 0.0);
        self.canShowCallout = YES;
    }
    return self;
}

- (void)setAnnotation:(id <MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    SporaItem *sporaItem = (SporaItem *)self.annotation;
    if (sporaItem != nil)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 2);
        
        UIColor *sporaVari = [UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0];
        
        // käännetään koko kontekstin suuntaa sporan suunnan perusteella
        double kaanto = radians([sporaItem.suunta doubleValue]);
        CGContextTranslateCTM(context, 26.0, 25.0);
        CGContextRotateCTM(context, kaanto);        
        CGContextTranslateCTM(context, -26.0, -25.0);
        
        // piirretään suuntanuoli pallon päälle
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 39.0, 20.0);
        CGPathAddLineToPoint(path, NULL, 26.0, 2.0); 
        CGPathAddLineToPoint(path, NULL, 13.0, 20.0); 
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, sporaVari.CGColor);
        CGContextSetStrokeColorWithColor(context, sporaVari.CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGPathRelease(path);
        
        // piirretään pallo
        path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 10.0, 15.0);
        CGPathAddEllipseInRect(path, NULL, CGRectMake(11.0, 10.0, 30.0, 30.0));
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetStrokeColorWithColor(context, sporaVari.CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGPathRelease(path);
        
        // piirretään sporan numero pallon sisään
        CGContextTranslateCTM(context, 26.0, 25.0);
        CGContextRotateCTM(context, -kaanto);        
        CGContextTranslateCTM(context, -26.0, -25.0);
        [sporaVari set];
        [sporaItem.linja drawInRect:CGRectMake(11.0, 17.0, 30.0, 30.0)
                            withFont:[UIFont systemFontOfSize:12.0]
                       lineBreakMode:UILineBreakModeClip
                           alignment:UITextAlignmentCenter];
    }
}

@end
