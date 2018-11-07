Class {
	#name : #Gt2CachedTextExpandButtonAttribute,
	#superclass : #BrTextExpandButtonAttribute,
	#instVars : [
		'onCachingAction'
	],
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #initialization }
Gt2CachedTextExpandButtonAttribute >> initialize [
	super initialize.
	onCachingAction := [ :aBoolean :theAttribute | "do nothing" ].
]

{ #category : #accessing }
Gt2CachedTextExpandButtonAttribute >> isExpanded: aBoolean [
	super isExpanded: aBoolean.
	onCachingAction glamourValueWithArgs: { aBoolean. self }
]

{ #category : #accessing }
Gt2CachedTextExpandButtonAttribute >> onCachingDo: aBlock [
	self 
		assert: [ aBlock notNil ]
		description: [ 'On caching block must be non-nil' ].
	onCachingAction := aBlock
]
