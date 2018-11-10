Class {
	#name : #Gt2EpiceaDiffStencil,
	#superclass : #BrStencil,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'from',
		'to'
	],
	#category : #'GToolkit-NewDocumenter-Epicea'
}

{ #category : #'api - instantiation' }
Gt2EpiceaDiffStencil >> create [
	<return: #RlBope>
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
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BlFontGenericFamilyAttribute monospace } ].
	^ aRopedText
]

{ #category : #accessing }
Gt2EpiceaDiffStencil >> from [
	^ from
]

{ #category : #accessing }
Gt2EpiceaDiffStencil >> from: anObject [
	from := anObject
]

{ #category : #initialization }
Gt2EpiceaDiffStencil >> initialize [
	super initialize.
	from := #'From text'.
	to := #'To text'.
]

{ #category : #accessing }
Gt2EpiceaDiffStencil >> to [
	^ to
]

{ #category : #accessing }
Gt2EpiceaDiffStencil >> to: anObject [
	to := anObject
]
