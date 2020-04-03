Class {
	#name : #GtExamplesStatusLabelAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'total',
		'results',
		'successes',
		'issues'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #accessing }
GtExamplesStatusLabelAttribute class >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	| anElement |
	anElement := BrLabel new
		look: (BrGlamorousLabelLook new fontSize: self constants labelFontSize);
		text: self resultLabel.
	anElement margin: (BlInsets left: 5);
		padding:
			(BlInsets
				top: 1
				left: 0
				bottom: 0
				right: 0).
	^ anElement
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> constants [
	^ GtDocumentConstants
]

{ #category : #initialization }
GtExamplesStatusLabelAttribute >> initialize [
	super initialize.
	issues := 0.
	results := 0.
	successes := 0.
	total := 0.
]

{ #category : #private }
GtExamplesStatusLabelAttribute >> insertIssuesTo: aRope [
	| aStartIndex |
	self issues isZero ifTrue: [ ^ self ].
	self mayInsertSpace: aRope.
	aStartIndex := aRope size + 1.
	aRope 
		insertString: (self issues asString, ' issues')
		at: aRope size.
	(aRope from: aStartIndex to: aRope size)
			foreground: self constants errorColor
]

{ #category : #private }
GtExamplesStatusLabelAttribute >> insertSkippedTo: aRope [
	| aSkipped aStartIndex |
	aSkipped := (self total - self results).
	aSkipped isZero ifTrue: [ ^ self ].
	self mayInsertSpace: aRope.
	aStartIndex := aRope size + 1.
	aRope 
		insertString: (aSkipped asString, ' skipped')
		at: aRope size.
	(aRope from: aStartIndex to: aRope size)
			foreground: self constants notAvailableColor
]

{ #category : #private }
GtExamplesStatusLabelAttribute >> insertSuccessTo: aRope [
	| aStartIndex |
	self successes isZero ifTrue: [ ^ self ].
	self mayInsertSpace: aRope.
	aStartIndex := aRope size + 1.
	aRope 
		insertString: (self successes asString, ' successes')
		at: aRope size.
	(aRope from: aStartIndex to: aRope size)
			foreground: self constants successColor
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> issues [
	^ issues
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> issues: anObject [
	issues := anObject
]

{ #category : #private }
GtExamplesStatusLabelAttribute >> mayInsertSpace: aRope [
	aRope size isZero ifTrue: [ ^ self ].
	aRope 
		insertString: ' '
		at: aRope size.
]

{ #category : #private }
GtExamplesStatusLabelAttribute >> resultLabel [
	| aRope |
	aRope := '' asRopedText.
	self insertSuccessTo: aRope.
	self insertIssuesTo: aRope.
	self insertSkippedTo: aRope.
	^ aRope isEmpty 
		ifFalse: [ aRope ]
		ifTrue: [ 'N/A' asRopedText foreground: self constants notAvailableColor ]
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> results [
	^ results
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> results: anObject [
	results := anObject
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> successes [
	^ successes
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> successes: anObject [
	successes := anObject
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> total [
	^ total
]

{ #category : #accessing }
GtExamplesStatusLabelAttribute >> total: anObject [
	total := anObject
]
