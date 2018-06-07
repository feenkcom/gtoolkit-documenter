private-styles
expandingAttributesForExampleAnnotation: aGtPillarExecutableNode
	| expandingAttribute |
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ 
			self newPreviewAttributeForExampleAnnotation: aGtPillarExecutableNode ].
	^ Array with: expandingAttribute.
	"^ aGtPillarExampleAnnotation shouldBeExpanded
		ifFalse: [ attributes ]
		ifTrue: [ | previewAttribute |
			previewAttribute := self newPreviewAttribute.
			expandingAttribute isExpanded: true.
			expandingAttribute createdAttributes: { previewAttribute }.
			attributes copyWith: previewAttribute ]."