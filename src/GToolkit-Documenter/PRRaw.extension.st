Extension { #name : 'PRRaw' }

{ #category : '*GToolkit-Documenter' }
PRRaw >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope
]

{ #category : '*GToolkit-Documenter' }
PRRaw >> styleTextWithoutMarkup: aBlRope [
	| aMarkup |
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	aMarkup := self utility startMarkupFor: self.
	(self gtNodeStyler: aBlRope)
		hide: self start to: self start + aMarkup size - 1;
		hide: self stop - aMarkup size + 1 to: self stop;
		autoHideNode.
]
