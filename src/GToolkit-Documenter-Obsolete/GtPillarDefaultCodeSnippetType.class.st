Class {
	#name : #GtPillarDefaultCodeSnippetType,
	#superclass : #GtPillarCodeSnippetType,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtPillarDefaultCodeSnippetType class >> brickHandlerClass [
	<return: #GtPillarScriptHandler>
	^ GtPillarDefaultCodeSnippetHandler
]

{ #category : #accessing }
GtPillarDefaultCodeSnippetType class >> codeSnippetClass [
	<return: #GtOldAnnouncableCodeSnippet>
	^ GtOldDefaultCodeSnippet
]

{ #category : #testing }
GtPillarDefaultCodeSnippetType class >> handlesScript: aGtPillarScriptTokens [ 
	"I handle all scripts"
	^ true
]

{ #category : #'as yet unclassified' }
GtPillarDefaultCodeSnippetType class >> parserHandlerClass [
	^ GtOldPillarCodeblock
]

{ #category : #accessing }
GtPillarDefaultCodeSnippetType class >> priority [
	"Default script handler has lower priority."
	^ 0
]
