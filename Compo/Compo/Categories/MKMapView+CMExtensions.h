//
//  MKAnnotationView+CMExtensions.h
//  Compo
//
//  Created by Anton Rayev on 4/24/14.
//  Copyright (c) 2014 Anton Rayev. All rights reserved.
//

@interface MKMapView (CMExtensions)

- (id)pinForClass:(Class)class withAnnotation:(id<MKAnnotation>)annotation;

@end
