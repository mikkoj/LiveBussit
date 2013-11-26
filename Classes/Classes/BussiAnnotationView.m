

#import "BussiAnnotationView.h"
#import "BussiItem.h"
#import <math.h>

@implementation BussiAnnotationView

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
    BussiItem *bussiItem = (BussiItem *)self.annotation;
    if (bussiItem != nil)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 2);
        
        // käännetään koko kontekstin suuntaa bussin suunnan perusteella
        double kaanto = radians([bussiItem.suunta doubleValue]);
        CGContextTranslateCTM(context, 26.0, 25.0);
        CGContextRotateCTM(context, kaanto);        
        CGContextTranslateCTM(context, -26.0, -25.0);
        
        // piirretään suuntanuoli pallon päälle
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 39.0, 20.0);
        CGPathAddLineToPoint(path, NULL, 26.0, 2.0); 
        CGPathAddLineToPoint(path, NULL, 13.0, 20.0); 
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGPathRelease(path);
        
        // piirretään pallo
        path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 10.0, 15.0);
        CGPathAddEllipseInRect(path, NULL, CGRectMake(11.0, 10.0, 30.0, 30.0));

        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGPathRelease(path);

        // piirretään bussin numero pallon sisään
        CGContextTranslateCTM(context, 26.0, 25.0);
        CGContextRotateCTM(context, -kaanto);        
        CGContextTranslateCTM(context, -26.0, -25.0);

        [[UIColor blueColor] set];
        [bussiItem.linja drawInRect:CGRectMake(11.0, 17.0, 30.0, 30.0)
                            withFont:[UIFont systemFontOfSize:12.0]
                       lineBreakMode:UILineBreakModeClip
                           alignment:UITextAlignmentCenter];
    }
}

@end
