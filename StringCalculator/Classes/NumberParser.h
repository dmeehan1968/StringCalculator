#import <Foundation/Foundation.h>

@protocol NumberParser <NSObject>

-(NSArray *)parseString: (NSString *) numberString;

@end

@interface NumberParser : NSObject <NumberParser>

@end