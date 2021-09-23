"
I hold ${class:GtSnippetBindings}$ that holds code snippet and example variable values.
I am used by ${class:GtDocumenterEditor}$.
!! Example 
Evaluating the code snippet in the following example stores ==aBook== variable value in the ${class:GtDocumenterEditor}$ instance: 
${example:GtDocumenterExamples>>#documentWithCodeblock|noCode=true|previewExpanded=true}$


"
Class {
	#name : 'GtDocumenterEditorVariableBindingsModel',
	#superclass : 'BrWidgetModel',
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'variableBindings'
	],
	#category : 'GToolkit-Documenter-! Editor - Model'
}

{ #category : 'defaults' }
GtDocumenterEditorVariableBindingsModel >> defaultVariableBindings [
	^ GtSnippetBindings new
			at: self constants thisDocument 
			put: self.
]

{ #category : 'gt-extensions' }
GtDocumenterEditorVariableBindingsModel >> gtVariableBindingsFor: aView [
	<gtView>
	variableBindings ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Variables';
		priority: 1;
		object: [ self variableBindings ];
		view: #gtBindingsFor:;
		actionUpdateButtonTooltip: 'Update variable list'
]

{ #category : 'initialization' }
GtDocumenterEditorVariableBindingsModel >> initialize [
	super initialize.
	variableBindings := self defaultVariableBindings.
	
]

{ #category : 'api - variables' }
GtDocumenterEditorVariableBindingsModel >> variableBindings [
	<return: #GtSnippetBindings>
	^ variableBindings
]

{ #category : 'accessing' }
GtDocumenterEditorVariableBindingsModel >> variableBindings: aGtSnippetBindings [
	self 
		assert: [ aGtSnippetBindings isNotNil ] 
		description: [ 'Variable bindings must be non-nil' ].
	variableBindings := aGtSnippetBindings
]
