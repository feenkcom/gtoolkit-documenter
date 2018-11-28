Extension { #name : #PRFormat }

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> hideMarkupsInText: aBlRope [
	| aMarkup |
	aMarkup := self utility startMarkupFor: self.

	self utility hideMarkupsInText: aBlRope start: self start stop: self start + aMarkup size - 1.
	self utility hideMarkupsInText: aBlRope start: self stop - aMarkup size + 1 stop: self stop.

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
	self hideMarkupsInText: aBlRope.
	super styleTextWithMarkup: aBlRope
]
