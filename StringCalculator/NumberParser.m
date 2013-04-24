
#import "NumberParser.h"

@implementation NumberParser

-(NSArray *)parseString:(NSString *)numberString {

	// numbersArray will hold the numbers parsed out of the input string
	
	NSMutableArray *numbersArray = [NSMutableArray array];
	
	// scanner: used to step through and parse data from the input string
	
	NSScanner *scanner = [NSScanner scannerWithString: numberString];
	
	// scanner should not skip any input characters (skips whitespace and newline by default)
	
	[scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@""]];
	
	// singleCharDelimiterSet: define the default characters that act as number delimiters
	
	NSCharacterSet *singleCharDelimiterSet = [NSCharacterSet characterSetWithCharactersInString:@",\n"];
	
	// multiCharDelimiterSet: stores strings to be used as delimiters if defined in the input string
	
	NSMutableArray *multiCharDelimiterArray = nil;
	
	// raiseFormatException: block to simplify exception handling when invalid input is encountered
	
	void (^raiseFormatException)(void) = ^{
		
		[NSException raise:@"NSInternalInconsistencyException" format:@"Invalid characters at %d, \"%@\"", scanner.scanLocation, [numberString substringFromIndex:scanner.scanLocation]];
		
	};
	

	// Test to see if a delimiter specifier is at the start of the input string
	
	if ([scanner scanString:@"//" intoString:NULL]) {
	
		// Look for multi character delimiters to start with
		
		while ([scanner scanString:@"[" intoString:NULL]) {
			
			NSMutableString *stringDelimiter;
		
			// treat all up to the close bracket as the delimiter
			
			if ([scanner scanUpToString: @"]" intoString:&stringDelimiter]) {
			
				// allocate storage for string delimiters if needed
				
				if (multiCharDelimiterArray == nil) {
					
					multiCharDelimiterArray = [NSMutableArray array];
					
				}
				
				// store the new delimiter
				
				[multiCharDelimiterArray addObject:stringDelimiter];
				
			}

			// read the close bracket before going on
			
			if ( ! [scanner scanString: @"]" intoString:NULL]) {

				raiseFormatException();
				
			}
		}
		
		// if string delimiters were NOT encountered, then any characters up to a newline are single character delimiters
		
		if (multiCharDelimiterArray == nil) {
			
			NSMutableString *singleCharDelimiters = [NSMutableString new];
			
			if ([scanner scanUpToString: @"\n" intoString:&singleCharDelimiters]) {
				
				singleCharDelimiterSet = [NSCharacterSet characterSetWithCharactersInString:singleCharDelimiters];
				
			}
		
		}
		
		// by now we should have exhausted delimiters and next in the input string should be a newline

		if ( ! [scanner scanString: @"\n" intoString:NULL]) {
			
			raiseFormatException();
			
		}
	}
	
	// once delimiter specifiers have been process, we should have numbers separated by delimiters until end of input string
	
	while ([scanner isAtEnd] == NO) {
		
		NSInteger number;
		
		// if we get a number from the input string
		
		if ([scanner scanInteger:&number]) {
		
			// add it to the numbers to be returned
			
			[numbersArray addObject:[NSNumber numberWithInt:number]];
			
		} else {
			
			// if it there wasn't a number the input string is invalid
			
			raiseFormatException();
			
		}
		
		// if string delimiters have been specified in the input string
		
		if (multiCharDelimiterArray != nil) {
		
			// try each in turn so that we move onto the next number (if any)
			
			[multiCharDelimiterArray enumerateObjectsUsingBlock:^(NSString *delimiter, NSUInteger idx, BOOL *stop) {
				
				if ([scanner scanString:delimiter intoString:NULL]) {
					*stop = YES;
				}
			}];
			
			// otherwise the next character should be a single delimiter or we are at the end of input
			
		} else if ( ! [scanner scanCharactersFromSet:singleCharDelimiterSet intoString:NULL] && ! [scanner isAtEnd]) {
			
			raiseFormatException();
			
		}
	}
	
	// return an immutable array of the numbers encountered
	
	return [numbersArray copy];
}

@end
