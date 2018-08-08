method - missing one
pillarContentWithNonExistingMethodAnnotation
	<gtExample>
	<label: 'Pillar content with a method annotation'>
	^ '${method:', self referencedClass , '>>#notExistingMethod}$'
