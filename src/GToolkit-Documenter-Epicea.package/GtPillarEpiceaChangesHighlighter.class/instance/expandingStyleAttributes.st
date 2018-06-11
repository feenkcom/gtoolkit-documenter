private - styling
expandingStyleAttributes
	| expandingAttribute previewAttribute |
	previewAttribute := self newPreviewAttribute.
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ self newPreviewAttribute ];
		createdAttributes: { previewAttribute };
		isExpanded: true.
	^ Array with: expandingAttribute with: previewAttribute