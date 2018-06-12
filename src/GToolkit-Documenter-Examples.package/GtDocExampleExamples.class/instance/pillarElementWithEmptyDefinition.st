empty example definition
pillarElementWithEmptyDefinition
	<gtExample>
	<label: 'Pillar element with an example with empty definition'>
	| fileReference pillarElement aCatchedException |
	fileReference := self fileReferenceWithEmptyDefinition.
	self flag: 'We should handle PRError differently'.
	aCatchedException := nil.
	[ 
		pillarElement := GtDocumenterExamplesUtility 
			pillarElementForPillarFileReference: fileReference.
	] on: PRError do: [ :anException | 
		aCatchedException := anException ].
	self assert: aCatchedException notNil.
	self assert: aCatchedException class equals: PRError.
	^ aCatchedException
	"(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement"