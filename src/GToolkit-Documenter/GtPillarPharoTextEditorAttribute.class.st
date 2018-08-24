Class {
	#name : #GtPillarPharoTextEditorAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#category : 'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtPillarPharoTextEditorAttribute >> affect: aBrText in: anEditorElement [
	| aText aPharoEditorElement |
	
	aText := self textEditorText asRopedText.
	aPharoEditorElement := GtDocumenterUtility newPharoEditorElementFor: aText styler: self newStyler.
	aPharoEditorElement 
		look: GtPillarExpandedPreviewLook;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ].
	^ aPharoEditorElement
]

{ #category : #initialization }
GtPillarPharoTextEditorAttribute >> initialize [
	super initialize.
	self beAppend.
]

{ #category : #'instance creation' }
GtPillarPharoTextEditorAttribute >> newStyler [
	^ BrRBTextStyler new
]

{ #category : #accessing }
GtPillarPharoTextEditorAttribute >> textEditorText [
	<return: #BlText>
	^ self subclassResponsibility 
]
