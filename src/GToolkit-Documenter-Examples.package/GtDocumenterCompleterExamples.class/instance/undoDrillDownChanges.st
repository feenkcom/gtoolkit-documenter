completion
undoDrillDownChanges
	<gtExample>
	^ self
		openOn: ''
		withStrategy: self documenterStrategy
		entering: #(0 '${ch' #tabOn: ':a') , {[ :controller | self selectPreviewMatching: '*aa*' in: controller ]} , #(#cmdRightOn: #cmdLeftOn:)

	"${changes:aa/"	"with aa/ being highlighted"