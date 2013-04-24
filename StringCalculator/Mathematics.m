#import "Mathematics.h"

@implementation Mathematics

-(NSInteger)sum:(NSArray *)numberArray {
	
	__block NSInteger sum = 0;
	
	[numberArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		
		sum += [obj integerValue];
		
	}];
	
	return sum;
}

@end