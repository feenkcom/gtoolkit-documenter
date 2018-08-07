pillar
emptyLiteralValue
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #key. '' })
		emptyValue: [ 'empty-value' ] 
		defaultValue: [ self error: 'Shold not call default value block' ].
	self assert: aValue equals: 'empty-value'.
	^ aValue