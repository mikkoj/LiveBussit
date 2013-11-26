
#import <UIKit/UIKit.h>
#import "TreJoukkoLiikenneYhteys.h"
#import "HklJoukkoLiikenneYhteys.h"

@interface HaeKulkuNeuvotOperation : NSOperation {
    id target;
    SEL action;
}

- (id)initWithTarget:(id)theTarget 
          withAction:(SEL)theAction;

@end
