Class {
	#name : #GtPillarEpiceaChangesHighlighter,
	#superclass : #GtPillarDocumentPartHighlighter,
	#category : 'GToolkit-Documenter-Epicea'
}

{ #category : #'private - styling' }
GtPillarEpiceaChangesHighlighter >> expandingStyleAttributes [
	| expandingAttribute previewAttribute |
	previewAttribute := self newPreviewAttribute.
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ self newPreviewAttribute ];
		createdAttributes: { previewAttribute };
		isExpanded: true.
	^ Array with: expandingAttribute with: previewAttribute
]

{ #category : #'private-container protocol' }
GtPillarEpiceaChangesHighlighter >> highlight [
	self styleAnnotationParameters.
	self styleAnnotationExpandingAttribute.
]

{ #category : #'instance creation' }
GtPillarEpiceaChangesHighlighter >> newPreviewAttribute [
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		stencil: (GtPillarEpiceaBrickStencilBuilder new documentPart: self documentPart)
]
