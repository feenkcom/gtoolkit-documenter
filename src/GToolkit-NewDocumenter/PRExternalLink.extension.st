Extension { #name : #PRExternalLink }

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> browseReferenceFrom: anEvent [ 
	(self utility shouldOpenReference: anEvent) ifFalse: [ ^ self ].
	anEvent consumed: true.
	WebBrowser openOn: self url.
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> cursorLeftInText: aBlRope [
	self hasChildren 
		ifTrue: [ self styleTextWithoutMarkupWithCaption: aBlRope ]
		ifFalse: [ self styleTextWithoutMarkupWithoutCaption: aBlRope ].
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> isReferenceDefined [
	^ self url isString and: [ self url isNotEmpty ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> startMarkup [
	^ self utility startMarkupFor: PRLink
]

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self hasChildren 
		ifTrue: [ self styleTextWithoutMarkupWithCaption: aBlRope ]
		ifFalse: [ self styleTextWithoutMarkupWithoutCaption: aBlRope ].
	self utility styleCursorAttributeInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> styleTextWithoutMarkupWithCaption: aBlRope [
	| aStartIndex aStopIndex |
	aStartIndex := self startMarkup size + self start.
	aStopIndex := self children first stop.
	self utility 
		hideMarkupsInText: aBlRope 
		start: self start
		stop: aStartIndex - 1.
	self utility 
		hideMarkupsInText: aBlRope 
		start: aStopIndex + 1
		stop: self stop.
		
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> styleTextWithoutMarkupWithoutCaption: aBlRope [
	| aStartIndex aStopIndex aMarkup |
	aMarkup := self startMarkup.
	aStartIndex := self start + aMarkup size.
	aStopIndex := self stop - aMarkup size.
	self utility
		hideMarkupsInText: aBlRope
		start: self start
		stop: aStartIndex - 1.
	self utility
		hideMarkupsInText: aBlRope
		start: aStopIndex + 1
		stop: self stop
]
