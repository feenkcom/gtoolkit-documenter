completion
drillDownChanges
	<gtExample>
	^ self
		openOn: ''
		withStrategy: self documenterStrategy
		entering: #(0 '${ch' #tabOn: ':a') , {[ :controller | self selectPreviewMatching: '*aa*' in: controller ]} , #(#cmdRightOn:)

	"${changes:aa/1"	"with 1 being highlighted"