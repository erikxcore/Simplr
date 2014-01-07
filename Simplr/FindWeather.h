
@interface FindWeather : NSObject {
    NSString *location;
    NSInteger currentTemp;
}

@property (nonatomic,retain) NSString *location;
@property (nonatomic) NSInteger currentTemp;
@property (nonatomic) NSString *currentSkyText;
@property (nonatomic) NSString *currentDay;
@property (nonatomic) NSString *currentSkyCode;
@property (nonatomic) NSInteger currentDayLo;
@property (nonatomic) NSInteger currentDayHigh;
@property (nonatomic) NSString *secondSkyCode;
@property (nonatomic) NSInteger secondDayLo;
@property (nonatomic) NSInteger secondDayHigh;
@property (nonatomic) NSString *secondSkyText;
@property (nonatomic) NSInteger secondDayTemp;
@property (nonatomic) NSInteger thirdDayLo;
@property (nonatomic) NSInteger thirdDayHigh;
@property (nonatomic) NSString *thirdSkyCode;
@property (nonatomic) NSString *thirdSkyText;
@property (nonatomic) NSInteger thirdDayTemp;
@property (nonatomic) NSString *zipCode;
@property (nonatomic) NSURL *relativeURL;
@property (nonatomic) NSURL *currentURL;
@property (nonatomic) NSURL *secondURL;
@property (nonatomic) NSURL *thirdURL;
@property (nonatomic) NSString *baseURL;
@property (nonatomic) NSString *currentStringURL;
@property (nonatomic) NSString *secondStringURL;
@property (nonatomic) NSString *thirdStringURL;
@property (nonatomic) NSString *secondDay;
@property (nonatomic) NSString *thirdDay;

- (FindWeather *)initWithQuery:(NSString *)query;

@end