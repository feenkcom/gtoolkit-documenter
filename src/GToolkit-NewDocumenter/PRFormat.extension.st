Extension { #name : #PRFormat }

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> hideMarkupsInText: aBlRope [
	| aMarkup |
	aMarkup := self utility startMarkupFor: self.

	(aBlRope 
		from: self start
		to: self start + aMarkup size - 1)
			attribute: Gt2HideAttribute uniqueInstance.
	(aBlRope 
		from: self stop - aMarkup size + 1
		to: self stop)
			attribute: Gt2HideAttribute uniqueInstance.
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> styleSubText: aBlRope [
	^ self subclassResponsibility
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> styleTextEditingMode: aBlRope [
	self styleSubText: (aBlRope
		from: self start
		to: self stop).
	super styleTextEditingMode: aBlRope
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFormat >> styleTextReadingMode: aBlRope [
	self styleTextEditingMode: aBlRope.
	self hideMarkupsInText: aBlRope.
	super styleTextEditingMode: aBlRope
]
