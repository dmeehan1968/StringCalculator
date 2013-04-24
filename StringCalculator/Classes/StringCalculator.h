#import <Foundation/Foundation.h>
#import "NumberParser.h"
#import "Mathematics.h"
#import "NumberFilter.h"

@interface StringCalculator : NSObject

@property (weak) id < NumberParser > numberParser;
@property (weak) id < Mathematics > mathematics;
@property (weak) id < NumberFilter > numberFilter;

-(id)initWithNumberParser: (id < NumberParser >)numberParser andMathematics : (id < Mathematics >) mathmatics andFilter: (id <NumberFilter >) numberFilter;

-(NSInteger)add:(NSString *)numberString;

@end
