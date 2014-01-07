

@interface FindDeals : NSObject{
    NSString *location;
}

@property (nonatomic,retain) NSString *location;
@property (nonatomic) NSString *zipCode;
@property (nonatomic) NSMutableArray *deals;



- (FindDeals *)initWithQuery:(NSString *)query;



@end
