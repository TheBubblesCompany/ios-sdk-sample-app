//
//  Service.h
//  Bubbles
//
//  Created by Aurélien SEMENCE on 11/10/2017.
//  Copyright © 2017 The Bubbles Company. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This class represents a Service object as it's designed in webservice.
 */
@interface Service : NSObject <NSCoding>

/** The Service identifier */
@property(nonatomic, retain, readonly) NSString *identifier;

/** The Service name */
@property(nonatomic, retain, readonly) NSString *name;

/** The Service fullscreen flag */
@property(nonatomic, assign, readonly) BOOL fullscreen;

/** The Service bridge enable flag */
@property(nonatomic, assign, readonly) BOOL bridgeEnabled;

/** The Service main picto URL */
@property(nonatomic, retain, readonly) NSString *picto;

/** The Service splash screen picto URL */
@property(nonatomic, retain, readonly) NSString *pictoSplashscreen;

/** The Service picto color */
@property(nonatomic, retain, readonly) NSString *pictoColor;

/** The Service description */
@property(nonatomic, retain, readonly) NSString *serviceDescription;

/** The Service URL to open */
@property(nonatomic, retain, readonly) NSString *openUrl;

/** The Service start date */
@property(nonatomic, retain, readonly) NSDate *activeFrom;

/** The Service end date */
@property(nonatomic, retain, readonly) NSDate *activeTo;

/**
 * Initializes object from webservice datas
 *
 * @param serviceData The plain Service datas.
 * @return The Service object.
 */
- (Service *)initFromData:(NSMutableDictionary *)serviceData;

@end
