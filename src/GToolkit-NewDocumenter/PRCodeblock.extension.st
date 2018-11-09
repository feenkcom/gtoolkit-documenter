Extension { #name : #PRCodeblock }

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cacheKey [
	^ Gt2CodeblockCacheKey new
		parameters: self parameters;
		text: self text;
		caption: self caption
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cacheResult: aResult asException: isException [
	self gtDocument 
		cacheAt: self cacheKey 
		ifPresent: [ :aCachedValue |
			aCachedValue
				result: aResult;
				isException: isException;
				preview: nil ] 
		ifAbsentPut: [ Gt2CodeblockCacheValue new
			result: aResult;
			isException: isException ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cachedPreview [
	<return: #BlElement or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview ] 
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cachedPreview: anElement [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview: anElement ]
		ifAbsentPut: [ 
			Gt2CodeblockCacheValue new 
				preview: anElement ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cachedResult [
	^ self gtDocument 
		cacheAt: self cacheKey 
		ifPresent: [ :aCachedValue | aCachedValue result ] 
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> endMarkup [
	^ PR2PillarGrammar endMarkups at: self class
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> endMarkupSize [
	^ self endMarkup size
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> evaluateCodeblock [
	| aStrategy aCommand anErrorCatchingCommand aResult |
	self text isEmpty ifTrue: [ ^ self ].
	aStrategy := GtPlaygroundBindingStrategy new.
	aStrategy bindings: self gtDocument variableBindings.
	aCommand := GtEvaluateSourceCodeCommand new.
	aCommand requestor: self.
	aCommand sourceCode: self text asString.
	aCommand variableBindings: aStrategy.
	aCommand receiver: self gtDocument.
	anErrorCatchingCommand := aCommand asErrorCatchingCommand.
	anErrorCatchingCommand execute.
	aResult := anErrorCatchingCommand result.
	self cacheResult: aResult asException: anErrorCatchingCommand isException.
	anErrorCatchingCommand isException
		ifFalse: [ 
			self gtDocument announce: (Gt2CodeblockSuccessfulEvaluationAnnouncement new 
				document: self gtDocument;
				codeSnippet: self text; 
				result: aResult) ]
		ifTrue: [  
			self gtDocument announce: (Gt2CodeblockFailedEvaluationAnnouncement new
				document: self gtDocument;
				codeSnippet: self text;
				exception: aResult) ].
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> evaluationAction [ 
	^ [ :aWidget :aButtonModel | 
		"create a `once` subscription to restyle text once code snippet is executed.
		We should not restyle text right after the `execute` statement since execution
		could happen asynchronous"
		(self gtDocument
			when: Gt2CodeblockEvalutedAnnouncement
			doOnce: [
				self gtDocument editor styleText ]
			for: self).
		self evaluateCodeblock ]
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
PRCodeblock >> hasResult [
	^ self gtDocument 
		cacheAt: self cacheKey 
		ifPresent: [ :aCachedValue | true ] 
		ifAbsent: [ false ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> newRunButtonAttribute [
	^ Gt2RunButtonAttribute new
		beAppend;
		stencil: (Gt2RunButtonStencilBuilder new
			label: self runButtonLabel;
			document: self gtDocument;
			action: self evaluationAction)
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> parameterStopPositionInText: aBlRope [
	| aLineBreakIndex |
	aLineBreakIndex := (aBlRope from: self start to: self stop) finder
			pattern: [ :aText :anIndex | 
				(aText at: anIndex) isLineBreak ]; search.
	^ aLineBreakIndex + self start - 1
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> resultPreviewAttributes [
	^ {Gt2CachedAttribute new
			attribute: (Gt2ResizablePreviewAttribute new
				result: self cachedResult);
			cache: self cachedPreview;
			onCachingDo: [ :aCachedElement :theAttribute | 
				self cachedPreview: aCachedElement ]
		}
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> runButtonLabel [
	<return: #String>
	(self label isString and: [ self label isEmpty not ])
		ifTrue: [ self label ].
	^ Gt2DocumentConstants defaultRunButtonLabel
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> scriptStartPositionInText: aBlText [
	^ (self parameterStopPositionInText: aBlText) + 1
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> scriptStopPositionInText: aBlRope [
	| aStopEndMarkup |
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	^ aStopEndMarkup - self endMarkupSize - 1
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> stopEndMarkupInText: aBlRope [
	| aFoundIndex |
	aFoundIndex := (aBlRope from: self start to: self stop) finder
		reversed; startAtEnd; character: self endMarkup last; search.
	^ aFoundIndex + self start - 1
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleClosingBracketsInText: aBlRope [
	| aStopEndMarkup |
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	(aBlRope
		from: aStopEndMarkup - self endMarkupSize
		to: aStopEndMarkup)
			foreground: Gt2DocumentConstants subtleColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleInText: aBlRope [ 
	self styleParametersInText: aBlRope.
	self styleClosingBracketsInText: aBlRope.
	self gtIsSmalltalkLanguage ifFalse: [ ^ self styleScriptInText: aBlRope ].
	self styleRunButtonInText: aBlRope.
	self styleSmalltalkInText: aBlRope.
	self hasResult ifTrue: [ self styleResultPreviewInText: aBlRope ].
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleParametersInText: aBlRope [
	(aBlRope
		from: self start
		to: (self parameterStopPositionInText: aBlRope))
			foreground: Gt2DocumentConstants subtleColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleResultPreviewInText: aBlRope [
	| aStopEndMarkup |
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	(aBlRope from: aStopEndMarkup - self endMarkupSize to: aStopEndMarkup)
		attributes: self resultPreviewAttributes
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleRunButtonInText: aBlRope [
	| aStopEndMarkup |
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	(aBlRope from: aStopEndMarkup - self endMarkupSize to: aStopEndMarkup)
		attribute: self newRunButtonAttribute
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleScriptInText: aBlText [
	(aBlText
		from: (self scriptStartPositionInText: aBlText)
		to: (self scriptStopPositionInText: aBlText))
		monospace;
		fontSize: 14
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleSmalltalkInText: aBlRope [
	| styler strategy |
	styler := BrRBTextStyler new.
	strategy := GtHighlightingBindingStrategy new
		bindings: self gtDocument variableBindings.
	styler workspace: strategy.
	styler
		style:
			(aBlRope
				from: (self scriptStartPositionInText: aBlRope)
				to: (self scriptStopPositionInText: aBlRope)).
	self styleScriptInText: aBlRope.
]
