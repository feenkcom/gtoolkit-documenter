Class {
	#name : #Gt2ResizablePreviewStencil,
	#superclass : #Gt2PreviewStencil,
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #'instance creation' }
Gt2ResizablePreviewStencil >> newContainerFor: aWrappedElement [
	| aResult |
	aResult := aWrappedElement asVerticallyResizableDo: [ :anElement | 
		anElement 
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical exact: self height ]
		 ].
	aResult addLook: Gt2PreviewLook.
	^ aResult
]
