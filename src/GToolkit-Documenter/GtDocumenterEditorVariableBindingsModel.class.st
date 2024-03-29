"
I hold ${class:GtSnippetBindings}$ that holds code snippet and example variable values.
I am used by ${class:GtDocumenterEditor}$.
!! Example 
Evaluating the code snippet in the following example stores ==aBook== variable value in the ${class:GtDocumenterEditor}$ instance: 
${example:GtDocumenterExamples>>#documentWithCodeblock|noCode=true|previewExpanded=true}$


"
Class {
	#name : #GtDocumenterEditorVariableBindingsModel,
	#superclass : #BrWidgetModel,
	#traits : 'TLepiterConstants',
	#classTraits : 'TLepiterConstants classTrait',
	#instVars : [
		'variableBindings'
	],
	#category : #'GToolkit-Documenter-! Editor - Model'
}

{ #category : #defaults }
GtDocumenterEditorVariableBindingsModel >> defaultVariableBindings [
	^ GtLocalVariablesBindings new
			localAt: self constants thisDocument 
			put: self.
]

{ #category : #'gt-extensions' }
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

{ #category : #initialization }
GtDocumenterEditorVariableBindingsModel >> initialize [
	super initialize.
	variableBindings := self defaultVariableBindings.
	
]

{ #category : #'api - variables' }
GtDocumenterEditorVariableBindingsModel >> variableBindings [
	<return: #TGtVariablesBindings>

	^ variableBindings
]

{ #category : #accessing }
GtDocumenterEditorVariableBindingsModel >> variableBindings: aGtSnippetBindings [
	self 
		assert: [ aGtSnippetBindings isNotNil ] 
		description: [ 'Variable bindings must be non-nil' ].
	variableBindings := aGtSnippetBindings
]
