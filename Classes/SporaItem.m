
#import "SporaItem.h"

@implementation SporaItem 

@synthesize coordinate, journeyId, title, subtitle, linja, suunta, longitude, latitude;

- (CLLocationCoordinate2D)coordinate
{
    coordinate.latitude = [self.latitude doubleValue];
    coordinate.longitude = [self.longitude doubleValue];
    return coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    latitude = [[NSNumber numberWithDouble:newCoordinate.latitude] retain];
    longitude = [[NSNumber numberWithDouble:newCoordinate.longitude] retain];
}


- (NSString *)title
{
    return [NSString stringWithFormat:@"Linja: %@", self.linja];
}

- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"suunta: %1.f°", [self.suunta floatValue]];
}


@end
