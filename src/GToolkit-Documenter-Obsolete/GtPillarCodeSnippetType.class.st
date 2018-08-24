Class {
	#name : #GtPillarCodeSnippetType,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtPillarCodeSnippetType class >> brickHandlerClass [
	<return: #GtPillarScriptHandler>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPillarCodeSnippetType class >> codeSnippetClass [
	<return: #GtOldAnnouncableCodeSnippet>
	^ self subclassResponsibility
]

{ #category : #testing }
GtPillarCodeSnippetType class >> handlesScript: aGtPillarScriptTokens [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GtPillarCodeSnippetType class >> parserHandlerClass [
	"Return a class that handles parsing of a specific code block, e.g., code snippet, gt-example, Epicea"
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPillarCodeSnippetType class >> priority [
	"Handler with higher priority is used in case of several suitable script handlers"
	^ 50
]
