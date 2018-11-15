Class {
	#name : #Gt2ExamplesStatusLabelAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'total',
		'results',
		'successes',
		'issues'
	],
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #accessing }
Gt2ExamplesStatusLabelAttribute >> affect: aBrText in: anEditorElement [
	| anElement |
	anElement := BrLabel new
		look: (BrGlamorousLabelLook new fontSize: self constants labelFontSize);
		text: self resultLabel.
	anElement margin: (BlInsets left: 5);
		padding:
			(BlInsets
				top: 4
				left: 0
				bottom: 0
				right: 0).
	^ anElement
]

{ #category : #initialization }
Gt2ExamplesStatusLabelAttribute >> initialize [
	super initialize.
	issues := 0.
	results := 0.
	successes := 0.
	total := 0.
]

{ #category : #private }
Gt2ExamplesStatusLabelAttribute >> insertIssuesTo: aRope [
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
Gt2ExamplesStatusLabelAttribute >> insertSkippedTo: aRope [
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
Gt2ExamplesStatusLabelAttribute >> insertSuccessTo: aRope [
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
Gt2ExamplesStatusLabelAttribute >> issues [
	^ issues
]

{ #category : #accessing }
Gt2ExamplesStatusLabelAttribute >> issues: anObject [
	issues := anObject
]

{ #category : #private }
Gt2ExamplesStatusLabelAttribute >> mayInsertSpace: aRope [
	aRope size isZero ifTrue: [ ^ self ].
	aRope 
		insertString: ' '
		at: aRope size.
]

{ #category : #private }
Gt2ExamplesStatusLabelAttribute >> resultLabel [
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
Gt2ExamplesStatusLabelAttribute >> results [
	^ results
]

{ #category : #accessing }
Gt2ExamplesStatusLabelAttribute >> results: anObject [
	results := anObject
]

{ #category : #accessing }
Gt2ExamplesStatusLabelAttribute >> successes [
	^ successes
]

{ #category : #accessing }
Gt2ExamplesStatusLabelAttribute >> successes: anObject [
	successes := anObject
]

{ #category : #accessing }
Gt2ExamplesStatusLabelAttribute >> total [
	^ total
]

{ #category : #accessing }
Gt2ExamplesStatusLabelAttribute >> total: anObject [
	total := anObject
]
