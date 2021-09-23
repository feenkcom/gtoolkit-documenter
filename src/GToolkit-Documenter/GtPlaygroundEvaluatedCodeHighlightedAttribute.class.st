Class {
	#name : 'GtPlaygroundEvaluatedCodeHighlightedAttribute',
	#superclass : 'BlTextAttribute',
	#instVars : [
		'paint'
	],
	#category : 'GToolkit-Documenter'
}

{ #category : 'instance creation' }
GtPlaygroundEvaluatedCodeHighlightedAttribute class >> paint: aBlPaint [
	^ self new paint: aBlPaint
]

{ #category : 'drawing' }
GtPlaygroundEvaluatedCodeHighlightedAttribute >> drawBelowOnSpartaCanvas: aCanvas with: aSpan [
	"I render background under text span"
	
	aCanvas stroke
		paint: self paint;
		path: (aCanvas shape line: (aSpan baseline + (2negated@4)) rounded to: (((aSpan width + aSpan baseline x) @ aSpan baseline y) + (2@4) ) rounded);
		width: 0.5;
		draw
]

{ #category : 'comparing' }
GtPlaygroundEvaluatedCodeHighlightedAttribute >> equals: anAnotherAttribute [
	^ self paint = anAnotherAttribute paint
]

{ #category : 'comparing' }
GtPlaygroundEvaluatedCodeHighlightedAttribute >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: self paint hash
]

{ #category : 'accessing' }
GtPlaygroundEvaluatedCodeHighlightedAttribute >> paint [
	^ paint
]

{ #category : 'accessing' }
GtPlaygroundEvaluatedCodeHighlightedAttribute >> paint: aPaint [
	self
		assert: [ paint isNil ]
		description: [ 'I am immutable and can not be modified' ].

	paint := aPaint
]

{ #category : 'printing' }
GtPlaygroundEvaluatedCodeHighlightedAttribute >> printOn: aStream [
	aStream
		nextPutAll: 'evaluated-code: ';
		nextPutAll: self paint printString
]
