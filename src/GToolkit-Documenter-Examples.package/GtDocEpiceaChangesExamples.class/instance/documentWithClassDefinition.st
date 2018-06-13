class definition
documentWithClassDefinition
	<gtExample>
	<label: 'Document with Epicea changes with class definition'>
	| aPillarElement aDocument |
	aPillarElement := self pillarElementWithClassDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 0.
	self flag: 'We should likely remember Epicea document parts'.
	"documentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: documentPart class 
		equals: aClass.
	self assert: documentPart result isNil."
	^ aDocument