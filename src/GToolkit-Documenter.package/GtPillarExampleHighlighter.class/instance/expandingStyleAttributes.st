private-styles
expandingStyleAttributes
	| expandingAttribute |
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ self newPreviewAttribute ].
	^ self documentPart shouldBeExpanded
		ifFalse: [ Array with: expandingAttribute ]
		ifTrue: [ | previewAttribute |
			previewAttribute := self newPreviewAttribute.
			expandingAttribute isExpanded: true.
			expandingAttribute createdAttributes: { previewAttribute }.
			Array with: expandingAttribute with: previewAttribute ].