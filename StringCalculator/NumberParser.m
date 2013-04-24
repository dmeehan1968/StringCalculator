
#import "NumberParser.h"

@implementation NumberParser

-(NSArray *)parseString:(NSString *)numberString {

	NSMutableArray *numbersArray = [NSMutableArray array];
	
	NSScanner *scanner = [NSScanner scannerWithString: numberString];
	[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@""]];
	
	NSCharacterSet *singleCharDelimiterSet = [NSCharacterSet characterSetWithCharactersInString:@",\n"];
	
	NSMutableArray *multiCharDelimiterArray = nil;
	
	void (^raiseFormatException)(void) = ^{
		
		[NSException raise:@"NSInternalInconsistencyException" format:@"Invalid characters at %d, \"%@\"", scanner.scanLocation, [numberString substringFromIndex:scanner.scanLocation]];
		
	};
	

	if ([scanner scanString:@"//" intoString:NULL]) {
		
		while ([scanner scanString:@"[" intoString:NULL]) {
			
			NSMutableString *stringDelimiter;
			
			if ([scanner scanUpToString: @"]" intoString:&stringDelimiter]) {
				
				if (multiCharDelimiterArray == nil) {
					
					multiCharDelimiterArray = [NSMutableArray array];
					
				}
				
				[multiCharDelimiterArray addObject:stringDelimiter];
				
			}

			if ( ! [scanner scanString: @"]" intoString:NULL]) {

				raiseFormatException();
				
			}
		}
		
		if (multiCharDelimiterArray == nil) {
			
			NSMutableString *singleCharDelimiters = [NSMutableString new];
			
			if ([scanner scanUpToString: @"\n" intoString:&singleCharDelimiters]) {
				
				singleCharDelimiterSet = [NSCharacterSet characterSetWithCharactersInString:singleCharDelimiters];
				
			}
		
		}

		if ( ! [scanner scanString: @"\n" intoString:NULL]) {
			
			raiseFormatException();
			
		}
	}
	
	while ([scanner isAtEnd] == NO) {
		
		NSInteger number;
		
		if ([scanner scanInteger:&number]) {
			
			[numbersArray addObject:[NSNumber numberWithInt:number]];
			
		} else {
			
			raiseFormatException();
			
		}
		
		if (multiCharDelimiterArray != nil) {
			
			[multiCharDelimiterArray enumerateObjectsUsingBlock:^(NSString *delimiter, NSUInteger idx, BOOL *stop) {
				
				if ([scanner scanString:delimiter intoString:NULL]) {
					*stop = YES;
				}
			}];
			
			
		} else if ( ! [scanner scanCharactersFromSet:singleCharDelimiterSet intoString:NULL] && ! [scanner isAtEnd]) {
			
			raiseFormatException();
			
		}
	}
	
	return [numbersArray copy];
}

@end
