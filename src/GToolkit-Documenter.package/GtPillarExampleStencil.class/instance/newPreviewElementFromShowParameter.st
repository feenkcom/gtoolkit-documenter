instance creation
newPreviewElementFromShowParameter
	| exampleElement |

	exampleElement := GtPillarExampleElement
		withCode: self documentPart doNotDisplaySourceCodeParameterValue not.
	
	self maySetHeightOfPreview: exampleElement.
	
	exampleElement
		margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20);
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ].
	exampleElement
		example: self documentPart exampleMethod gtExample
		showBlock: [ :returnValue | 
			| view |
			self flag: 'Maybe use GtPillarInspectorStencil instead of this code?'.
			view := GtPhlowExplicitView on: returnValue perform: self documentPart showParameterValue.
			view asElementDo: [ :element |
				element constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ] ] ].
	self mayExpandResultPreviewIn: exampleElement.
	^ exampleElement