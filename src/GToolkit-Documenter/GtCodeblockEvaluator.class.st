Class {
	#name : 'GtCodeblockEvaluator',
	#superclass : 'GtCodeblockAction',
	#instVars : [
		'displayResult'
	],
	#category : 'GToolkit-Documenter-Code Snippet'
}

{ #category : 'caching' }
GtCodeblockEvaluator >> cacheResult: aResult selection: aGtCodeblockSelection asException: isException [ 
	self document 
		cacheAt: self node cacheKey 
		ifPresent: [ :aCachedValue |
			aCachedValue
				result: aResult;
				evaluatedInterval: aGtCodeblockSelection interval;
				displayResult: self shouldDisplayResult;
				isException: isException;
				preview: nil ] 
		ifAbsentPut: [ GtCodeblockCacheValue new
			result: aResult;
			evaluatedInterval: aGtCodeblockSelection interval;
			displayResult: self shouldDisplayResult;
			isException: isException ]
]

{ #category : 'initialization' }
GtCodeblockEvaluator >> displayResult [
	displayResult := true
]

{ #category : 'initialization' }
GtCodeblockEvaluator >> doNotDisplayResult [
	displayResult := false
]

{ #category : 'actions' }
GtCodeblockEvaluator >> evaluateBody [
	"Evaluate a node's body (code snippet)"
	| aCommand anErrorCatchingCommand aSelection |
	self hasNodeBody ifFalse: [ ^ self ].
	self allConditionsSatisfied ifFalse: [ ^ self ].
	aSelection := self selectionOrNodeBody.
	aCommand := GtEvaluateSourceCodeCommand new.
	aCommand requestor: self node.
	aCommand sourceCode: aSelection text.
	aCommand variableBindings: self variableBindings.
	aCommand receiver: self evaluationReceiver.
	anErrorCatchingCommand := aCommand asErrorCatchingCommand.
	anErrorCatchingCommand execute.
	self onFinishedEvaluation: anErrorCatchingCommand selection: aSelection
]

{ #category : 'actions' }
GtCodeblockEvaluator >> evaluateSelection [
	"Evaluate a node's body (code snippet)"
	| aGtCodeblockSelection |
	self hasNodeBody ifFalse: [ ^ self ].
	aGtCodeblockSelection := self nodeBodySelection.
	aGtCodeblockSelection ifNotNil: [ 
		self selectedCode: aGtCodeblockSelection ].
	self evaluateBody
]

{ #category : 'accessing - document' }
GtCodeblockEvaluator >> evaluationReceiver [
	<return: #Object>
	^ self document evaluationReceiver
]

{ #category : 'execution' }
GtCodeblockEvaluator >> execute [
	"Perform a default action"
	^ self evaluateSelection
]

{ #category : 'initialization' }
GtCodeblockEvaluator >> initialize [
	super initialize.
	displayResult := true.
]

{ #category : 'notifying' }
GtCodeblockEvaluator >> onFinishedEvaluation: anErrorCatchingCommand selection: aGtCodeblockSelection [
	"Cache result and announce the result"
	| aResult |
	aResult := anErrorCatchingCommand result.
	self 
		cacheResult: aResult 
		selection: aGtCodeblockSelection 
		asException: anErrorCatchingCommand isException.
	anErrorCatchingCommand isException
		ifFalse: [ 
			self document announce: (GtCodeblockSuccessfulEvaluationAnnouncement new 
				document: self document;
				codeSnippet: aGtCodeblockSelection text; 
				result: aResult) ]
		ifTrue: [  
			self document announce: (GtCodeblockFailedEvaluationAnnouncement new
				document: self document;
				codeSnippet: aGtCodeblockSelection text;
				exception: aResult) ].
	self document styleTextRequest.
]

{ #category : 'texting' }
GtCodeblockEvaluator >> shouldDisplayResult [
	^ displayResult
]

{ #category : 'accessing - document' }
GtCodeblockEvaluator >> variableBindings [
	<return: #GtSnippetBindings>
	^ self document variableBindings
]
