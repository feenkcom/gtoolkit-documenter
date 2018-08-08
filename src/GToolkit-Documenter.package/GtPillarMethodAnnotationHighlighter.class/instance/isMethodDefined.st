private - testing
isMethodDefined
	"Return true if a method is defined in the system"
	^ referencedMethod notNil and: [ referencedMethod isDefined ]