
#import "HklJoukkoLiikenneYhteys.h"

@interface HklJoukkoLiikenneYhteys ()
@end

@implementation HklJoukkoLiikenneYhteys


+ (id)instanssi
{
	static id master = nil;
    
	@synchronized(self)
	{
		if (master == nil)
			master = [self new];
	}
    
    return master;
}

- (NSArray *)kulkuNeuvojenSijainnit
{
	NSURL *url = [NSURL URLWithString:@"http://transport.wspgroup.fi/hklkartta/Query.aspx?type=vehicles&lat1=59.9288719522368&lat2=60.489027463756855&lng1=24.454193115234375&lng2=25.404510498046875&online=1&localdata=hkl&a=0.8203531031031162"];
	
    NSString *resultString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *kulkuNeuvot = [resultString componentsSeparatedByString:@"\n"];
	
    NSMutableArray *palautettavat = [NSMutableArray array];
	for (NSString *kulkuNeuvoString in kulkuNeuvot)
	{
        NSArray *kulkuNeuvonTiedot = [kulkuNeuvoString componentsSeparatedByString:@";"];
        if ([kulkuNeuvonTiedot count] < 5) {
            continue;
        }
        
        NSString *kulkuNeuvoId = [kulkuNeuvonTiedot objectAtIndex:0];
        if ([kulkuNeuvoId hasPrefix:@"RHKL"])
        {
            SporaItem *item = [[SporaItem alloc] init];
            item.journeyId = kulkuNeuvoId;
            
            // karsitaan 10 linjan alusta pois
            NSString *linjaString = [[kulkuNeuvonTiedot objectAtIndex:1] substringFromIndex:2];
            item.linja = linjaString;
            item.longitude = [kulkuNeuvonTiedot objectAtIndex:2];
            item.latitude = [kulkuNeuvonTiedot objectAtIndex:3];
            item.suunta = [kulkuNeuvonTiedot objectAtIndex:4];
            [palautettavat addObject:item];
            [item release];
        }
        else if ([kulkuNeuvoId hasPrefix:@"H"])
        {
            BussiItem *item = [[BussiItem alloc] init];
            item.journeyId = kulkuNeuvoId;
            
            NSString *linjaString = [kulkuNeuvonTiedot objectAtIndex:0];
            item.linja = linjaString;
            item.longitude = [kulkuNeuvonTiedot objectAtIndex:2];
            item.latitude = [kulkuNeuvonTiedot objectAtIndex:3];
            item.suunta = [kulkuNeuvonTiedot objectAtIndex:4];
            [palautettavat addObject:item];
            [item release];
        }
    }
    
	return palautettavat;
}


- (void)dealloc
{
    [super dealloc];
}

@end
