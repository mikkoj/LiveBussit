
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import "KulkuNeuvoProtocol.h"

@interface SporaItem : NSObject <MKAnnotation, KulkuNeuvo>
{
    NSString *journeyId;
    NSString *linja;
    NSNumber *suunta;
    
    NSNumber *latitude;
    NSNumber *longitude;
    
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, retain) NSString *journeyId;
@property (nonatomic, retain) NSString *linja;
@property (nonatomic, retain) NSNumber *suunta;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end
