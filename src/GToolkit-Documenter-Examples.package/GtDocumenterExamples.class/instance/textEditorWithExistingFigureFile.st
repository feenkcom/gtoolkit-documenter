figure - existing file
textEditorWithExistingFigureFile
	<gtExample>
	| aTextElement aBrTextEditor anAttributes |
	aTextElement := self textElementWithExistingFigureFile.
	aBrTextEditor := GtDocumenterExamplesUtility editorFromTextElement: aTextElement.
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 3.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	self assert: anAttributes third class equals: GtPillarPictureAttribute.
	^ aBrTextEditor