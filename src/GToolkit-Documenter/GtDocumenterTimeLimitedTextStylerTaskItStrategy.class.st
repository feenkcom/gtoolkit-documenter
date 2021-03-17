Class {
	#name : #GtDocumenterTimeLimitedTextStylerTaskItStrategy,
	#superclass : #BrTextStylerTaskItStrategy,
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #'instance creation' }
GtDocumenterTimeLimitedTextStylerTaskItStrategy >> newStylingCommandFor: aBlText with: aBlTextStyler inEditorElement: aBrEditorElement  afterDo: aBlock [
	<return: #BlTktTimeLimitedCommand>

	^ BlTktTimeLimitedCommand new
		command: (super newStylingCommandFor: aBlText with: aBlTextStyler inEditorElement: aBrEditorElement afterDo: aBlock);
		allowedDuration: 3 seconds
]
