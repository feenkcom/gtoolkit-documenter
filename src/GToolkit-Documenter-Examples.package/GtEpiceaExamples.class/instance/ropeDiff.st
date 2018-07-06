diff
ropeDiff
	<gtExample>
	<label: 'A way to do BrRope diff'>
	| text |
	text := '' asRopedText.
	(PrettyTextDiffBuilder 
		from: (True >> #and:) sourceCode 
		to: (True >> #or:) sourceCode)
		patchSequenceDoIfMatch: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '  ' at: text size.
			text insertString: string at: text size.
			(text from: initialPosition to: text size)
				foreground: Color black.
			text insertString: String cr at: text size. ]
		ifInsert: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '+ ' at: text size.
			text insertString: string at: text size.
			(text from: initialPosition to: text size)
				foreground: Color green muchDarker.
			text insertString: String cr at: text size. ]
		ifRemove: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '- ' at: text size.
			text insertString: string at: text size.
			(text from: initialPosition to: text size)
				foreground: Color red muchDarker.
			text insertString: String cr at: text size. ].
	text attributes: { BrFontGenericFamilyAttribute monospace }.
	^ text