initialization
initializeMethodDefinition
	"Set Ring method definition from a string method definition, e.g., MyClass>>#myMethod"
	| aMethodName |
	aMethodName := self pillarNode methodName.
	aMethodName ifNil: [ ^ self ].
	methodDefinition := GtSystemUtility methodDefinitionFromString: aMethodName