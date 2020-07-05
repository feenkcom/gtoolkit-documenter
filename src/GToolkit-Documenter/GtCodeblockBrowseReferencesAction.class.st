Class {
	#name : #GtCodeblockBrowseReferencesAction,
	#superclass : #GtCodeblockAction,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Documenter-Code Snippet'
}

{ #category : #actions }
GtCodeblockBrowseReferencesAction >> browseReferences [
	"Browse a selected references"
	| aFilter |
	self hasNodeBody ifFalse: [ ^ self ].
	self isCursorPlacedInTheBody ifFalse: [ ^ self ].
	self allConditionsSatisfied ifFalse: [ ^ self ].
	aFilter := self extractReferencesFilter.
	aFilter ifNil: [ ^ self ].
	self element phlow spawnObject: aFilter.
]

{ #category : #accessing }
GtCodeblockBrowseReferencesAction >> element [
	<return: #BlElement>
	self 
		assert: [ element isNotNil ] 
		description: [ 'Element must be initialized before using it' ].
	^ element
]

{ #category : #accessing }
GtCodeblockBrowseReferencesAction >> element: aBlElement [
	self 
		assert: [ aBlElement isNotNil ] 
		description: [ 'Element must be non-nil' ].
	element := aBlElement
]

{ #category : #execution }
GtCodeblockBrowseReferencesAction >> execute [
	"Perform a default action"
	self browseReferences
]

{ #category : #'accessing - pharo code' }
GtCodeblockBrowseReferencesAction >> extractReferencesFilter [
	<return: #GtSearchReferencesFilter or: nil>
	^ self nodeBodySelection
		ifNil: [ self referencesFilterAtCursor ]
		ifNotNil: [ :aSelectedString | 
			self extractReferencesFilterFromString: aSelectedString asString ].
]

{ #category : #private }
GtCodeblockBrowseReferencesAction >> extractReferencesFilterFromString: aSelectedString [
	| aPharoNode |
	aPharoNode := GtPharoParser 
		parseWithErrors: aSelectedString 
		startingAt: GtPharoParser startingStateForStatement.
	[ aPharoNode isNil ]
		whileFalse: [ 
			(aPharoNode isKindOf: GtPharoSymbolLiteralNode)
				ifTrue: [ ^ self referencesFilterForSymbol: aPharoNode asSymbol ].
			(aPharoNode isKindOf: GtPharoMessageSendNode)
				ifTrue: [ aPharoNode := aPharoNode message ].
			(aPharoNode isKindOf: GtPharoMessageNode)
				ifTrue: [ ^ self referencesFilterForSymbol: aPharoNode selector ].
			aPharoNode := aPharoNode parent ].
	^ nil
]

{ #category : #'accessing - pharo code' }
GtCodeblockBrowseReferencesAction >> referencesFilterAtCursor [
	<return: #GtSearchReferencesFilter or: nil>
	| aPharoNode |
	aPharoNode := self nodeAtCursor.
	[ aPharoNode isNil ]
		whileFalse: [ 
			(aPharoNode isKindOf: GtPharoVariableNode)
				ifTrue: [ ^ self referencesFilterForVariable: aPharoNode name source ].
			(aPharoNode isKindOf: GtPharoSymbolLiteralNode)
				ifTrue: [ ^ self referencesFilterForSymbol: aPharoNode asSymbol ].
			(aPharoNode isKindOf: GtPharoMessageSendNode)
				ifTrue: [ aPharoNode := aPharoNode message ].
			(aPharoNode isKindOf: GtPharoMessageNode)
				ifTrue: [ ^ self referencesFilterForSymbol: aPharoNode selector ].
			aPharoNode := aPharoNode parent ].
	^ nil
]

{ #category : #'accessing - pharo code' }
GtCodeblockBrowseReferencesAction >> referencesFilterForSymbol: aSymbol [
	^ GtSearchReferencesFilter literal: aSymbol
]

{ #category : #'accessing - pharo code' }
GtCodeblockBrowseReferencesAction >> referencesFilterForVariable: aString [
	<return: #GtSearchReferencesFilter or: nil>
	| aBinding |
	aBinding := self evaluationReceiver class bindingOf: aString.
	aBinding ifNotNil: [ ^ GtSearchReferencesFilter literal: aBinding ].
	^ nil
]
