Class {
	#name : #GtResizablePreviewAttribute,
	#superclass : #GtPreviewAttribute,
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #accessing }
GtResizablePreviewAttribute >> doAffect: aBrText in: anEditorElement [
	^ GtResizablePreviewStencil new
		result: self result;
		showSelector: self showSelector;
		height: self height;
		asElement
]
