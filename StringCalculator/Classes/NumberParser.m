
#import "NumberParser.h"

@interface NumberParser ()

@property (strong, nonatomic) NSScanner *scanner;
@property (strong, nonatomic) NSMutableArray *multiCharacterDelimiters;
@property (strong, nonatomic) NSCharacterSet *singleCharacterDelimiterSet;
@property (strong, nonatomic) NSMutableArray *parsedNumbers;

@end


@implementation NumberParser

-(void) resetParserForString: (NSString *) string {
	
	self.scanner = [[NSScanner alloc] initWithString:string];
	[self.scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@""]];
	self.multiCharacterDelimiters = [NSMutableArray new];
	self.singleCharacterDelimiterSet = [NSCharacterSet characterSetWithCharactersInString:@",\n"];
	self.parsedNumbers = [NSMutableArray new];
	
}

-(NSArray *) parseString: (NSString *) numberString {

	[self resetParserForString: numberString];
	
	[self scanStringForDelimiterSpecification];
	
	[self scanStringForNumbers];
	
	return [self.parsedNumbers copy];
	
}

-(void) scanStringForDelimiterSpecification {
	
	if ([self.scanner scanString:@"//" intoString:nil]) {
		
		[self scanStringForMultiCharacterDelimiters];
		
		[self scanStringForSingleCharacterDelimiters];
		
		[self.scanner scanString:@"\n" intoString:nil];
	}
	
}

-(void) scanStringForMultiCharacterDelimiters {
	
	while ([self.scanner scanString:@"[" intoString:nil]) {
		
		[self scanMultiCharacterDelimiterIntoArray];
		
		[self.scanner scanString: @"]" intoString: nil];
	}
}

-(void) scanMultiCharacterDelimiterIntoArray {
	
	NSMutableString *multiCharacterDelimiter = [NSMutableString new];
	
	[self.scanner scanUpToString:@"]" intoString:&multiCharacterDelimiter];
	
	[self.multiCharacterDelimiters addObject:multiCharacterDelimiter];
	
}

-(void) scanStringForSingleCharacterDelimiters {

	NSMutableString *singleCharacterDelimiterString = [NSMutableString new];
	
	[self.scanner scanUpToString:@"\n" intoString:&singleCharacterDelimiterString];
	
	self.singleCharacterDelimiterSet = [NSCharacterSet characterSetWithCharactersInString:singleCharacterDelimiterString];
	
}

-(void) scanStringForNumbers {
	
	NSInteger number = 0;
	
	while ([self.scanner isAtEnd] == NO && [self.scanner scanInteger:&number]) {
		
		[self.parsedNumbers addObject:[NSNumber numberWithInteger: number]];
		
		[self scanForDelimiter];
		
	}
}

-(void) scanForDelimiter {
	
	if (self.multiCharacterDelimiters.count > 0) {
		
		[self.multiCharacterDelimiters enumerateObjectsUsingBlock:^(NSString *delimiter, NSUInteger idx, BOOL *stop) {
			
			if ([self.scanner scanString:delimiter intoString:nil]) {
				
				*stop = YES;
			}
		}];
		
	} else {
		
		[self.scanner scanCharactersFromSet:self.singleCharacterDelimiterSet intoString:nil];
		
	}
}

@end
