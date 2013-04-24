#import "NumberFilter.h"

@implementation NumberFilter

-(NSArray *)filter:(NSArray *)unfilteredArray {

	NSMutableArray *negativesArray = [NSMutableArray array];
	
	NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:unfilteredArray.count];
	
	[unfilteredArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		
		if ([obj integerValue] < 0) {
			
			[negativesArray addObject:obj];
			
		} else if ([obj integerValue] <= 1000) {
			
			[filteredArray addObject:obj];
			
		}
	}];
	
	
	if (negativesArray.count > 0) {
		
		[NSException raise:@"NSInternalInconsistencyException"  format: @"negatives not allowed %@", [negativesArray componentsJoinedByString:@","] ];
	}

	return filteredArray;
}

@end