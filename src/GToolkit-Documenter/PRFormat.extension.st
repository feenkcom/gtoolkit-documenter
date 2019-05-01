Extension { #name : #PRFormat }

{ #category : #'*GToolkit-Documenter' }
PRFormat >> styleSubText: aBlRope [
	^ self subclassResponsibility
]

{ #category : #'*GToolkit-Documenter' }
PRFormat >> styleTextWithMarkup: aBlRope [
	self styleSubText: (aBlRope
		from: self start
		to: self stop).
	super styleTextWithMarkup: aBlRope
]

{ #category : #'*GToolkit-Documenter' }
PRFormat >> styleTextWithoutMarkup: aBlRope [
	| aMarkup |
	self styleTextWithMarkup: aBlRope.
	super styleTextWithMarkup: aBlRope.
	aMarkup := self utility startMarkupFor: self.
	(self gtNodeStyler: aBlRope)
		hide: self start to: self start + aMarkup size - 1;
		hide: self stop - aMarkup size + 1 to: self stop;
		autoHideNode.
]
