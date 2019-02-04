Extension { #name : #PRCodeblock }

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cacheKey [
	^ Gt2CodeblockCacheKey new
		parameters: self parameters;
		text: self text;
		counter: self counter;
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
PRCodeblock >> cachedSymbols [
	<return: #Gt2CodeblockSymbols or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue symbols ]
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cachedSymbols: aGt2CodeblockSymbols [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue symbols: aGt2CodeblockSymbols ]
		ifAbsentPut: [ 
			Gt2CodeblockCacheValue new 
				symbols: aGt2CodeblockSymbols ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cursorLeftInText: aBlRope [
	| aStopEndMarkup |
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: self start 
		stop: (self parameterStopPositionInText: aBlRope) 
		forNode: self.
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: aStopEndMarkup - self endMarkupSize 
		stop: aStopEndMarkup 
		forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> endMarkup [
	^ PRPillarGrammar endMarkups at: self class
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> endMarkupSize [
	^ self endMarkup size
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> evaluateCodeblock [
	| snippetBindings aCommand anErrorCatchingCommand aResult |
	self text isEmpty ifTrue: [ ^ self ].
	snippetBindings := self gtDocument variableBindings.
	aCommand := GtEvaluateSourceCodeCommand new.
	aCommand requestor: self.
	aCommand sourceCode: self text asString.
	aCommand variableBindings: snippetBindings.
	aCommand receiver: self gtDocument evaluationReceiver.
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
				self gtDocument styleTextRequest ]
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
PRCodeblock >> handleClassAddedOrRemovedAnnouncement: aClassAdded [ 
	| aSymbols |
	aSymbols := self cachedSymbols.
	(aSymbols notNil and: [ 
		(aSymbols includesVariable: aClassAdded classAffected originalName) ])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> handleClassRenamedAnnouncement: aClassRenamed [ 
	| aSymbols |
	aSymbols := self cachedSymbols.
	(aSymbols notNil and: [ 
		(aSymbols includesVariable: aClassRenamed newName) or: [ 
			aSymbols includesVariable: aClassRenamed oldName ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> handleMethodAnnouncement: aMethodModified [ 
	| aSymbols |
	aSymbols := self cachedSymbols.
	(aSymbols notNil and: [ 
		(aSymbols includesVariable: aMethodModified classAffected name) or: [ 
			aSymbols includesMessage: aMethodModified selector ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> hasResult [
	^ self gtDocument 
		cacheAt: self cacheKey 
		ifPresent: [ :aCachedValue | aCachedValue hasResult ] 
		ifAbsent: [ false ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> hasSourceCode [
	^ self text trimBoth isNotEmpty
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> heightParameterValue [
	^ Gt2DocumentUtility
		valueOf: Gt2DocumentConstants heightParameterName
		in: self parameters
		value: [ :aNumber | aNumber isNumber 
			ifTrue: [ aNumber ]
			ifFalse: [ Gt2DocumentConstants defaultPreviewHeight ] ]
		emptyValue: [ Gt2DocumentConstants defaultPreviewHeight ]
		defaultValue: [ Gt2DocumentConstants defaultPreviewHeight ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> newRunButtonAttribute [
	^ Gt2ButtonAttribute new
		beAppend;
		stencil: [ (Gt2ButtonStencil new
			label: self runButtonLabel;
			action: self evaluationAction) ]
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
PRCodeblock >> parsePharoCode [
	| anAst aVisitor |
	anAst := GtPharoParser 
		parse: self text asString 
		startingAt: GtPharoParser startingStateForMethodSequence
		onError: [ :anException | nil ].
	anAst ifNil: [ ^ self ].
	aVisitor := Gt2CodeblockPharoVisitor new.
	anAst acceptVisitor: aVisitor.
	self cachedSymbols: aVisitor symbols.
	self registerToSystemChanges.
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> registerToSystemChanges [
	self gtDocument
		subscribe: MethodAdded, MethodRemoved
			send: #handleMethodAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassAdded, ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: self gtSubscriber
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> resultPreviewAttributes [
	^ {Gt2CachedAttribute new
			attribute: (Gt2ResizablePreviewAttribute new
				result: self cachedResult;
				showSelector: self showParameterValue;
				height: self heightParameterValue);
			cache: self cachedPreview;
			onCachingDo: [ :aCachedElement :theAttribute | 
				self cachedPreview: aCachedElement ]
		}
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> runButtonLabel [
	<return: #String or: nil>
	(self label isString and: [ self label isEmpty not ])
		ifTrue: [ ^ self label ].
	^ nil
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
PRCodeblock >> showParameterValue [
	<return: #Symbol>
	^ Gt2DocumentUtility 
		valueOf: Gt2DocumentConstants showParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ Gt2DocumentConstants defaultShowSelector ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ Gt2DocumentConstants defaultShowSelector ]
		defaultValue: [ Gt2DocumentConstants defaultShowSelector ]
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

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleTextWithMarkup: aBlRope [ 
	super styleTextWithMarkup: aBlRope.
	self styleParametersInText: aBlRope.
	self styleClosingBracketsInText: aBlRope.
	self hasSourceCode ifFalse: [ ^ self ].
	self gtIsSmalltalkLanguage ifFalse: [ ^ self styleScriptInText: aBlRope ].
	self styleRunButtonInText: aBlRope.
	self styleSmalltalkInText: aBlRope.
	self parsePharoCode.
	self hasResult ifTrue: [ self styleResultPreviewInText: aBlRope ].
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleTextWithoutMarkup: aBlRope [
	| aStopEndMarkup |
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: self start 
		stop: (self parameterStopPositionInText: aBlRope) 
		forNode: self.
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: aStopEndMarkup - self endMarkupSize 
		stop: aStopEndMarkup 
		forNode: self.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
