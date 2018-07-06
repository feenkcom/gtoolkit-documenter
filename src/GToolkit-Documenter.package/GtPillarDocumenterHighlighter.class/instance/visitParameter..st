visiting
visitParameter: aParameter
	aParameter isValid ifFalse: [ 
		(self targetText
			from: aParameter start 
			to: aParameter stop)
				foreground: Color red ].
	super visitParameter: aParameter