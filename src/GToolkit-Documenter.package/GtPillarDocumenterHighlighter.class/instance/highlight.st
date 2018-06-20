protocol
highlight
	"Highlight a given Pillar text.
	It modifies the given target text."
	| aPRDocument |
	aPRDocument := parser parse: self targetText asString.
	self
		assert: [ aPRDocument notNil ] 
		description: [ 'Parsing text should return a Pillar document' ].
	self
		assert: [ aPRDocument isPetit2Failure not ] 
		description: [ 'Target text should be a valid Pillar format' ].
	aPRDocument accept: self.
	^ self targetText