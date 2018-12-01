Extension { #name : #PRFormat }

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> cursorLeftInText: aBlRope [
	self hideMarkupsInText: aBlRope.
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> hideMarkupsInText: aBlRope [
	| aMarkup |
	aMarkup := self utility startMarkupFor: self.

	self utility mayHideMarkupsInText: aBlRope start: self start stop: self start + aMarkup size - 1 forNode: self.
	self utility mayHideMarkupsInText: aBlRope start: self stop - aMarkup size + 1 stop: self stop forNode: self.

]

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> styleSubText: aBlRope [
	^ self subclassResponsibility
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> styleTextWithMarkup: aBlRope [
	self styleSubText: (aBlRope
		from: self start
		to: self stop).
	super styleTextWithMarkup: aBlRope
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithMarkup: aBlRope.
	self hideMarkupsInText: aBlRope.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
