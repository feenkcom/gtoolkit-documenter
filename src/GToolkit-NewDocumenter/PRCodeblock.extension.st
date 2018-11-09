Extension { #name : #PRCodeblock }

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> endMarkupSize [
	^ (PR2PillarGrammar endMarkups at: self class) size
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> gtIsSmalltalkLanguage [
	^ self gtLanguageOrSmalltalk = PRSmalltalkScriptLanguage default
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> gtLanguageOrSmalltalk [
	| aLanguage |
	aLanguage := self language.
	^ (aLanguage = PRUnspecifiedScriptLanguage default or: [
			true = aLanguage ])
		ifTrue: [ PRSmalltalkScriptLanguage default ] 
		ifFalse: [ aLanguage ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> newRunButtonAttribute [
	^ Gt2RunButtonAttribute new
		beAppend;
		stencil: (Gt2RunButtonStencilBuilder new
			label: self runButtonLabel;
			document: self gtDocument)
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> parameterLineLengthInText: aBlRope [
	^ (aBlRope from: self start to: self stop) asString lines first size
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> runButtonLabel [
	<return: #String>
	^ self label 
		ifEmpty: [ Gt2DocumentConstants defaultRunButtonLabel ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> scriptStartPositionInText: aBlText [
	^ self start + (self parameterLineLengthInText: aBlText) + 1
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> scriptStopPositionInText [
	^ self stop - self endMarkupSize - 1
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleClosingBracketsInText: aBlRope [
	(aBlRope
		from: self stop - self endMarkupSize
		to: self stop)
			foreground: Gt2DocumentConstants subtleColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleInText: aBlRope [ 
	self styleParametersInText: aBlRope.
	self styleClosingBracketsInText: aBlRope.
	self gtIsSmalltalkLanguage ifFalse: [ ^ self styleScriptInText: aBlRope ].
	self styleRunButtonInText: aBlRope.
	self styleSmalltalkInText: aBlRope.
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleParametersInText: aBlRope [
	| aLenghtOfTheParameterLine |
	aLenghtOfTheParameterLine := self parameterLineLengthInText: aBlRope.
	(aBlRope from: self start to: self start + aLenghtOfTheParameterLine)
		foreground: Gt2DocumentConstants subtleColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleRunButtonInText: aBlRope [
	(aBlRope from: self stop - self endMarkupSize to: self stop)
		attribute: self newRunButtonAttribute
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleScriptInText: aBlText [
	(aBlText
		from: (self scriptStartPositionInText: aBlText)
		to: self scriptStopPositionInText)
		monospace;
		fontSize: 14
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleSmalltalkInText: aBlRope [
	| styler strategy |
	styler := BrRBTextStyler new.
	strategy := GtHighlightingBindingStrategy new
		"bindings: self documentPart outBindings".
	styler workspace: strategy.
	styler
		style:
			(aBlRope
				from: (self scriptStartPositionInText: aBlRope)
				to: self scriptStopPositionInText).
	self styleScriptInText: aBlRope.
]
