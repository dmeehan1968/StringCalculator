StringCalculator
================

An implementation of the [String Calculator Kata](http://osherove.com/tdd-kata-1/) in Objective C using Kiwi Unit Tests and the Single Responsibility Principle

This project is designed to run on the iOS 6.1 simulator.

Full details of the development can be found at http://davemeehan.com/technology/unit-testing/tdd-exercise-a-stringcalculator-in-objective-c

## Branches

The project is current split into 'master' and 'telldontask' branches.

### Master Branch

This is the project as current documented on the blog.  It include the initial refactoring of NumberParser so that it used NSScanner instead of the original string manipulations.

### Telldontask Branch

*Tell Don't Ask* is an programming principle that suggests that you should not query an objects state, but tell it what you want it to do.  Querying state means that you are at risk of performing one of the entities responsibilities on its behalf, and is a violation of the Single Responsibility Principle.

The 'telldontask' branch is a refactoring of the NumberParser to adopt this principle, and also an attempt to implement the 'single level of indentation' principle.  This is less formally recognised, but increases modularity of code by ensuring that the creator does not create heavily nested control structures (if, while, etc) when the focus should be on doing one thing. 

The refactoring of NumberParser gives all methods a single responsibility and makes them void returns.

The code lacks error checking during processing, but this was a recognised requirement of the original exercise.