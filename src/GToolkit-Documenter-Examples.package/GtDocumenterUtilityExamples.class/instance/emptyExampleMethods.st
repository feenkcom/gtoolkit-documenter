pillar - examples method parameter
emptyExampleMethods
	<gtExample>
	| theMethods anArray |
	anArray := #().
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 0.
	^ theMethods