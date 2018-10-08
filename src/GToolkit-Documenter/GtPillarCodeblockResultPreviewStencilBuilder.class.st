Class {
	#name : #GtPillarCodeblockResultPreviewStencilBuilder,
	#superclass : #GtPillarBrickStencilBuilder,
	#category : #'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #'api - instantiation' }
GtPillarCodeblockResultPreviewStencilBuilder >> buildDefault [
	| anOutputText |
	
	anOutputText := ('(outs at: ' , self documentPart pillarNode counter asString , ')') asRopedText.
	anOutputText monospace.
	anOutputText foreground: (self documentPart isException
		ifTrue: [ Color red ]
		ifFalse: [ Color gray ]).

	^ GtPillarResultPreviewStencil new
		result: self documentPart result;
		outputInformation: anOutputText
]
