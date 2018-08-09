pillar - parameter values
defaultBooleanValue
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #anotherKey. '' })
		emptyValue: [ self error: 'Should not call empty value block' ] 
		defaultValue: [ 'default-value' ].
	self assert: aValue equals: 'default-value'.
	^ aValue