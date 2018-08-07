accessing
affect: aBrText in: anEditorElement
	| aText aClassDefinitionEditorElement |
	
	aText := self textEditorText asRopedText.
	aClassDefinitionEditorElement := GtDocumenterUtility newPharoEditorElementFor: aText.
	^ aClassDefinitionEditorElement constraintsDo: [ :c |
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent.
			c padding: (BlInsets all: 5).
			c margin: (BlInsets all: 10) ];
		background: Color white;
		effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).