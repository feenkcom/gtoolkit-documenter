"
I handle executor scripts that includes code to uxecute.

This is how the Pillar definition looks like:

```
[[[executor
Metacello new
   baseline: 'FeenkXd';
   repository: 'github://feenkcom/xd/src';
   load.
]]]
```

This is how it looks like in Bloc (you need Bloc view enabled):

[[[executor
Metacello new
   baseline: 'FeenkXd';
   repository: 'github://feenkcom/xd/src';
   load.
]]]

"
Class {
	#name : #GtPillarExecutableCodeSnippetHandler,
	#superclass : #GtPillarScriptHandler,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #initialization }
GtPillarExecutableCodeSnippetHandler >> defaultPreviewStencilBuilder [
	^ GtOldDocumenterCodeSnippetResultPreviewStencilBuilder new
]

{ #category : #private }
GtPillarExecutableCodeSnippetHandler >> doHandle [
	"Handle (style) given script, represented by script parameters and tokens, in the target text"
	self styleParameters.
	self styleScriptBody.
	self styleExecutableCode.
	self codeSnippet hasResult ifTrue: [ self styleExpandingCode ].
]

{ #category : #'private-styles' }
GtPillarExecutableCodeSnippetHandler >> executableCodeSnippetAttributes [
	^ { self newExecuteCodeSnippetAttribute }
]

{ #category : #'private-styles' }
GtPillarExecutableCodeSnippetHandler >> expandingAttributes [
	^ { self newPreviewAttribute }
]

{ #category : #'instance creation' }
GtPillarExecutableCodeSnippetHandler >> newExecuteCodeButtonForText: aBrText inEditor: aTextElement [
	"Instantiate an element that has a role of code/example/result preview container."
	<return: #BlElement>

	| aStencil anAction |

	anAction := nil.
	anAction := [
		"create a `once` subscription to restyle text once code snippet is executed.
		We should not restyle text right after the `execute` statement since execution
		could happen asynchronous"
		(codeSnippet
			when: GtCodeSnippetExecutionAnnouncement
			doOnce: [ aTextElement editor styleText ]
			for: anAction).
		codeSnippet executeWithPlaygroundStrategy ].

	aStencil := GtPillarPlayButtonStencil new.
	aStencil label: codeSnippet label.
	aStencil action: anAction.

	^ aStencil asElement
]

{ #category : #'instance creation' }
GtPillarExecutableCodeSnippetHandler >> newExecuteCodeSnippetAttribute [
	^ GtPillarInlinedTextAdornmentDynamicAttribute new
		beAppend;
		elementBlockWithErrorCatching: [ :aBrText :aTextElement | 
			self newExecuteCodeButtonForText: aBrText inEditor: aTextElement ]
]

{ #category : #'private-styles' }
GtPillarExecutableCodeSnippetHandler >> styleExecutableCode [
	self targetText
		attributes: self executableCodeSnippetAttributes
		from: tokens closingBracketsEndPosition
		to: tokens closingBracketsEndPosition
]
