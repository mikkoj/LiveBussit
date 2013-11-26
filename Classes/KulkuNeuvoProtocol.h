//
//  KulkuNeuvoProtocol.h
//  BussitTampere
//
//  Created by Mikko Junnila on 31/01/2011.
//

#import <Foundation/Foundation.h>


@protocol KulkuNeuvo

@property (nonatomic, retain) NSString *journeyId;
@property (nonatomic, retain) NSString *linja;
@property (nonatomic, retain) NSNumber *suunta;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end
