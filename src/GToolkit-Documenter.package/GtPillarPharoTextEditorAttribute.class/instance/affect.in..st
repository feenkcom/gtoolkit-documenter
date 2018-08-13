accessing
affect: aBrText in: anEditorElement
	| aText aPharoEditorElement |
	
	aText := self textEditorText asRopedText.
	aPharoEditorElement := GtDocumenterUtility newPharoEditorElementFor: aText styler: self newStyler.
	aPharoEditorElement 
		look: GtPillarExpandedPreviewLook;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	^ aPharoEditorElement