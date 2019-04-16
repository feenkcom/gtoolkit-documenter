Class {
	#name : #GtStyledCodeblockBuilder,
	#superclass : #GtStyledNodeBuilder,
	#category : #'GToolkit-Documenter-Styler Builder'
}

{ #category : #'style - code snippet' }
GtStyledCodeblockBuilder >> embedResult [
	"Put a circle button with a code snippet result"
	| aResult aSnippetInterval aGlobalInterval |
	aResult := self node cachedResult.
	aSnippetInterval := self node cachedEvaluatedInterval.
	aSnippetInterval ifNil: [ ^ self ].
	aGlobalInterval := self startNodeBody + aSnippetInterval.
	(self text from: aGlobalInterval last to: aGlobalInterval last)
		attribute: (GtPlaygroundEvaluatedCodeButtonAttribute new
			result: aResult;
			paint: (Color fromHexString: #'90CAF9'))
]

{ #category : #'style - code snippet' }
GtStyledCodeblockBuilder >> highlightEvaluatedCode [
	"Highlight evaluated code snippet part"
	| aSnippetInterval aGlobalInterval |
	aSnippetInterval := self node cachedEvaluatedInterval.
	aSnippetInterval ifNil: [ ^ self ].
	aGlobalInterval := self startNodeBody + aSnippetInterval.
	(self text from: aGlobalInterval first to: aGlobalInterval last)
		attribute: (GtPlaygroundEvaluatedCodeHighlightedAttribute new
				paint: (Color fromHexString: #'90CAF9'))
]

{ #category : #'accessing - code snippet' }
GtStyledCodeblockBuilder >> startNodeBody [
	"Return node's body starting position"
	<return: #Integer>
	^ self node scriptStartPositionInText: self text
]
