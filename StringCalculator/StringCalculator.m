#import "StringCalculator.h"

@implementation StringCalculator

-(id)initWithNumberParser:(id<NumberParser>)numberParser andMathematics:(id<Mathematics>)mathematics andFilter:(id<NumberFilter>)numberFilter {

	if (self = [super init]) {
		_numberParser = numberParser;
		_mathematics = mathematics;
		_numberFilter = numberFilter;
	}
	
	return self;
}

-(NSInteger)add:(NSString *)numberString {

	NSAssert(self.numberParser, @"no parser defined");
	NSAssert(self.mathematics, @"no maths defined");
	NSAssert(self.numberFilter, @"no filter defined");
	
	NSArray *unfilteredNumbers  = [self.numberParser parseString:numberString];
	
	NSArray *filteredNumbers = [self.numberFilter filter:unfilteredNumbers];
	
	return [self.mathematics sum: filteredNumbers];
	
}

@end
