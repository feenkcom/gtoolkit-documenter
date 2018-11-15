Extension { #name : #PRExternalLink }

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> browseReferenceFrom: anEvent [ 
	(self utility shouldOpenReference: anEvent) ifFalse: [ ^ self ].
	anEvent consumed: true.
	WebBrowser openOn: self url.
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
PRExternalLink >> styleText: aBlRope [
	(aBlRope
		from: self start
		to: self stop)
			foreground: Gt2DocumentConstants linkColor;
			attributes: { 
				BrTextHoverStylableAttribute new 
					attribute: (BlTextUnderlineAttribute new paint: Gt2DocumentConstants linkColor).
				BrTextClickAttribute new 
					action: [ :aText :aTarget :anEditorElement :anEvent | 
						anEvent modifiers isShift ifFalse: [
							WebBrowser openOn: self url ] ]
			 }
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> styleTextEditingMode: aBlRope [
	self utility styleLinkInText: aBlRope forNode: self start: self start + 1 stop: self stop - 1.
	self utility
		sublteMarkupsInText: aBlRope 
		start: self start 
		stop: self start + self startMarkup size - 1.
	self utility
		sublteMarkupsInText: aBlRope 
		start: self stop - self startMarkup size + 1
		stop: self stop
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> styleTextReadingMode: aBlRope [
	self hasChildren 
		ifTrue: [ self styleTextReadingModeWithCaption: aBlRope ]
		ifFalse: [ self styleTextReadingModeWithoutCaption: aBlRope ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRExternalLink >> styleTextReadingModeWithCaption: aBlRope [
	| aStartIndex aStopIndex |
	aStartIndex := self startMarkup size + self start.
	aStopIndex := self children first stop.
	self utility
		styleLinkInText: aBlRope
		forNode: self
		start: aStartIndex
		stop: aStopIndex.
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
PRExternalLink >> styleTextReadingModeWithoutCaption: aBlRope [
	| aStartIndex aStopIndex aMarkup |
	aMarkup := self startMarkup.
	aStartIndex := self start + aMarkup size.
	aStopIndex := self stop - aMarkup size.
	self utility
		styleLinkInText: aBlRope
		forNode: self
		start: aStartIndex
		stop: aStopIndex.
	self utility
		hideMarkupsInText: aBlRope
		start: self start
		stop: aStartIndex - 1.
	self utility
		hideMarkupsInText: aBlRope
		start: aStopIndex + 1
		stop: self stop
]
