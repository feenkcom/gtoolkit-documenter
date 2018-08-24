Class {
	#name : #GtOldPillarEpiceaCodeSnippetType,
	#superclass : #GtPillarCodeSnippetType,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldPillarEpiceaCodeSnippetType class >> brickHandlerClass [
	<return: #GtPillarScriptHandler>
	^ GtOldPillarEpiceaCodeSnippetHandler 
]

{ #category : #accessing }
GtOldPillarEpiceaCodeSnippetType class >> codeSnippetClass [
	<return: #GtOldAnnouncableCodeSnippet>
	^ GtOldEpiceaCodeSnippet
]

{ #category : #testing }
GtOldPillarEpiceaCodeSnippetType class >> handlesScript: aGtPillarScriptTokens [
	^ aGtPillarScriptTokens includesParameter: GtOldPillarEpiceaCodeSnippetHandler epiceaParameterName
]

{ #category : #accessing }
GtOldPillarEpiceaCodeSnippetType class >> parserHandlerClass [
	^ GtOldPillarEpiceaCodeblock
]
