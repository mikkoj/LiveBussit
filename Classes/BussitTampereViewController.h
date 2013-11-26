//
//  BussitTampereViewController.h
//  BussitTampere
//
//  Created by Mikko Junnila on 26/01/2011.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "HaeKulkuNeuvotOperation.h"
#import "MTLocateMeBarButtonItem.h"
#import "KulkuNeuvoProtocol.h"


@interface BussitTampereViewController : UIViewController <MKMapViewDelegate,
                                                           CLLocationManagerDelegate>
{
    UINavigationBar *titleBar;
    IBOutlet MKMapView *mapView;

    NSArray *haetutKulkuNeuvot;
    NSOperationQueue *operationQueue;
    NSTimer *ajastin;
    
    CLLocationManager *locationManager;
    MTLocateMeBarButtonItem *locateMeItem;
    
    IBOutlet UISwitch *locateSwitch;
    IBOutlet UISegmentedControl *karttaTyyppiValinta;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *titleBar;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UISwitch *locateSwitch;
@property (nonatomic, retain) IBOutlet UISegmentedControl *karttaTyyppiValinta;

@property (nonatomic, retain) NSArray *haetutKulkuNeuvot;
@property (nonatomic, retain) NSTimer *ajastin;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) MTLocateMeBarButtonItem *locateMeItem;


- (void) paivitaSijainnit;
- (void) paivitaAnnotaatiot;
- (void) kulkuNeuvojenSijainnitHaettu:(NSArray *)kulkuNeuvot;
- (void) runTimer:(BOOL)inRun;
- (IBAction)locationSwitchChanged:(id)sender;
- (IBAction)karttaTyyppiValintaChanged:(id)sender;

@end

