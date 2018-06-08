private-styles
expandingAttributes
	| expandingAttribute |
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ self newPreviewAttribute ].
	^ Array with: expandingAttribute.
	"^ aGtPillarExampleAnnotation shouldBeExpanded
		ifFalse: [ attributes ]
		ifTrue: [ | previewAttribute |
			previewAttribute := self newPreviewAttribute.
			expandingAttribute isExpanded: true.
			expandingAttribute createdAttributes: { previewAttribute }.
			attributes copyWith: previewAttribute ]."