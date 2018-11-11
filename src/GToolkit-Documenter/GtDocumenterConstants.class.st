Class {
	#name : #GtDocumenterConstants,
	#superclass : #Object,
	#category : #'GToolkit-Documenter-Settings'
}

{ #category : #'accessing - pillar annotation tags' }
GtDocumenterConstants class >> changesTag [
	^ 'changes2'
]

{ #category : #'accessing - pillar annotation tags' }
GtDocumenterConstants class >> classTag [
	^ 'class2'
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> classesParameterName [
	^ #classes
]

{ #category : #'accessing - ui' }
GtDocumenterConstants class >> defaultExecuteButtonIcon [
	"Default an icon stencil used for executable buttons"
	<return: #BrStencil>

	^ GtPillarPlayButtonIconStencil new
]

{ #category : #'accessing - ui' }
GtDocumenterConstants class >> defaultExecuteButtonLabel [
	"Default label used for example for button labels, [[[label=Run]]]"
	^ 'Run'
]

{ #category : #'accessing - pillar default parameter values' }
GtDocumenterConstants class >> defaultShowExamplesMethodName [
	^ #gtExamplesFor:
]

{ #category : #'accessing - pillar default parameter values' }
GtDocumenterConstants class >> defaultShowMethodName [
	^ #gtViewsFor:
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> doNotDisplaySourceCodeParameterName [
	^ #noCode
]

{ #category : #'accessing - ui' }
GtDocumenterConstants class >> exactPreviewHeight [
	^ 200
]

{ #category : #'accessing - pillar annotation tags' }
GtDocumenterConstants class >> exampleTag [
	^ 'example'
]

{ #category : #'accessing - pillar annotation tags' }
GtDocumenterConstants class >> examplesTag [
	^ 'examples'
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> expandedPreviewParemeterName [
	^ #expandedPreview
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> expandedViewParameterName [
	^ #expanded
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> fileParameterName [
	^ #file
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> heightParameterName [
	^ #height
]

{ #category : #'accessing - pillar annotation tags' }
GtDocumenterConstants class >> icebergFileTag [
	^ 'icebergFile2'
]

{ #category : #'accessing - directory names' }
GtDocumenterConstants class >> localGtDirectory [
	^ 'gt-extra'
]

{ #category : #'accessing - pillar annotation tags' }
GtDocumenterConstants class >> methodTag [
	^ 'method2'
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> methodsParameterName [
	^ #methods
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> nameParameterName [
	^ #name
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> packagesParameterName [
	^ #packages
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> pathParameterName [
	^ #path
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> previewHeightParameterName [
	^ #previewHeight
]

{ #category : #'accessing - variables' }
GtDocumenterConstants class >> resultVariableName [
	"Return a variable name to which code snippet results are assigned"
	^ #out
]

{ #category : #'accessing - variables' }
GtDocumenterConstants class >> resultsVariableName [
	"Return a variable name to which code snippet results are assigned"
	^ #outs
]

{ #category : #'accessing - pillar parameter names' }
GtDocumenterConstants class >> showParameterName [
	^ #show
]
