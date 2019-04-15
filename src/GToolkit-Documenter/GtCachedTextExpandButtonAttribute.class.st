Class {
	#name : #GtCachedTextExpandButtonAttribute,
	#superclass : #BrTextExpandButtonAttribute,
	#instVars : [
		'onCachingAction'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #accessing }
GtCachedTextExpandButtonAttribute >> affect: aBrText in: anEditorElement [
	^ (super affect: aBrText in: anEditorElement)
		margin: (BlInsets top: 3 right: 5 bottom: 0 left: 5)
]

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
