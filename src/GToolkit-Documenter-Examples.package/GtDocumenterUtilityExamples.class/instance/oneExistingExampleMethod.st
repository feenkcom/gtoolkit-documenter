pillar - examples method parameter
oneExistingExampleMethod
	<gtExample>
	| theMethods anArray |
	anArray := #(GtDocumenterExamples>>#referencedMethod).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 1.
	self assert: theMethods first compiledMethod equals: GtDocumenterExamples>>#referencedMethod.
	^ theMethods