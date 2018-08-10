instance creation
newPreviewElementFromShowParameter
	| exampleElement |

	exampleElement := GtPillarExampleElement
		withCode: self documentPart shouldDisplaySourceCode.
	
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
			view := returnValue perform: self documentPart showMessageName withArguments: {GtPhlowExplicitView new}.
			view asElementDo: [ :element |
				element constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ] ] ].
	self mayExpandResultPreviewIn: exampleElement.
	^ exampleElement