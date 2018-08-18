private
exampleClassesStartingWith: aString
	^ (self exampleClasses first: max startingWith: aString)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: aString size)
				deleting: 0
				at: position
				prefixSize: aString size ]