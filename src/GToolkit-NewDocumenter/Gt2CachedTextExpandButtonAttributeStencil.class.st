Class {
	#name : #Gt2CachedTextExpandButtonAttributeStencil,
	#superclass : #BrTextExpandButtonAttributeStencil,
	#instVars : [
		'onCachingAction'
	],
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #private }
Gt2CachedTextExpandButtonAttributeStencil >> collapsedTextExpandButtonAttribute [
	^ super collapsedTextExpandButtonAttribute
		onCachingDo: onCachingAction
]

{ #category : #initialization }
Gt2CachedTextExpandButtonAttributeStencil >> initialize [
	super initialize.
	onCachingAction := [ :aBoolean :theAttribute | "do nothing" ].
]

{ #category : #enumerating }
Gt2CachedTextExpandButtonAttributeStencil >> onCachingDo: aBlock [
	self 
		assert: [ aBlock notNil ]
		description: [ 'On caching block must be non-nil' ].
	onCachingAction := aBlock
]

{ #category : #initialization }
Gt2CachedTextExpandButtonAttributeStencil >> textExpandButtonAttributeClass [
	^ Gt2CachedTextExpandButtonAttribute
]
