Class {
	#name : #GtEpiceaDiffStencil,
	#superclass : #BrStencil,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'from',
		'to'
	],
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #accessing }
GtEpiceaDiffStencil class >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtEpiceaDiffStencil >> constants [
	^ GtDocumentConstants
]

{ #category : #'api - instantiation' }
GtEpiceaDiffStencil >> create [
	<return: #BlRope>
	| aBuilder aRopedText |
	aBuilder := PrettyTextDiffBuilder 
		from: self from 
		to: self to.
	aRopedText := '' asRopedText.
	aBuilder
		patchSequenceDoIfMatch: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			"(aRopedText from: aRopedText size to: aRopedText size)
				attribute: (Gt2EpiceaDiffAttribute new beMatch)."
			aRopedText insertString: string at: aRopedText size.
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: self constants matchLineColor.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifInsert: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			"(aRopedText from: aRopedText size to: aRopedText size)
				attribute: (Gt2EpiceaDiffAttribute new beInsert)."
			aRopedText insertString: string at: aRopedText size.
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: self constants insertLineColor.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifRemove: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			"(aRopedText from: aRopedText size to: aRopedText size)
				attribute: (Gt2EpiceaDiffAttribute new beRemove)."
			aRopedText insertString: string at: aRopedText size.
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: self constants removeLineColor.
			aRopedText insertString: String cr at: aRopedText size. ].
	aRopedText isEmpty ifFalse: [ aRopedText glamorousCodeFontAndSize ].
	^ aRopedText
]

{ #category : #accessing }
GtEpiceaDiffStencil >> from [
	^ from
]

{ #category : #accessing }
GtEpiceaDiffStencil >> from: anObject [
	from := anObject
]

{ #category : #initialization }
GtEpiceaDiffStencil >> initialize [
	super initialize.
	from := #'From text'.
	to := #'To text'.
]

{ #category : #accessing }
GtEpiceaDiffStencil >> to [
	^ to
]

{ #category : #accessing }
GtEpiceaDiffStencil >> to: anObject [
	to := anObject
]
