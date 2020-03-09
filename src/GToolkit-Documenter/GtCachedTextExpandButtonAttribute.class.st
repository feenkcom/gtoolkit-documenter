Class {
	#name : #GtCachedTextExpandButtonAttribute,
	#superclass : #BrTextExpandButtonAttribute,
	#instVars : [
		'onCachingAction'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #accessing }
GtCachedTextExpandButtonAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ (super affect: aTBrTextEditorTextualPiece in: anEditorElement)
		margin: (BlInsets top: 3 right: 0 bottom: 0 left: 0)
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
