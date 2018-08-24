Class {
	#name : #GtPillarExecutableCodeSnippetType,
	#superclass : #GtPillarCodeSnippetType,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtPillarExecutableCodeSnippetType class >> brickHandlerClass [
	<return: #GtPillarScriptHandler>
	^ GtPillarExecutableCodeSnippetHandler
]

{ #category : #accessing }
GtPillarExecutableCodeSnippetType class >> codeSnippetClass [
	<return: #GtOldAnnouncableCodeSnippet>
	^ GtOldExecutableCodeSnippet
]

{ #category : #testing }
GtPillarExecutableCodeSnippetType class >> handlesScript: aGtPillarScriptTokens [
	<return: #Boolean>
	^ aGtPillarScriptTokens scriptBodyString trimBoth notEmpty
]

{ #category : #'as yet unclassified' }
GtPillarExecutableCodeSnippetType class >> parserHandlerClass [
	^ GtOldPillarExecutableCodeblock
]

{ #category : #accessing }
GtPillarExecutableCodeSnippetType class >> priority [
	"Handler with higher priority is used in case of several suitable script handlers"
	^ 1
]
