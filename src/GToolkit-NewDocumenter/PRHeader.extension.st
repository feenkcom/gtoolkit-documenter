Extension { #name : #PRHeader }

{ #category : #'*GToolkit-NewDocumenter' }
PRHeader >> hideMarkupsInText: aBlRope [
	| aMarkup |
	self level isNumber ifFalse: [ ^ self ].
	aMarkup := self utility startMarkupFor: self.
	(aBlRope 
		from: self start
		to: self start + (aMarkup size * self level) - 1)
			attribute: Gt2HideAttribute uniqueInstance.
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
