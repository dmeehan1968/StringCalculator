#import "Kiwi.h"
#import "NumberFilter.h"

SPEC_BEGIN(NumberFilterSpec)

describe(@"Number Filter", ^{
	
    __block NumberFilter *sut;
    
    beforeEach(^{
		
        sut = [[NumberFilter alloc] init];
        
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
   
	it(@"should raise an exception if a negative number is passed, including each negative number encountered", ^{
		
		[[theBlock(^{
			[sut filter:@[ @1, @2, @-3, @-4, @5 ]];
		}) should] raiseWithName:@"NSInternalInconsistencyException" reason:@"negatives not allowed -3,-4"];
		
	});

	it(@"should ignore values greater than 1000", ^{
		
		NSArray *unfilteredArray = @[ @1000, @1001 ];
		NSArray *expectedResult = @[ @1000 ];
		NSArray *actualResult = [sut filter:unfilteredArray];
		
		[[actualResult should] equal:expectedResult];
	});

});

SPEC_END