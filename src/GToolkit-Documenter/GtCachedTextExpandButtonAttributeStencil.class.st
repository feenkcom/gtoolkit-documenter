Class {
	#name : #GtCachedTextExpandButtonAttributeStencil,
	#superclass : #BrTextExpandButtonAttributeStencil,
	#instVars : [
		'onCachingAction'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #private }
GtCachedTextExpandButtonAttributeStencil >> collapsedTextExpandButtonAttribute [
	^ super collapsedTextExpandButtonAttribute
		onCachingDo: onCachingAction
]

{ #category : #initialization }
GtCachedTextExpandButtonAttributeStencil >> initialize [
	super initialize.
	onCachingAction := [ :aBoolean :theAttribute | "do nothing" ].
]

{ #category : #enumerating }
GtCachedTextExpandButtonAttributeStencil >> onCachingDo: aBlock [
	self 
		assert: [ aBlock notNil ]
		description: [ 'On caching block must be non-nil' ].
	onCachingAction := aBlock
]

{ #category : #initialization }
GtCachedTextExpandButtonAttributeStencil >> textExpandButtonAttributeClass [
	^ GtCachedTextExpandButtonAttribute
]
