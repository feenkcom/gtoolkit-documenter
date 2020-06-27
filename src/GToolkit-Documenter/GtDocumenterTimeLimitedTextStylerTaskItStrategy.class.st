Class {
	#name : #GtDocumenterTimeLimitedTextStylerTaskItStrategy,
	#superclass : #BrTextStylerTaskItStrategy,
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #'instance creation' }
GtDocumenterTimeLimitedTextStylerTaskItStrategy >> newStylingCommandFor: aBlText afterDo: aBlock [
	<return: #BlTktTimeLimitedCommand>
	^ BlTktTimeLimitedCommand new
		command: (super newStylingCommandFor: aBlText afterDo: aBlock);
		allowedDuration: 3 seconds
]
