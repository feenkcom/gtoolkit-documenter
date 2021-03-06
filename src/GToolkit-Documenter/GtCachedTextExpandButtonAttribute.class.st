Class {
	#name : #GtCachedTextExpandButtonAttribute,
	#superclass : #BrGlamorousTrangleExpanderTextAttribute,
	#instVars : [
		'onCachingAction'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #initialization }
GtCachedTextExpandButtonAttribute >> initialize [
	super initialize.
	onCachingAction := [ :aBoolean :theAttribute | "do nothing" ].
]

{ #category : #accessing }
GtCachedTextExpandButtonAttribute >> isExpanded: aBoolean [
	super isExpanded: aBoolean.
	onCachingAction glamourValueWithArgs: { aBoolean. self }
]

{ #category : #accessing }
GtCachedTextExpandButtonAttribute >> onCachingDo: aBlock [
	self 
		assert: [ aBlock notNil ]
		description: [ 'On caching block must be non-nil' ].
	onCachingAction := aBlock
]
