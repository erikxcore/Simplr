#import <Foundation/Foundation.h>


@interface FindPlaces : NSObject{
    NSString *location;
    NSMutableData *responseData;
    NSDictionary *JSON1 ;
}

@property (nonatomic,retain) NSString *location;
@property (nonatomic) NSString *zipCode;
@property (nonatomic) NSMutableArray *places;
@property (nonatomic) NSMutableArray *address;



- (FindPlaces *)initWithQuery:(NSString *)query;


@end