Class {
	#name : #GtPillarExampleCodeSnippetType,
	#superclass : #GtPillarCodeSnippetType,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtPillarExampleCodeSnippetType class >> brickHandlerClass [
	<return: #GtPillarScriptHandler>
	^ GtPillarExampleCodeSnippetHandler
]

{ #category : #accessing }
GtPillarExampleCodeSnippetType class >> codeSnippetClass [
	<return: #GtOldAnnouncableCodeSnippet>
	^ GtOldExampleCodeSnippet
]

{ #category : #testing }
GtPillarExampleCodeSnippetType class >> handlesScript: aGtPillarScriptTokens [
	^ aGtPillarScriptTokens hasExampleParameter and: [ 
		aGtPillarScriptTokens exampleParameterValue notNil ].
]

{ #category : #'as yet unclassified' }
GtPillarExampleCodeSnippetType class >> parserHandlerClass [
	^ GtOldPillarExampleCodeblock
]
