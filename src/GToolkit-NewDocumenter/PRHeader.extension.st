Extension { #name : #PRHeader }

{ #category : #'*GToolkit-NewDocumenter' }
PRHeader >> hideMarkupsInText: aBlRope [
	| aMarkup |
	self level isNumber ifFalse: [ ^ self ].
	aMarkup := self utility startMarkupFor: self.
	self utility 
		hideMarkupsInText: aBlRope 
		start: self start 
		stop: self start + (aMarkup size * self level) - 1
]

{ #category : #'*GToolkit-NewDocumenter' }
PRHeader >> styleTextEditingMode: aBlRope [
	(aBlRope
		from: self start
		to: self stop)
			fontSize: self constants headerFontSize - (self level * self constants headerLevelStep)";
			paragraphMargin: (BlInsets top: 15 left: 20 bottom: 15 right: 20)".
	super styleTextEditingMode: aBlRope
]

{ #category : #'*GToolkit-NewDocumenter' }
PRHeader >> styleTextReadingMode: aBlRope [
	self styleTextEditingMode: aBlRope.
	self hideMarkupsInText: aBlRope.
	super styleTextEditingMode: aBlRope
]
