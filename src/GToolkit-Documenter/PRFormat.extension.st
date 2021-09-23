Extension { #name : 'PRFormat' }

{ #category : '*GToolkit-Documenter' }
PRFormat >> styleSubText: aBlRope [
	^ self subclassResponsibility
]

{ #category : '*GToolkit-Documenter' }
PRFormat >> styleTextWithMarkup: aBlRope [
	self styleSubText: (aBlRope
		from: self start
		to: self stop).
	super styleTextWithMarkup: aBlRope
]

{ #category : '*GToolkit-Documenter' }
PRFormat >> styleTextWithoutMarkup: aBlRope [

	self styleTextWithMarkup: aBlRope.
	(self gtNodeStyler: aBlRope)
		hide: self start to: children first start - 1;
		hide: children last stop + 1 to: self stop;
		autoHideNode.
]
