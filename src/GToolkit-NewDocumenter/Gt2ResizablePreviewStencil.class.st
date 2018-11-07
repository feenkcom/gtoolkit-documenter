Class {
	#name : #Gt2ResizablePreviewStencil,
	#superclass : #Gt2PreviewStencil,
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #'instance creation' }
Gt2ResizablePreviewStencil >> newContainerFor: aWrappedElement [
	| aContainer aResizableElement |
	aContainer := BlElement new.
	aResizableElement := BlElement new.
	^ aContainer
		layout: BlLinearLayout vertical;
		look: Gt2PreviewLook + BrShadowLook;
		addChild: (aResizableElement 
			addChild: aWrappedElement;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical exact: 300 ]);
		addChild: (BrResizer new
			target: aResizableElement;
			"addEventHandlerOn: BlDoubleClickEvent do: [ :anEvent |
				aResizableElement constraintsDo: [ :c | c vertical fitContent ] ]; "
			beBottom;
			look: BrGlamorousResizerLook;
			constraintsDo: [ :c | c ignoredByLayout ]);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ]
]
