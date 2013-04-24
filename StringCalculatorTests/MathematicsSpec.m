#import "Kiwi.h"
#import "Mathematics.h"

SPEC_BEGIN(MathematicsSpec)

describe(@"Mathematics", ^{
	
    __block Mathematics *sut;
    
    beforeEach(^{
		
        sut = [[Mathematics alloc] init];
        
    });
    
    afterEach(^{
        
        sut = nil;
    });
    
    it(@"should exist", ^{
        
        [sut shouldNotBeNil];
        
    });
   
	it(@"should return zero for no numbers in array", ^{
		
		NSInteger actualResult = [sut sum:@[] ];
		
		[[theValue(actualResult) should] equal:theValue(0)];
		
	});
	
	it(@"should return value of one number from array", ^{
		
		NSInteger actualResult = [sut sum:@[ @123 ] ];
		
		[[theValue(actualResult) should] equal: theValue(123)];
		
	});
	
	it(@"should return the sum of multiple number values in array", ^{
		
		NSInteger actualResult = [sut sum:@[ @1, @2, @3, @4 ] ];
		
		[[theValue(actualResult) should] equal: theValue(10)];
		
	});
	

});

SPEC_END