Class {
	#name : #GtOldPillarCodeSnippetDetector,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #enumerating }
GtOldPillarCodeSnippetDetector class >> typeForScriptTokens: aGtPillarScriptTokens [
	<return: #GtPillarScriptHandler>
	self assert: [ aGtPillarScriptTokens notNil ] description: [ 'Tokens has to be defined' ].
	^ (self typesForScriptTokens: aGtPillarScriptTokens) first
]

{ #category : #enumerating }
GtOldPillarCodeSnippetDetector class >> typesForScriptTokens: aGtPillarScriptTokens [
	"Return handlers for a given script parameters.
	Handler with highest priority is first"
	<return: #Array of: #GtPillarScriptHandler>
	self assert: [ aGtPillarScriptTokens notNil ] description: [ 'Tokens has to be defined' ].
	^ (GtPillarCodeSnippetType allSubclasses
		select:
			[ :eachClass | eachClass handlesScript: aGtPillarScriptTokens ])
		sort: [ :a :b | a priority > b priority ]
]
