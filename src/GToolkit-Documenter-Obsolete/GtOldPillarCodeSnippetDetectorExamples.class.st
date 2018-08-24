Class {
	#name : #GtOldPillarCodeSnippetDetectorExamples,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #common }
GtOldPillarCodeSnippetDetectorExamples >> codeSnippetDetector [
	<gtExample>
	^ GtOldPillarCodeSnippetDetector
]

{ #category : #'default handler' }
GtOldPillarCodeSnippetDetectorExamples >> defaultPillarContent [
	<gtExample>
	^ '[[[parameterOne=Value One|parameterTwo=Value Two]]]'
]

{ #category : #'default handler' }
GtOldPillarCodeSnippetDetectorExamples >> defaultScriptHandler [
	<gtExample>
	| typeClass |
	typeClass := GtPillarDefaultCodeSnippetType.
	self assert: (typeClass handlesScript: self defaultScriptTokens).
	^ typeClass
]

{ #category : #'default handler' }
GtOldPillarCodeSnippetDetectorExamples >> defaultScriptHandler2 [
	<gtExample>
	| handlerClass |
	handlerClass := self codeSnippetDetector typeForScriptTokens: self defaultScriptTokens.
	self assert: handlerClass equals: GtPillarDefaultCodeSnippetType.
	^ handlerClass
]

{ #category : #'default handler' }
GtOldPillarCodeSnippetDetectorExamples >> defaultScriptTokens [
	<gtExample>
	<return: #GtOldPillarScriptTokens>
	| scriptTokens parameterValue |
	scriptTokens := self scriptTokensFor: self defaultPillarContent.
	self assert: scriptTokens hasParameters.
	parameterValue := scriptTokens valueOf: #parameterOne emptyValue: nil defaultValue: nil.
	self assert: parameterValue equals: 'Value One'.
	parameterValue := scriptTokens valueOf: #parameterTwo emptyValue: nil defaultValue: nil.
	self assert: parameterValue equals: 'Value Two'.
	self 
		assert: scriptTokens scriptBodyString 
		equals: ''.
	^ scriptTokens.
]

{ #category : #'script executor' }
GtOldPillarCodeSnippetDetectorExamples >> executableScriptHandler [
	<gtExample>
	| typeClass |
	typeClass := GtPillarExecutableCodeSnippetType.
	self assert: (typeClass handlesScript: self executableScriptTokens).
	^ typeClass
]

{ #category : #'script executor' }
GtOldPillarCodeSnippetDetectorExamples >> executableScriptHandler2 [
	<gtExample>
	| handlerClass |
	handlerClass := self codeSnippetDetector typeForScriptTokens: self executableScriptTokens.
	self assert: handlerClass equals: GtPillarExecutableCodeSnippetType.
	^ handlerClass
]

{ #category : #'script executor' }
GtOldPillarCodeSnippetDetectorExamples >> executableScriptPillarContent [
	<gtExample>
	^ '[[[
self traceCr: ''test''.
]]]'
]

{ #category : #'script executor' }
GtOldPillarCodeSnippetDetectorExamples >> executableScriptTokens [
	<gtExample>
	<return: #GtOldPillarScriptTokens>
	| scriptTokens |
	scriptTokens := self scriptTokensFor: self executableScriptPillarContent.
	self assert: scriptTokens hasParameters not.
	self 
		assert: scriptTokens scriptBodyString 
		equals: 'self traceCr: ''test''.
'.
	^ scriptTokens.
]

{ #category : #'gt-examples' }
GtOldPillarCodeSnippetDetectorExamples >> gtExampleHandler [
	<gtExample>
	| handlerClass |
	handlerClass := GtPillarExampleCodeSnippetType.
	self assert: (handlerClass handlesScript: self gtExampleScriptTokens).
	^ handlerClass
]

{ #category : #'gt-examples' }
GtOldPillarCodeSnippetDetectorExamples >> gtExampleHandler2 [
	<gtExample>
	| handlerClass |
	handlerClass := self codeSnippetDetector typeForScriptTokens: self gtExampleScriptTokens.
	self assert: handlerClass equals: GtPillarExampleCodeSnippetType.
	^ handlerClass
]

{ #category : #'gt-examples' }
GtOldPillarCodeSnippetDetectorExamples >> gtExamplePillarContent [
	<gtExample>
	^ '[[[example=GtDocumenterErrorExamples>>#nonExistentMethod]]]'
]

{ #category : #'gt-examples' }
GtOldPillarCodeSnippetDetectorExamples >> gtExampleScriptTokens [
	<gtExample>
	<return: #GtOldPillarScriptTokens>
	| scriptTokens |
	scriptTokens := self scriptTokensFor: self gtExamplePillarContent.
	self assert: scriptTokens hasExampleParameter.
	self 
		assert: scriptTokens exampleParameterValue 
		equals: 'GtDocumenterErrorExamples>>#nonExistentMethod'.
	^ scriptTokens.
]

{ #category : #common }
GtOldPillarCodeSnippetDetectorExamples >> parserInstance [
	<gtExample>
	^ GtOldPillarHighlightingParser new
		workspace: GtOldDocument new.
]

{ #category : #utility }
GtOldPillarCodeSnippetDetectorExamples >> scriptTokensFor: aString [
	<return: #GtOldPillarScriptTokens>
	| scriptTokensInArray scriptTokens |
	scriptTokensInArray := self parserInstance 
		targetText: aString asRopedText;
		parse: aString.
	self assert: scriptTokensInArray isCollection.
	self assert: scriptTokensInArray size equals: 1.
	self assert: scriptTokensInArray first class equals: GtOldPillarScriptTokens.
	scriptTokens := scriptTokensInArray first.
	^ scriptTokens.
]
