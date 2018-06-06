protocol
highlight
	"Highlight a given Pillar text.
	It modifies the given target text."
	| aPRDocument |
	aPRDocument := GtPillarExtendedParser new
		parse: self targetText asString.
	self
		assert: [ aPRDocument notNil ] 
		description: [ 'Parsing text should return a Pillar document' ].
	aPRDocument accept: self.
	^ self targetText