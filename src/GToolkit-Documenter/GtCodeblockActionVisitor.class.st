Class {
	#name : 'GtCodeblockActionVisitor',
	#superclass : 'GtDocumentVisitor',
	#instVars : [
		'action'
	],
	#category : 'GToolkit-Documenter-Code Snippet'
}

{ #category : 'accessing' }
GtCodeblockActionVisitor >> action [
	<return: #GtCodeblockAction>
	self 
		assert: [ action isNotNil ] 
		description: [ 'Codeblock action must be initialized before using it' ].
	^ action
]

{ #category : 'accessing' }
GtCodeblockActionVisitor >> action: aGtCodeblockAction [
	self 
		assert: [ aGtCodeblockAction isNotNil ] 
		description: [ 'Codeblock action must be non-nil' ].
	action := aGtCodeblockAction
]

{ #category : 'actions' }
GtCodeblockActionVisitor >> performAction: aCodeBlock [
	self action
		node: aCodeBlock;
		value
]

{ #category : 'visiting-document' }
GtCodeblockActionVisitor >> visitCodeblock: aCodeBlock [
	super visitCodeblock: aCodeBlock.
	self performAction: aCodeBlock.
]
