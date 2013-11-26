
#import "TreJoukkoLiikenneYhteys.h"
#import "JSON.h"

@interface TreJoukkoLiikenneYhteys ()
@end

@implementation TreJoukkoLiikenneYhteys


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

- (NSArray *)bussienSijainnit
{
	NSURL *url = [NSURL URLWithString:@"http://lissu.tampere.fi/ajax_servers/busLocations.php"];
	
	// haetaan ja parsitaan JSON
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *results = [jsonString JSONValue];
	
	// loopataan bussit läpi ja luodaan kokoelma BussiItemeitä
    NSMutableArray *bussit = [NSMutableArray array];
	for (NSDictionary *jsonItem in results)
	{
        BussiItem *item = [[BussiItem alloc] init];
        item.journeyId = [jsonItem objectForKey:@"journeyId"];
        item.linja = [jsonItem objectForKey:@"lCode"];
        item.suunta = [jsonItem objectForKey:@"bearing"];
        item.latitude = [jsonItem objectForKey:@"y"];
        item.longitude = [jsonItem objectForKey:@"x"];
        [bussit addObject:item];
        [item release];
    }

	return bussit;
}


- (void)dealloc
{
    [super dealloc];
}

@end
