Extension { #name : #PRExternalLink }

{ #category : #'*GToolkit-Documenter' }
PRExternalLink >> browseReferenceFrom: anEvent [ 
	(self utility shouldOpenReference: anEvent) ifFalse: [ ^ self ].
	anEvent consumed: true.
	WebBrowser openOn: self url.
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
PRExternalLink >> styleTextWithoutInteractions: aBlRope [
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
	(self gtNodeStyler: aBlRope)
		if: self doesReferenceExist 
		do: [ :aStyler | 
			| aMarkup aStartIndex |
			aMarkup := self startMarkup.
			aStartIndex := self start + aMarkup size - 1.
			aStyler 
				hide: self start to: aStartIndex;
				if: self hasChildren " = has caption"
					do: [ :sameStyler | 
						| aStopIndex | 
						aStopIndex := self children first stop + 1.
						sameStyler hide: aStopIndex to: self stop ]
					otherwise: [ :sameStyler | 
						| aStopIndex | 
						aStopIndex := self stop - aMarkup size + 1.
						sameStyler hide: aStopIndex to: self stop ];
				"we do not display markups as there is a conflict between 
				clicking on a link and "
				hideNode ].
]
