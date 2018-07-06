accessing - parameters
diffRope
	<return: #BlRopedText>
	| aBuilder aRopedText |
	aBuilder := PrettyTextDiffBuilder 
		from: self epiceaLog currentStateString 
		to: self epiceaLog newStateString.
	aRopedText := '' asRopedText.
	aBuilder
		patchSequenceDoIfMatch: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '  ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: Color black.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifInsert: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '+ ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: Color green muchDarker.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifRemove: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '- ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: Color red muchDarker.
			aRopedText insertString: String cr at: aRopedText size. ].
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BrFontGenericFamilyAttribute monospace } ].
	^ aRopedText