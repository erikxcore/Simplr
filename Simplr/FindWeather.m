
#import "FindWeather.h"
#import "RXMLElement.h"

@implementation FindWeather

@synthesize currentTemp, location,currentDay,currentDayHigh,currentDayLo,currentSkyCode,currentSkyText,secondDayTemp,secondDayHigh,secondSkyCode,secondSkyText,secondDayLo,thirdDayTemp,thirdDayHigh,thirdDayLo,thirdSkyCode,thirdSkyText,zipCode,currentURL,secondURL,thirdURL,relativeURL,secondDay,thirdDay,baseURL,currentStringURL,secondStringURL,thirdStringURL;

- (FindWeather *)initWithQuery:(NSString *)query
{
    if (self = [super init])
    {
        
        RXMLElement *rootXML = [[RXMLElement alloc]initFromXMLData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://weather.service.msn.com/data.aspx?weadegreetype=F&culture=en-US&weasearchstr=%@", query]]]];
        if(![rootXML child:@"weather"]){
            
            return nil;
        }
        RXMLElement *weather = [rootXML child:@"weather"];
        RXMLElement *current = [weather child:@"current"];
        NSMutableArray *forecasts = [[NSMutableArray alloc]init];
       [weather iterate:@"forecast" usingBlock:^(RXMLElement *forecast) {
           [forecasts addObject:forecast];
       }];
        
        zipCode = query;
        location = [weather attribute:@"weatherlocationname"];
        relativeURL = [[NSURL alloc]initWithString:[weather attribute:@"imagerelativeurl"]];
        
        currentTemp = [[current attribute:@"temperature"]integerValue];
        currentSkyText = [current attribute:@"skytext"];
        currentSkyCode = [current attribute:@"skycode"];
        currentDay = [current attribute:@"day"];
        baseURL = [weather attribute:@"imagerelativeurl"];
        currentStringURL = [NSString stringWithFormat:@"%@%@%@%@", baseURL,@"/law/",currentSkyCode,@".gif"];
        currentURL = [[NSURL alloc]initWithString:currentStringURL];
        
        
        secondDayLo= [[[forecasts objectAtIndex:1]attribute:@"low"]integerValue];
        secondDayHigh= [[[forecasts objectAtIndex:1]attribute:@"high"]integerValue];
        secondSkyText = [[forecasts objectAtIndex:1]attribute:@"skytextday"];
        secondSkyCode = [[forecasts objectAtIndex:1]attribute:@"skycodeday"];
        secondURL = [[NSURL alloc]initWithString:secondSkyCode relativeToURL:relativeURL];
        secondDay = [[forecasts objectAtIndex:1]attribute:@"day"];
        secondStringURL = [NSString stringWithFormat:@"%@%@%@%@", baseURL,@"/law/",secondSkyCode,@".gif"];
        secondURL = [[NSURL alloc]initWithString:secondStringURL];
        
        thirdDayLo= [[[forecasts objectAtIndex:2]attribute:@"low"]integerValue];
        thirdDayHigh= [[[forecasts objectAtIndex:2]attribute:@"high"]integerValue];
        thirdSkyText = [[forecasts objectAtIndex:2]attribute:@"skytextday"];
        thirdSkyCode = [[forecasts objectAtIndex:2]attribute:@"skycodeday"];
        thirdURL = [[NSURL alloc]initWithString:thirdSkyCode relativeToURL:relativeURL];
        thirdDay = [[forecasts objectAtIndex:2]attribute:@"day"];
        thirdStringURL = [NSString stringWithFormat:@"%@%@%@%@", baseURL,@"/law/",thirdSkyCode,@".gif"];
        thirdURL = [[NSURL alloc]initWithString:thirdStringURL];
        
      //  NSLog(@"Zip is %@, Location is %@, relative URL is %@",zipCode,location,relativeURL);
      //  NSLog(@"Current Temp is %ld, Current Sky Text is %@, Current Skycode is %@, Current URL is %@",(long)currentTemp,currentSkyText,currentSkyCode,currentURL);
      //  NSLog(@"Second Hi Temp is %ld,Second Lo Temp is %ld, Second Sky Text is %@, Second Skycode is %@, Second URL is %@",(long)secondDayHigh,(long)secondDayLo,secondSkyText,secondSkyCode,secondURL);

    }

    return self;
}

- (void)dealloc {    

}

@end
