private - styling
expandingStyleAttributes
	| expandingAttribute |
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ self newPreviewAttribute ].
	^ Array with: expandingAttribute