#import "Kiwi.h"
#import "NumberParser.h"

SPEC_BEGIN(NumberParserSpec)

describe(@"Number Parser", ^{
	
    __block NumberParser *sut;
    
    beforeEach(^{
		
        sut = [[NumberParser alloc] init];
        
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
    
	it(@"should return no numbers for an empty string", ^{
		
		NSArray *expectedResult = @[];
		NSArray *actualResult = [sut parseString:@""];
		
		[[actualResult should] equal:expectedResult];
	});

	it(@"should return one number for a string with one number", ^{
		
		NSArray *expectedResult = @[ @1 ];
		NSArray *actualResult = [sut parseString:@"1"];
		
		[[actualResult should] equal: expectedResult];
	});
	
	it(@"should return two numbers for a string with two numbers", ^{
		
		NSArray *expectedResult = @[ @1, @2 ];
		NSArray *actualResult = [sut parseString:@"1,2"];
		
		[[actualResult should] equal: expectedResult];
	});
	
	it(@"should return numbers for a string with an arbitrary set of numbers", ^{
		
		NSArray *expectedResult = @[ @1, @20, @300, @4000, @50000 ];
		NSArray *actualResult = [sut parseString:@"1,20,300,4000,50000"];
		
		[[actualResult should] equal: expectedResult];
	});

	it(@"should allow newlines as well as commas as separators", ^{
		
		NSArray *expectedResult = @[ @1, @2, @3 ];
		NSArray *actualResult = [sut parseString:@"1\n2,3"];
		
		[[actualResult should] equal: expectedResult];
	});
		
	it(@"should allow a different delimiter to be specified within the string", ^{
		
		NSArray *expectedResult = @[ @1, @2 ];
		NSArray *actualResult = [sut parseString:@"//;\n1;2"];
		
		[[actualResult should] equal: expectedResult];
	});
	
	it(@"should allow multi-character delimiters surrounded by square brackets", ^{
		
		NSArray *expectedResult = @[ @1, @2, @3 ];
		NSArray *actualResult = [sut parseString:@"//[***]\n1***2***3"];
		
		[[actualResult should] equal: expectedResult];
		
	});
	
	it(@"should allow multiple delimiter strings each surrounded by square brackets", ^{
		
		NSArray *expectedResult = @[ @1, @2, @3 ];
		NSArray *actualResult = [sut parseString:@"//[*][%]\n1*2%3"];
		
		[[actualResult should] equal: expectedResult];
		
	});
	
	

});

SPEC_END