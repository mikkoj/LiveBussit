

#import "HaeKulkuNeuvotOperation.h"

@implementation HaeKulkuNeuvotOperation

- (id)initWithTarget:(id)theTarget 
          withAction:(SEL)theAction
{
    self = [super init];
    if (self) {
        target = theTarget;
        action = theAction;
    }
    return self;
}

- (void)dealloc
{    
    [super dealloc];
}

- (void)main
{
    // haetaan Tampereen bussit
    NSArray *treBussit = [[TreJoukkoLiikenneYhteys instanssi] bussienSijainnit];

    // haetaan Helsingin bussit ja sporat
    NSArray *hkiBussitJaSporat = [[HklJoukkoLiikenneYhteys instanssi] kulkuNeuvojenSijainnit];
    
    // muodostetaan tulos
    NSMutableArray *tulos = [NSMutableArray array];
    [tulos addObjectsFromArray:treBussit];
    [tulos addObjectsFromArray:hkiBussitJaSporat];
    
    // kutsutaan main threadin selectoria
    if (target && !self.isCancelled)
    {
        [target performSelectorOnMainThread:action withObject:tulos waitUntilDone:NO];
    }
}

@end
