Extension { #name : #PRExternalLink }

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> browseReferenceFrom: anEvent [ 
	(self utility shouldOpenReference: anEvent) ifFalse: [ ^ self ].
	anEvent consumed: true.
	WebBrowser openOn: self url.
]

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> cursorLeftInText: aBlRope [
	self hasChildren 
		ifTrue: [ self styleTextWithoutMarkupWithCaption: aBlRope ]
		ifFalse: [ self styleTextWithoutMarkupWithoutCaption: aBlRope ].
]

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> doesReferenceExist [
	^ self url isString and: [ self url isNotEmpty ]
]

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> startMarkup [
	^ self utility startMarkupFor: PRLink
]

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> styleTextWithMarkup: aBlRope [
	self utility styleLinkInText: aBlRope forNode: self start: self start + 1 stop: self stop - 1.
	self utility
		subtleMarkupsInText: aBlRope 
		start: self start 
		stop: self start + self startMarkup size - 1.
	self utility
		subtleMarkupsInText: aBlRope 
		start: self stop - self startMarkup size + 1
		stop: self stop
]

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self hasChildren 
		ifTrue: [ self styleTextWithoutMarkupWithCaption: aBlRope ]
		ifFalse: [ self styleTextWithoutMarkupWithoutCaption: aBlRope ].
	self utility styleCursorAttributeInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> styleTextWithoutMarkupWithCaption: aBlRope [
	| aStartIndex aStopIndex |
	aStartIndex := self startMarkup size + self start.
	aStopIndex := self children first stop.
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: self start
		stop: aStartIndex - 1
		forNode: self.
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: aStopIndex + 1
		stop: self stop
		forNode: self.	
]

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> styleTextWithoutMarkupWithoutCaption: aBlRope [
	| aStartIndex aStopIndex aMarkup |
	aMarkup := self startMarkup.
	aStartIndex := self start + aMarkup size.
	aStopIndex := self stop - aMarkup size.
	self utility
		mayHideMarkupsInText: aBlRope
		start: self start
		stop: aStartIndex - 1
		forNode: self.
	self utility
		mayHideMarkupsInText: aBlRope
		start: aStopIndex + 1
		stop: self stop
		forNode: self
]
