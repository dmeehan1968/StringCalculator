#import "Kiwi.h"
#import "StringCalculator.h"
#import "NumberParser.h"
#import "Mathematics.h"
#import "NumberFilter.h"


SPEC_BEGIN(StringCalculatorSpec)

describe(@"String Calculator", ^{
	
    __block StringCalculator *sut;
    __block id numberParser;
	__block id mathematics;
	__block id numberFilter;
	
	context(@"with mock objects", ^{
		
		beforeEach(^{
			
			numberParser = [KWMock mockForProtocol:@protocol(NumberParser)];
			
			mathematics = [KWMock mockForProtocol:@protocol(Mathematics)];
			
			numberFilter = [KWMock mockForProtocol:@protocol(NumberFilter)];
			
			sut = [[StringCalculator alloc] initWithNumberParser: numberParser andMathematics: mathematics andFilter: numberFilter];
			
		});
		
		afterEach(^{
			
			sut = nil;
		});
		
		it(@"should exist", ^{
			
			[sut shouldNotBeNil];
			
		});
		
		it(@"should coordinate parsing, filtering and summing", ^{
			
			NSString *numberString = @"1,2,-3";
			NSArray *unfilteredNumberArray = @[ @1, @2, @-3 ];
			NSArray *filteredNumberArray = @[ @1, @2 ];
			NSInteger expectedResult = 3;
			
			[[numberParser should] receive:@selector(parseString:)
								 andReturn:unfilteredNumberArray
							 withArguments:numberString];
			
			[[numberFilter should] receive:@selector(filter:) andReturn:filteredNumberArray withArguments:unfilteredNumberArray];
			
			[[mathematics should] receive:@selector(sum:)
								andReturn:theValue(expectedResult)
							withArguments:filteredNumberArray];
			
			NSInteger actualResult = [sut add: numberString];
			
			[[theValue(actualResult) should] equal: theValue(expectedResult)];
			
		});
	});

	context(@"integration tests", ^{
		
		beforeEach(^{
			
			numberParser = [NumberParser new];
			numberFilter = [NumberFilter new];
			mathematics = [Mathematics new];
			sut = [[StringCalculator alloc] initWithNumberParser:numberParser andMathematics:mathematics andFilter:numberFilter];
			
		});
		
		it(@"should sum numbers from a string", ^{
			
			NSInteger actualResult = [sut add:@"1,2,3,4"];
			
			[[theValue(actualResult) should] equal:theValue(10)];
			
		});

		it(@"should ignore values over 1000", ^{
			
			NSInteger actualResult = [sut add:@"1000,1001"];
			
			[[theValue(actualResult) should] equal:theValue(1000)];
			
		});
		
		it(@"should raise an exception if there is a negative number", ^{

			[[theBlock(^{
				[sut add:@"-1"];
			}) should] raise];
		
		});


		
	});

	
    
});

SPEC_END