Class {
	#name : #GtOldPillarCodeblock,
	#superclass : #PRCodeblock,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'tokens'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'instance creation' }
GtOldPillarCodeblock class >> tokens: aGtPillarScriptTokens [ 
	^ self new tokens: aGtPillarScriptTokens
]

{ #category : #accessing }
GtOldPillarCodeblock >> tokens [
	^ tokens
]

{ #category : #accessing }
GtOldPillarCodeblock >> tokens: aGtPillarScriptTokens [ 
	self 
		assert: [ aGtPillarScriptTokens notNil ] 
		description: [ 'Pillar codeblock tokens should be initialized' ].
	tokens := aGtPillarScriptTokens.
	self parameters: aGtPillarScriptTokens parameters.
	self text: aGtPillarScriptTokens scriptBodyString
]
