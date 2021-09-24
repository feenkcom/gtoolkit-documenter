Class {
	#name : 'GtStyledCodeblockBuilder',
	#superclass : 'GtStyledNodeBuilder',
	#category : 'GToolkit-Documenter-Styler Builder'
}

{ #category : 'style - code snippet' }
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
			action: [ 
				self node cachedDisplayPreview: true.
				self document styleTextRequest ])
]

{ #category : 'accessing - node' }
GtStyledCodeblockBuilder >> endMarkupText [
	"Return sub-text of the `]]]`"
	<return: #BlRope>
	| aStopEndMarkup |
	aStopEndMarkup := self stopEndMarkup.
	^ self text 
		from: aStopEndMarkup - self node endMarkupSize 
		to: aStopEndMarkup
]

{ #category : 'style - code snippet' }
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

{ #category : 'style - button' }
GtStyledCodeblockBuilder >> playButton [
	"Add play button to a node"
	self endMarkupText 
		attribute: (GtButtonAttribute new
			beAppend;
			stencil: [ BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				beSmallSize;
				margin: (BlInsets left: 3 right: 3);
				icon: BrGlamorousVectorIcons play;
				action: self properties action ])
]

{ #category : 'accessing - code snippet' }
GtStyledCodeblockBuilder >> startNodeBody [
	"Return node's body starting position"
	<return: #Integer>
	^ self node scriptStartPositionInText: self text
]

{ #category : 'accessing - node' }
GtStyledCodeblockBuilder >> stopEndMarkup [
	"Return position of the starting part of the end markup `]]]`"
	<return: #Number>
	^ self node stopEndMarkupInText: self text.
]
