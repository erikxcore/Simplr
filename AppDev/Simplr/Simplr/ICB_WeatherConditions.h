//
//  ICB_WeatherConditions.h
//  LocalWeather
//
//  Created by Matt Tuzzolo on 9/28/10.
//  Copyright 2010 iCodeBlog. All rights reserved.
//

@interface ICB_WeatherConditions : NSObject {
    NSString *location;
    NSInteger currentTemp;
}

@property (nonatomic,retain) NSString *location;
@property (nonatomic) NSInteger currentTemp;

- (ICB_WeatherConditions *)initWithQuery:(NSString *)query;

@end