"
I am a utility subclass that simply adds the ability to raise an event when I am removed from the space or when the space is closed.
"
Class {
	#name : #GtDocumentEditorElement,
	#superclass : #BrEditorElement,
	#category : #'GToolkit-Documenter-Core'
}

{ #category : #'hooks - children' }
GtDocumentEditorElement >> onAddedToSceneGraph [
	self space when: BlSpaceClosedEvent do: [ :ann |
		self fireEvent: GtDocumentEditorElementRemovedFromSceneEvent new ].

	
]

{ #category : #'hooks - children' }
GtDocumentEditorElement >> onRemovedFromSceneGraph [
	self fireEvent: GtDocumentEditorElementRemovedFromSceneEvent new
]
