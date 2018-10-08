"
I build a visual preview of a result object with some additional output information

Example: 

[[[
	(GtPillarCodeSnippetResultPreviewStencil new
		result: Object new;
		outputInformation: 'custom output text') asElement
]]]
"
Class {
	#name : #GtPillarResultPreviewStencil,
	#superclass : #BrStencil,
	#traits : 'TGtPillarPreviewStencil',
	#classTraits : 'TGtPillarPreviewStencil classTrait',
	#instVars : [
		'result',
		'outputInformationText',
		'showMethod'
	],
	#category : #'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #'instance creation' }
GtPillarResultPreviewStencil >> create [
	"Return a preview element that is displayed in a document"
	<return: #BlElement>
	| aComposite aBarElement |

	aComposite := self newCompositeElement.
	
	"aBarElement := self newLeftAlignedToolbarElement.
	aBarElement addChild: self newOutsInformationElement.
	aBarElement addChild: (BlElement new look: GtFlexibleHorizontalSpaceLook).
	aBarElement addChild: self newInspectButtonElement.
	
	aComposite addChild: aBarElement.
	"aComposite addChild: self newInspectorElement.	
	aComposite addChild: (self newResizerBarElementOn: aComposite).
	
	^ aComposite 
]

{ #category : #initialization }
GtPillarResultPreviewStencil >> initialize [
	super initialize.
	
	result := nil. "nil is allowed, since result is an arbitrary object"
	outputInformationText := 'output' asRopedText.
	showMethod := GtDocumenterConstants defaultShowMethodName.
]

{ #category : #'instance creation' }
GtPillarResultPreviewStencil >> newInlinedCompositeElement [
	^ BlElement new look: GtPillarInlinedCompositeLook
]

{ #category : #'instance creation' }
GtPillarResultPreviewStencil >> newInspectButtonElement [
	<return: #BrButton>

	^ self newSlimButton
		"Stencils tend to be reusable, so we have to store a reference to the current result as a model of the view model"
		viewModelDo: [ :aViewModel | aViewModel model: self result ];
		label: 'Inspect';
		action: [ :aButtonElement :aButtonModel |
			aButtonElement fireEvent: (GLMBlocObjectToSelect new toSelect: aButtonModel model) ]
]

{ #category : #'instance creation' }
GtPillarResultPreviewStencil >> newInspectorElement [
	^ (GtPillarInspectorStencil new 
			inspect: self result;
			showMethod: self showMethod) asElement
]

{ #category : #'instance creation' }
GtPillarResultPreviewStencil >> newOutsInformationElement [
	^ BlTextElement text: self outputInformation
]

{ #category : #'api - accessing' }
GtPillarResultPreviewStencil >> outputInformation [
	<return: #BlText>

	^ outputInformationText
]

{ #category : #'api - accessing' }
GtPillarResultPreviewStencil >> outputInformation: aStringOrBrText [
	"Set output description to be displayed near the result preview"

	outputInformationText := aStringOrBrText asRopedText
]

{ #category : #'api - accessing' }
GtPillarResultPreviewStencil >> result [
	"Return an object for which we construct a preview"
	<return: #Object>

	^ result
]

{ #category : #'api - accessing' }
GtPillarResultPreviewStencil >> result: anObject [
	"Result is an arbitrary object, which can also be nil"

	result := anObject
]

{ #category : #'api - accessing' }
GtPillarResultPreviewStencil >> showMethod [
	<return: #Symbol>
	^ showMethod
]

{ #category : #'api - accessing' }
GtPillarResultPreviewStencil >> showMethod: aSymbol [
	self 
		assert: [ aSymbol notNil ] 
		description: [ 'Show method must be non-nil' ].
	showMethod := aSymbol asSymbol
]
