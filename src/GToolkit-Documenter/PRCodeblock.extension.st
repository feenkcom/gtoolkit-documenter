Extension { #name : #PRCodeblock }

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cacheKey [
	^ GtCodeblockCacheKey new
		parameters: self parameters;
		text: self text;
		counter: self counter;
		caption: self caption
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cachedDisplayPreview [
	<return: #Boolean>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue displayResult ] 
		ifAbsent: [ true ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cachedDisplayPreview: aBoolean [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue displayResult: aBoolean ]
		ifAbsentPut: [ 
			GtCodeblockCacheValue new 
				displayResult: aBoolean ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cachedEvaluatedInterval [
	^ self gtDocument 
		cacheAt: self cacheKey 
		ifPresent: [ :aCachedValue | aCachedValue evaluatedInterval ] 
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cachedPreview [
	<return: #BlElement or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview ] 
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cachedPreview: anElement [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview: anElement ]
		ifAbsentPut: [ 
			GtCodeblockCacheValue new 
				preview: anElement ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cachedResult [
	^ self gtDocument 
		cacheAt: self cacheKey 
		ifPresent: [ :aCachedValue | aCachedValue result ] 
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cachedSymbols [
	<return: #GtCodeblockSymbols or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue symbols ]
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> cachedSymbols: aGt2CodeblockSymbols [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue symbols: aGt2CodeblockSymbols ]
		ifAbsentPut: [ 
			GtCodeblockCacheValue new 
				symbols: aGt2CodeblockSymbols ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> endMarkup [
	^ PRPillarGrammar endMarkups at: self class
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> endMarkupSize [
	^ self endMarkup size
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> evaluateCodeblock [
	GtCodeblockEvaluator new
		document: self gtDocument;
		node: self;
		text: self gtDocument text;
		evaluateSelection
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> evaluationAction [ 
	^ [ :aWidget :aButtonModel | 
		"create a `once` subscription to restyle text once code snippet is executed.
		We should not restyle text right after the `execute` statement since execution
		could happen asynchronous"
		(self gtDocument
			when: GtCodeblockEvalutedAnnouncement
			doOnce: [
				self gtDocument styleTextRequest ]
			for: self).
		self evaluateCodeblock ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> gtIsSmalltalkLanguage [
	^ self gtLanguageOrSmalltalk = PRSmalltalkScriptLanguage default
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> gtLanguageOrSmalltalk [
	| aLanguage |
	aLanguage := self language.
	^ (aLanguage = PRUnspecifiedScriptLanguage default or: [
			true = aLanguage ])
		ifTrue: [ PRSmalltalkScriptLanguage default ] 
		ifFalse: [ aLanguage ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> gtNodeStyler: aBlText [
	^ GtStyledCodeblockBuilder new 
		document: self gtDocument; 
		node: self; 
		text: aBlText
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> handleClassAddedOrRemovedAnnouncement: aClassAdded [ 
	| aSymbols |
	aSymbols := self cachedSymbols.
	(aSymbols notNil and: [ 
		(aSymbols includesVariable: aClassAdded classAffected originalName) ])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> handleClassRenamedAnnouncement: aClassRenamed [ 
	| aSymbols |
	aSymbols := self cachedSymbols.
	(aSymbols notNil and: [ 
		(aSymbols includesVariable: aClassRenamed newName) or: [ 
			aSymbols includesVariable: aClassRenamed oldName ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> handleMethodAnnouncement: aMethodModified [ 
	| aSymbols |
	aSymbols := self cachedSymbols.
	(aSymbols notNil and: [ 
		(aSymbols includesVariable: aMethodModified classAffected name) or: [ 
			aSymbols includesMessage: aMethodModified selector ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> hasResult [
	^ self gtDocument 
		cacheAt: self cacheKey 
		ifPresent: [ :aCachedValue | aCachedValue hasResult ] 
		ifAbsent: [ false ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> hasSourceCode [
	^ self text trimBoth isNotEmpty
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> heightParameterValue [
	^ GtDocumentUtility
		valueOf: GtDocumentConstants heightParameterName
		in: self parameters
		value: [ :aNumber | aNumber isNumber 
			ifTrue: [ aNumber ]
			ifFalse: [ GtDocumentConstants defaultPreviewHeight ] ]
		emptyValue: [ GtDocumentConstants defaultPreviewHeight ]
		defaultValue: [ GtDocumentConstants defaultPreviewHeight ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> newRunButtonAttribute [
	^ GtButtonAttribute new
		beAppend;
		stencil: [ (GtButtonStencil new
			label: self runButtonLabel;
			action: self evaluationAction) ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> parameterStopPositionInText: aBlRope [
	| aLineBreakIndex |
	aLineBreakIndex := (aBlRope from: self start to: self stop) finder
			pattern: [ :aText :anIndex | 
				(aText at: anIndex) isLineBreak ]; search.
	^ aLineBreakIndex + self start - 1
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> parsePharoCode [
	| anAst aVisitor |
	anAst := GtPharoParser 
		parse: self text asString 
		startingAt: GtPharoParser startingStateForMethodSequence
		onError: [ :anException | nil ].
	anAst ifNil: [ ^ self ].
	aVisitor := GtCodeblockPharoVisitor new.
	anAst acceptVisitor: aVisitor.
	self cachedSymbols: aVisitor symbols.
	self registerToSystemChanges.
]

{ #category : #'*GToolkit-Documenter' }
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

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> resultPreviewAttributes [
	^ {GtCachedAttribute new
			attribute: (GtResizablePreviewAttribute new
				result: self cachedResult;
				showSelector: self showParameterValue;
				height: self heightParameterValue);
			cache: self cachedPreview;
			onCachingDo: [ :aCachedElement :theAttribute | 
				self cachedPreview: aCachedElement ]
		}
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> runButtonLabel [
	<return: #String or: nil>
	(self label isString and: [ self label isEmpty not ])
		ifTrue: [ ^ self label ].
	^ nil
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> scriptStartPositionInText: aBlText [
	^ (self parameterStopPositionInText: aBlText) + 1
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> scriptStopPositionInText: aBlRope [
	| aStopEndMarkup |
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	^ aStopEndMarkup - self endMarkupSize - 1
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> showParameterValue [
	<return: #Symbol>
	^ GtDocumentUtility 
		valueOf: GtDocumentConstants showParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ GtDocumentConstants defaultShowSelector ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ GtDocumentConstants defaultShowSelector ]
		defaultValue: [ GtDocumentConstants defaultShowSelector ]
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> stopEndMarkupInText: aBlRope [
	| aFoundIndex |
	aFoundIndex := (aBlRope from: self start to: self stop) finder
		reversed; startAtEnd; character: self endMarkup last; search.
	^ aFoundIndex + self start - 1
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> styleClosingBracketsInText: aBlRope [
	| aStopEndMarkup |
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	(aBlRope
		from: aStopEndMarkup - self endMarkupSize
		to: aStopEndMarkup)
			foreground: GtDocumentConstants subtleColor
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> styleParametersInText: aBlRope [
	(aBlRope
		from: self start
		to: (self parameterStopPositionInText: aBlRope))
			foreground: GtDocumentConstants subtleColor
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> styleResultPreviewInText: aBlRope [
	| aStopEndMarkup |
	self cachedDisplayPreview ifFalse: [ ^ self ].
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	(aBlRope from: aStopEndMarkup - self endMarkupSize to: aStopEndMarkup)
		attributes: self resultPreviewAttributes
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> styleRunButtonInText: aBlRope [
	| aStopEndMarkup |
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	(aBlRope from: aStopEndMarkup - self endMarkupSize to: aStopEndMarkup)
		attribute: self newRunButtonAttribute
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> styleScriptInText: aBlText [
	(aBlText
		from: (self scriptStartPositionInText: aBlText)
		to: (self scriptStopPositionInText: aBlText))
		glamorousCodeFontAndSize
]

{ #category : #'*GToolkit-Documenter' }
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

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> styleTextWithMarkup: aBlRope [ 
	super styleTextWithMarkup: aBlRope.
	self styleParametersInText: aBlRope.
	self styleClosingBracketsInText: aBlRope.
	self hasSourceCode ifFalse: [ ^ self ].
	self gtIsSmalltalkLanguage ifFalse: [ ^ self styleScriptInText: aBlRope ].
	(self gtNodeStyler: aBlRope)
		action: [ :aWidget :aButtonModel | 
			GtCodeblockEvaluator new
				document: self gtDocument;
				node: self;
				text: self gtDocument text;
				doNotDisplayResult;
				evaluateSelection ];
		playButton.
	self styleRunButtonInText: aBlRope.
	self styleSmalltalkInText: aBlRope.
	self parsePharoCode.
	(self gtNodeStyler: aBlRope)
		if: self hasResult 
			do: [ :aStyler | aStyler 
						embedResult;
						highlightEvaluatedCode ].
	self hasResult ifTrue: [ self styleResultPreviewInText: aBlRope ].
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> styleTextWithoutInteractions: aBlRope [ 
	| aStopEndMarkup |
	self styleParametersInText: aBlRope.
	aStopEndMarkup := self stopEndMarkupInText: aBlRope.
	(self gtNodeStyler: aBlRope)
		hideTextFrom: self start to: (self parameterStopPositionInText: aBlRope);
		hideTextFrom: aStopEndMarkup - self endMarkupSize to: aStopEndMarkup.
	self hasSourceCode ifFalse: [ ^ self ].
	self styleScriptInText: aBlRope.
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self gtNodeStyler: aBlRope)
		if: (self text isNotNil and: [ self text trimBoth isNotEmpty ])
			do: [ :aStyler |
				| aStopEndMarkup | 
				aStopEndMarkup := self stopEndMarkupInText: aBlRope.
				aStyler 
					hide: self start to: (self parameterStopPositionInText: aBlRope);
					hide: aStopEndMarkup - self endMarkupSize to: aStopEndMarkup;
					autoHideTextFrom: self start to: (self parameterStopPositionInText: aBlRope);
					autoHideTextFrom: aStopEndMarkup - self endMarkupSize to: aStopEndMarkup ]
]
