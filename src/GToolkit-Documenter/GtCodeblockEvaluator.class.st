Class {
	#name : #GtCodeblockEvaluator,
	#superclass : #GtCodeblockAction,
	#category : #'GToolkit-Documenter-Code Snippet'
}

{ #category : #caching }
GtCodeblockEvaluator >> cacheResult: aResult asException: isException [
	self document 
		cacheAt: self node cacheKey 
		ifPresent: [ :aCachedValue |
			aCachedValue
				result: aResult;
				isException: isException;
				preview: nil ] 
		ifAbsentPut: [ GtCodeblockCacheValue new
			result: aResult;
			isException: isException ]
]

{ #category : #actions }
GtCodeblockEvaluator >> evaluateBody [
	"Evaluate a node's body (code snippet)"
	| aCommand anErrorCatchingCommand |
	self hasNodeBody ifFalse: [ ^ self ].
	self allConditionsSatisfied ifFalse: [ ^ self ].
	aCommand := GtEvaluateSourceCodeCommand new.
	aCommand requestor: self node.
	aCommand sourceCode: self selectionOrNodeBody.
	aCommand variableBindings: self variableBindings.
	aCommand receiver: self evaluationReceiver.
	anErrorCatchingCommand := aCommand asErrorCatchingCommand.
	anErrorCatchingCommand execute.
	self onFinishedEvaluation: anErrorCatchingCommand
]

{ #category : #actions }
GtCodeblockEvaluator >> evaluateSelection [
	"Evaluate a node's body (code snippet)"
	| aString |
	self hasNodeBody ifFalse: [ ^ self ].
	aString := self nodeBodySelection.
	aString ifNotNil: [ self selectedCode: aString ].
	self evaluateBody
]

{ #category : #'accessing - document' }
GtCodeblockEvaluator >> evaluationReceiver [
	<return: #Object>
	^ self document evaluationReceiver
]

{ #category : #execution }
GtCodeblockEvaluator >> execute [
	"Perform a default action"
	^ self evaluateSelection
]

{ #category : #notifying }
GtCodeblockEvaluator >> onFinishedEvaluation: anErrorCatchingCommand [
	"Cache result and announce the result"
	| aResult |
	aResult := anErrorCatchingCommand result.
	self cacheResult: aResult asException: anErrorCatchingCommand isException.
	anErrorCatchingCommand isException
		ifFalse: [ 
			self document announce: (GtCodeblockSuccessfulEvaluationAnnouncement new 
				document: self document;
				codeSnippet: self nodeBody; 
				result: aResult) ]
		ifTrue: [  
			self document announce: (GtCodeblockFailedEvaluationAnnouncement new
				document: self document;
				codeSnippet: self nodeBody;
				exception: aResult) ].
	self document styleTextRequest.
]

{ #category : #'accessing - document' }
GtCodeblockEvaluator >> variableBindings [
	<return: #GtSnippetBindings>
	^ self document variableBindings
]
