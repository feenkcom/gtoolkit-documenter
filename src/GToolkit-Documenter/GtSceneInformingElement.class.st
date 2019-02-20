Class {
	#name : #GtSceneInformingElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #'hooks - children' }
GtSceneInformingElement >> onAddedToSceneGraph [
	self space when: BlSpaceClosedEvent do: [ :ann |
		self fireEvent: GtRemovedFromSceneEvent new ].
	self fireEvent: GtAddedToSceneEvent new.
]

{ #category : #'hooks - children' }
GtSceneInformingElement >> onRemovedFromSceneGraph [
	self fireEvent: GtRemovedFromSceneEvent new
]
