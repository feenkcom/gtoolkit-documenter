Extension { #name : #PRHeader }

{ #category : #'*GToolkit-Documenter' }
PRHeader >> cursorLeftInText: aBlRope [
	self hideMarkupsInText: aBlRope.
]

{ #category : #'*GToolkit-Documenter' }
PRHeader >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRHeader >> hideMarkupsInText: aBlRope [
	| aMarkup |
	self level isNumber ifFalse: [ ^ self ].
	aMarkup := self utility startMarkupFor: self.
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: self start 
		stop: self start + (aMarkup size * self level) - 1
		forNode: self.
]

{ #category : #'*GToolkit-Documenter' }
PRHeader >> styleTextWithMarkup: aBlRope [
	(aBlRope
		from: self start
		to: self stop)
			fontSize: self constants headerFontSize - (self level * self constants headerLevelStep)";
			paragraphMargin: (BlInsets top: 15 left: 20 bottom: 15 right: 20)".
	super styleTextWithMarkup: aBlRope
]

{ #category : #'*GToolkit-Documenter' }
PRHeader >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithMarkup: aBlRope.
	self hideMarkupsInText: aBlRope.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
