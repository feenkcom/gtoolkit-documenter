accessing
affect: aBrText in: anEditorElement
	| aText aPharoEditorElement |
	
	aText := self textEditorText asRopedText.
	aPharoEditorElement := GtDocumenterUtility newPharoEditorElementFor: aText styler: self newStyler.
	^ aPharoEditorElement constraintsDo: [ :c |
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent.
			c padding: (BlInsets all: 5).
			c margin: (BlInsets all: 10) ];
		background: Color white;
		effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5).