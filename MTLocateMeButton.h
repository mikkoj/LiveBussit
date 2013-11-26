//
//  MTLocateMeButton.h
//
//  Created by Matthias Tretter on 21.01.11.
//  Copyright (c) 2009-2011  Matthias Tretter, @myell0w. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "MTLocationDefines.h"


@interface MTLocateMeButton : UIButton {
	// Current Location-State of the Button
	MTLocationStatus locationStatus_;

	// Subview: activity indicator is shown during MTLocationStatusSearching
	UIActivityIndicatorView* activityIndicator_;
	// Subview: Holds image that is shown in all other LocationStati
	UIImageView *imageView_;
	// the size of an image displayed in the imageView
	CGSize imageSize_;

	// the currently displayed sub-view
	UIView *activeSubview_;

	BOOL headingEnabled_;
}

@property (nonatomic, assign) MTLocationStatus locationStatus;
@property (nonatomic, assign) BOOL headingEnabled;

- (void)setLocationStatus:(MTLocationStatus)locationStatus animated:(BOOL)animated;

@end
