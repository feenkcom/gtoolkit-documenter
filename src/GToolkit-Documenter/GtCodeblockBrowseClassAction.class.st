Class {
	#name : #GtCodeblockBrowseClassAction,
	#superclass : #GtCodeblockAction,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Documenter-Code Snippet'
}

{ #category : #actions }
GtCodeblockBrowseClassAction >> browseClass [
	"Browse a selected class"
	| aVariableNode aVariableName aBehavior |
	self haltOnce.
	self hasNodeBody ifFalse: [ ^ self ].
	self isCursorPlacedInTheBody ifFalse: [ ^ self ].
	self allConditionsSatisfied ifFalse: [ ^ self ].
	aVariableNode := self nodeBodySelection
		ifNil: [ self variableNodeAtCursor ]
		ifNotNil: [ :aSelectedString | 
			self extractVariableNodeFromString: aSelectedString ].
	aVariableNode ifNil: [ ^ self ].
	aVariableName := aVariableNode name value asSymbol.
	aBehavior := Smalltalk globals at: aVariableName ifAbsent: [ ^ self ].
	aBehavior isBehavior ifFalse: [ ^ self ].
	self element phlow spawnObject: (GtClassCoder forClass: aBehavior).
]

{ #category : #accessing }
GtCodeblockBrowseClassAction >> element [
	<return: #BlElement>
	self 
		assert: [ element isNotNil ] 
		description: [ 'Element must be initialized before using it' ].
	^ element
]

{ #category : #accessing }
GtCodeblockBrowseClassAction >> element: aBlElement [
	self 
		assert: [ aBlElement isNotNil ] 
		description: [ 'Element must be non-nil' ].
	element := aBlElement
]

{ #category : #execution }
GtCodeblockBrowseClassAction >> execute [
	"Perform a default action"
	self browseClass
]

{ #category : #'accessing - pharo code' }
GtCodeblockBrowseClassAction >> extractVariableNodeFromString: aString [
	"Return a Pharo source code AST node or nil"
	<return: #GtPharoProgramNode or: nil>
	| aPharoNode |
	self 
		assert: [ aString isNotNil ]
		description: [ 'Pharo source code must be non-nil' ].
	self 
		assert: [ aString isString ]
		description: [ 'Pharo source code must be a string' ].
	aPharoNode := GtPharoParser 
		parseWithErrors: aString
		startingAt: GtPharoParser startingStateForStatement.
	[ aPharoNode isNil ]
		whileFalse: [ 
			(aPharoNode isKindOf: GtPharoVariableNode)
				ifTrue: [ ^ aPharoNode ].
			aPharoNode := aPharoNode parent ].
	^ nil
]

{ #category : #'accessing - pharo code' }
GtCodeblockBrowseClassAction >> parserStartingState [
	^ GtPharoParser startingStateForMethodSequence
]

{ #category : #'accessing - pharo code' }
GtCodeblockBrowseClassAction >> sourceAst [
	^ GtPharoParser 
		parseWithErrors: self nodeBody 
		startingAt: self parserStartingState
]

{ #category : #'accessing - pharo code' }
GtCodeblockBrowseClassAction >> variableNodeAtCursor [
	<return: #GtPharoVariableNode or: nil>
	self cursorPositionDo: [ :aPosition |
			| aNodeTextStartPosition | 
			aNodeTextStartPosition := aPosition - self startNodeBody.
			[ self sourceAst
				withAllNodesOfType: GtPharoVariableNode
				do: [ :eachNode | 
					(aNodeTextStartPosition between: eachNode startPosition and: eachNode stopPosition)
						ifTrue: [ ^ eachNode ] ] ]
				on: Error
				do: [ :anException | anException return ] ].
	^ nil
]
