accessing - parameters
finalCodeRope
	<return: #BlRopedText>
	| aRopedText |
	aRopedText := self epiceaLog newStateString asRopedText.
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BrFontGenericFamilyAttribute monospace } ].
	^ aRopedText