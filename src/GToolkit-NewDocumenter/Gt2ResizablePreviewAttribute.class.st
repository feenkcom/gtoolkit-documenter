Class {
	#name : #Gt2ResizablePreviewAttribute,
	#superclass : #Gt2PreviewAttribute,
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #accessing }
Gt2ResizablePreviewAttribute >> affect: aBrText in: anEditorElement [
	^ Gt2ResizablePreviewStencil new
		result: self result;
		showSelector: self showSelector;
		asElement
]
