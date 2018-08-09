pillar - examples method parameter
twoExistingExampleMethods
	<gtExample>
	| theMethods anArray |
	anArray := #(GtDocumenterExamples>>#referencedMethod GtDocumenterExamples>>#referencedMethodTwo).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 2.
	self assert: theMethods first compiledMethod equals: GtDocumenterExamples>>#referencedMethod.
	self assert: theMethods second compiledMethod equals: GtDocumenterExamples>>#referencedMethodTwo.
	^ theMethods