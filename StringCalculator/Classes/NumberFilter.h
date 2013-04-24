#import <Foundation/Foundation.h>

@protocol NumberFilter <NSObject>

-(NSArray *)filter: (NSArray *)unfilteredArray;

@end

@interface NumberFilter : NSObject <NumberFilter>

@end