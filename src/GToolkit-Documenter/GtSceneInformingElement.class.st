Class {
	#name : #GtSceneInformingElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #'hooks - children' }
GtSceneInformingElement >> onAddedToSceneGraph [
	| eventHandler |
	super onAddedToSceneGraph.
	
	eventHandler := BlEventHandler on: BlSpaceClosedEvent do: [ :anEvent |
		self fireEvent: GtRemovedFromSceneEvent new.
		anEvent space removeEventHandler: eventHandler. ].

	self space addEventHandler: eventHandler.
	self fireEvent: GtAddedToSceneEvent new
]

{ #category : #'hooks - children' }
GtSceneInformingElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

	self fireEvent: GtRemovedFromSceneEvent new
]
