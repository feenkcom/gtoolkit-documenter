Extension { #name : 'PRExternalLink' }

{ #category : '*GToolkit-Documenter' }
PRExternalLink >> doesReferenceExist [
	^ self url isString and: [ self url isNotEmpty ]
]

{ #category : '*GToolkit-Documenter' }
PRExternalLink >> startMarkup [
	^ self utility startMarkupFor: PRLink
]

{ #category : '*GToolkit-Documenter' }
PRExternalLink >> styleTextWithMarkup: aBlRope [
	self utility
		subtleMarkupsInText: aBlRope 
		start: self start 
		stop: self start + self startMarkup size - 1.
	self utility
		subtleMarkupsInText: aBlRope 
		start: self stop - self startMarkup size + 1
		stop: self stop.
	(self gtNodeStyler: aBlRope) 
		if: self doesReferenceExist
			do: [ :aStyler | aStyler 
				styleKnownLinkFrom: self start + 1 to: self stop - 1;
				name: (self hasChildren ifFalse: [ self url ] ifTrue: [ self children first text asString ]);
				action: [ WebBrowser openOn: self url ];
				splitURI;
				linkButton ]
			otherwise: [ :aStyler | aStyler 
				styleUnknownLinkFrom: self start + 1 to: self stop - 1 ].
]

{ #category : '*GToolkit-Documenter' }
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

{ #category : '*GToolkit-Documenter' }
PRExternalLink >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self gtNodeStyler: aBlRope)
		if: self doesReferenceExist 
		do: [ :aStyler | aStyler autoHideNode ].
]
