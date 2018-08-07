class - missing one
textEditorWithNonExistingClassAnnotation
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self pillarElementWithNonExistingClassAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromPillarElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 9.
	self assert: anAttributes size equals: 4.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextForegroundAttribute.
	self assert: anAttributes third class equals: BrTextHoverAttribute.
	self assert: anAttributes fourth class equals: BrTextClickAttribute.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	^ aBrTextEditor