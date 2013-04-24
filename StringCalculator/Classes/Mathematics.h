#import <Foundation/Foundation.h>

@protocol Mathematics <NSObject>

-(NSInteger)sum: (NSArray *) numberArray;

@end

@interface Mathematics : NSObject <Mathematics>

@end