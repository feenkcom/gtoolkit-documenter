method - existing expanded
pillarContentWithExpandedMethodAnnotation
	<gtExample>
	<label: 'Pillar content with a method annotation'>
	^ '${method:', self referencedMethod printString, '|', self constants expandedViewParameterName, '}$'