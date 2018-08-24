Class {
	#name : #GtOldPillarEpiceaCodeblock,
	#superclass : #GtOldPillarCodeblock,
	#instVars : [
		'epiceaLog'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #visitor }
GtOldPillarEpiceaCodeblock >> accept: aVisitor [
	^ aVisitor visitGtPillarEpiceaCodeblock: self
]

{ #category : #'accessing-delegated' }
GtOldPillarEpiceaCodeblock >> caption [
	| aParagraph |
	aParagraph := super caption.
	aParagraph text ifEmpty: [ ^ PRParagraph with: (PRText content: self tokens epiceaParameterStringValue) ].
	^ aParagraph
]

{ #category : #testing }
GtOldPillarEpiceaCodeblock >> hasCaption [
	^ self caption text notEmpty
]

{ #category : #testing }
GtOldPillarEpiceaCodeblock >> hasLabel [
	^ self label notEmpty
]

{ #category : #'accessing-delegated' }
GtOldPillarEpiceaCodeblock >> label [
	^ super label ifEmpty: [ self tokens epiceaParameterStringValue ]
]

{ #category : #accessing }
GtOldPillarEpiceaCodeblock >> text [
	self
		assert: [ epiceaLog notNil ]
		description: [ 'Epicea log has to be initialized first' ].
	^ epiceaLog newStateString 
]

{ #category : #accessing }
GtOldPillarEpiceaCodeblock >> tokens: aGtPillarScriptTokens [ 
	super tokens: aGtPillarScriptTokens.
	self 
		assert: [ epiceaLog isNil ] 
		description: [ 'Epicea log should be initialized just once' ].
	epiceaLog := GtEpiceaLog fromFileReference: aGtPillarScriptTokens epiceaParameterValue.
	
]
