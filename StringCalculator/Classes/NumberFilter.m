#import "NumberFilter.h"

@implementation NumberFilter

-(NSArray *)filter:(NSArray *)unfilteredArray {
	
	// negativesArray: stores any negative numbers encountered in the input array

	NSMutableArray *negativesArray = [NSMutableArray array];
	
	// filteredArray: stores any valid numbers that will be returned
	
	NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:unfilteredArray.count];
	
	// go through the input array
	
	[unfilteredArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
	
		// negatives are noted and will raise an exception
		
		if ([obj integerValue] < 0) {
			
			[negativesArray addObject:obj];
		
			// values over 1000 are ignored and not returned
			
		} else if ([obj integerValue] <= 1000) {
			
			[filteredArray addObject:obj];
			
		}
	}];
	
	// if there are any negatives, raise an exception including which values were encountered
	
	if (negativesArray.count > 0) {
		
		[NSException raise:@"NSInternalInconsistencyException"  format: @"negatives not allowed %@", [negativesArray componentsJoinedByString:@","] ];
	}

	// return an immutable copy of the filtered numbers
	
	return [filteredArray copy];
}

@end