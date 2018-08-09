pillar - parameter values
trueStringValue
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #key. 'tRuE' })
		emptyValue: [ self error: 'Should not call empty value block' ] 
		defaultValue: [ self error: 'Shold not call default value block' ].
	self assert: aValue.
	^ aValue