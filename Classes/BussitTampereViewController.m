//
//  BussitTampereViewController.m
//  BussitTampere
//
//  Created by Mikko Junnila on 26/01/2011.
//

#import "BussitTampereViewController.h"
#import "BussiItem.h"
#import "BussiAnnotationView.h"
#import "SporaItem.h"
#import "SporaAnnotationView.h"

@implementation BussitTampereViewController

@synthesize titleBar, mapView, haetutKulkuNeuvot, ajastin, locationManager, locateMeItem, locateSwitch, karttaTyyppiValinta;

- (void)dealloc
{
    [titleBar release];
    [mapView release];
    [haetutKulkuNeuvot release];
    [self runTimer:NO];
    [super dealloc];
}

- (void)viewDidLoad
{
    operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue setMaxConcurrentOperationCount:1];
    
    // disable heading
    locateMeItem.headingEnabled = NO;
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 61.48;
    newRegion.center.longitude = 23.78;
    newRegion.span.latitudeDelta = 0.12;
    newRegion.span.longitudeDelta = 0.12;

    [self.mapView setRegion:newRegion animated:NO];
    //mapView.showsUserLocation = YES;
    [self paivitaSijainnit];
}

- (void)viewDidUnload
{
	self.titleBar = nil;
	self.mapView = nil;
}


- (void) viewWillAppear:(BOOL)animated
{
    [self runTimer:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [self runTimer:NO];
}

#pragma mark -
#pragma mark ajastus


- (void) runTimer:(BOOL)inRun
{
    if (inRun)
    {
        if (!ajastin)
        {
            ajastin = [[NSTimer scheduledTimerWithTimeInterval:3.0
                                                        target:self 
                                                      selector:@selector(paivitaSijainnit) 
                                                      userInfo:nil 
                                                       repeats:YES] retain];
        }
        else
        {
            if (ajastin)
            {
                [ajastin invalidate];
                [ajastin release];
                ajastin = nil;
            }
        }
    }
}


#pragma mark -
#pragma mark paikannus ja kartta


- (void)locationManager:(CLLocationManager *)manager 
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
}

- (void)locationManager:(CLLocationManager *)manager 
       didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error description]);
}

- (IBAction)locationSwitchChanged:(id)sender
{
    if ([locateSwitch isOn]) 
    {
        mapView.showsUserLocation = YES;
    }
    else 
    {
        mapView.showsUserLocation = NO;
    }
}

- (IBAction)karttaTyyppiValintaChanged:(id)sender
{
    if (karttaTyyppiValinta.selectedSegmentIndex == 0)
    {
        mapView.mapType = MKMapTypeStandard;
    }
    else if (karttaTyyppiValinta.selectedSegmentIndex == 1)
    {
        mapView.mapType = MKMapTypeSatellite;
    }
    else if (karttaTyyppiValinta.selectedSegmentIndex == 2)
    {
        mapView.mapType = MKMapTypeHybrid;
    }
}


- (void)paivitaSijainnit
{
    HaeKulkuNeuvotOperation *operation = [[HaeKulkuNeuvotOperation alloc] initWithTarget:self
                                                                              withAction:@selector(kulkuNeuvojenSijainnitHaettu:)];
    [operationQueue addOperation:operation];
    [operation release];
}

- (void)kulkuNeuvojenSijainnitHaettu:(NSArray *)kulkuNeuvot
{
    [kulkuNeuvot retain];
    // päivitetään tilanne
    haetutKulkuNeuvot = kulkuNeuvot;
    [self paivitaAnnotaatiot];
}

- (void)paivitaAnnotaatiot
{
    // poistetaan kartalta ensin sellaiset, joita ei enää haetuissa
    for (id<MKAnnotation,KulkuNeuvo> vanhaAnno in mapView.annotations)
    {
        if ([vanhaAnno isKindOfClass:[MKUserLocation class]])
        {
            continue;
        }

        BOOL poistaVanhana = YES;
        for (id<MKAnnotation,KulkuNeuvo> haetAnno in haetutKulkuNeuvot)
        {
            if ([vanhaAnno.journeyId isEqualToString:haetAnno.journeyId])
            {
                poistaVanhana = NO;
                break;
            }
        }

        if (poistaVanhana)
        {
            [mapView removeAnnotation:vanhaAnno];
            continue;
        }
    }
        
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^
    {
        id<MKAnnotation,KulkuNeuvo> olemassaOleva = nil;

        for (id<MKAnnotation,KulkuNeuvo> haettuAnno in haetutKulkuNeuvot)
        {
            // tarkistetaan ensin onko uusi
            BOOL lisattyUutena = YES;
            for (id<MKAnnotation,KulkuNeuvo> mapAnno in mapView.annotations)
            {
                if ([haettuAnno isKindOfClass:[MKUserLocation class]])
                {
                    continue;
                }

                if ([mapAnno.journeyId isEqualToString:haettuAnno.journeyId])
                {
                    olemassaOleva = mapAnno;
                    lisattyUutena = NO;
                    break;
                }
            }
        
            // siirrytään seuraavaan, jos tulee lisätä uutena
            if (lisattyUutena) 
            {
                [mapView addAnnotation:haettuAnno];
                continue;
            }
        
            // olemassa oleva - päivitetään sijaintia ja suuntaa
            olemassaOleva.coordinate = haettuAnno.coordinate;
            olemassaOleva.suunta = haettuAnno.suunta;
            olemassaOleva.title = [NSString stringWithFormat:@"Linja: %@", haettuAnno.linja];
            olemassaOleva.subtitle = [NSString stringWithFormat:@"suunta: %1.f°", [haettuAnno.suunta floatValue]];

            // varmistetaan että myös suuntaa päivitetään
            MKAnnotationView *viewAnnotaatiolle = [mapView viewForAnnotation:olemassaOleva];
            if (viewAnnotaatiolle != nil) {
                [viewAnnotaatiolle setNeedsDisplay];
            }
        }
    } completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark Map View Delegate methods

- (void)mapView:(MKMapView *)map regionDidChangeAnimated:(BOOL)animated
{
    [self paivitaAnnotaatiot];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *AnnotationViewID = @"annotationViewID";
    
    if (annotation == mapView.userLocation) {
        return nil;
    }

    MKAnnotationView *annotationView;

    if ([annotation isKindOfClass:[BussiItem class]])
    {
        annotationView =
        (BussiAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
        if (annotationView == nil)
        {
            annotationView = [[[BussiAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
        }
    }
    else if ([annotation isKindOfClass:[SporaItem class]])
    {
        annotationView =
        (SporaAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        
        if (annotationView == nil)
        {
            annotationView = [[[SporaAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
        }
    }
    
    annotationView.annotation = annotation;
    
    return annotationView;
}

@end
