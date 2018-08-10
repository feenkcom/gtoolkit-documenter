preview
showPreview: aBlockOrSymbol
	"Get return value of attached example and evaluate a given block
	with resulting object as an argument in order to transform it
	into a visual element to be opened as a preview"
	| aResultElement exampleResult |

	self
		assert: [ previewElement hasParent not ]
		description: [ 'Can not show preview if it is already opened' ].

	"Only resizer bar is present"
	self
		assert: [ previewElement hasChildren not ]
		description: [ 'Preview container must be empty' ].

	"we don't add resulting element directly, but instead put
	in a container that matches parent. This allows us to preserve
	layout constrains of resulting element untouched"
	exampleResult := self example result.
	aResultElement := exampleResult hasException 
		ifTrue: [ exampleResult exampleException asDebuggableElement ]
		ifFalse: [ self ensurePreviewElement: [ aBlockOrSymbol value: exampleResult returnValue ] ].
	self
		assert: [ aResultElement isNotNil ]
		description: [ 'Resulting element must not be nil' ].

	previewElement addChildFirst: aResultElement.
	(GtPillarResizerBarStencil new 
		stencil: previewElement) asElement.
	self addChild: previewElement