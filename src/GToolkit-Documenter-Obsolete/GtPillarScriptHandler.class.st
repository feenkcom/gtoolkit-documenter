Class {
	#name : #GtPillarScriptHandler,
	#superclass : #Object,
	#traits : 'GtDebuggingTrait',
	#classTraits : 'GtDebuggingTrait classTrait',
	#instVars : [
		'scriptParameters',
		'tokens',
		'sourceFile',
		'targetText',
		'codeSnippet',
		'previewStencilBuilder'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtPillarScriptHandler >> codeSnippet [
	^ codeSnippet
]

{ #category : #accessing }
GtPillarScriptHandler >> codeSnippet: anObject [
	codeSnippet := anObject
]

{ #category : #initialization }
GtPillarScriptHandler >> defaultPreviewStencilBuilder [
	^ self subclassResponsibility
]

{ #category : #private }
GtPillarScriptHandler >> doHandle [
	"Handle (style) given script, represented by script parameters and tokens, in the target text"
	^ self subclassResponsibility
]

{ #category : #'private-styles' }
GtPillarScriptHandler >> expandingAttributes [
	^ Array with: (BrTextExpandButtonAttribute new
		attributesCreatingBlock: [ self newPreviewAttribute ])
]

{ #category : #'gt-inspector-extension' }
GtPillarScriptHandler >> gtInspectorScriptParametersIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ self scriptParameters ifNotNil: [ :aDictionary |
		(aDictionary gtInspectorItemsIn: composite)
			title: [ 'Parameters' translated ];
			yourself ]
]

{ #category : #'gt-inspector-extension' }
GtPillarScriptHandler >> gtInspectorSourceDirectoryIn: composite [
	<gtInspectorPresentationOrder: 3>
	^ self sourceDirectory ifNotNil: [ :aFileReference | 
		(aFileReference gtInspectorItemsIn: composite)
			title: [ 'Source Directory' translated ];
			yourself ]
]

{ #category : #'gt-inspector-extension' }
GtPillarScriptHandler >> gtInspectorTargetTextIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ composite text 
		title: [ 'Target Text' translated ];
		display: [ self targetText ];
		when: [ self targetText notNil ];
		yourself
]

{ #category : #actions }
GtPillarScriptHandler >> handle [
	"Handle (style) given script, represented by script parameters and tokens, in the target text"
	[ self doHandle ]
		on: Error
		do: [ :exception | 
			self ifDebugMode: [ exception pass ].
			self traceCr: exception ]
]

{ #category : #initialization }
GtPillarScriptHandler >> initialize [
	super initialize.
	
	self previewStencil: self defaultPreviewStencilBuilder
	
	"self scriptParameters: Dictionary new."
	"self scriptParameters 
		at: self class showParameterName
		put: 'gtPrintIn:'"
]

{ #category : #'instance creation' }
GtPillarScriptHandler >> newPreviewAttribute [
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlockWithErrorCatching: [ :aBrText :aTextElement | 
			self newPreviewElementForText: aBrText inEditor: aTextElement ]
]

{ #category : #'instance creation' }
GtPillarScriptHandler >> newPreviewElementForText: aBrText inEditor: aTextElement [
	"Instantiate an element that has a role of code/example/result preview container."
	<return: #BlElement>
	| aPreviewStencil |

	aPreviewStencil := (self previewStencilBuilder
		text: aBrText;
		editor: aTextElement;
		codeSnippet: codeSnippet) build.

	^ aPreviewStencil asElement
]

{ #category : #'private-styles' }
GtPillarScriptHandler >> parametersTextAttributes [
	^ {(BrTextForegroundAttribute paint: Color gray)}
]

{ #category : #accessing }
GtPillarScriptHandler >> previewStencil: aPreviewStencilBuilder [
	"Set a builder responsible for creating a preview stencil that instanciates an element used
	to visually represent snippet result.
	
	aPreviewStencilBuilder can be a block closure of the following form:
	[ :aCodeSnippet :aBrEditorElement :aBrText | 'create preview here' ]

	"

	previewStencilBuilder := aPreviewStencilBuilder asStencilBuilder: GtOldPillarBrickStencilBuilder
]

{ #category : #accessing }
GtPillarScriptHandler >> previewStencilBuilder [
	"Return a builder responsible for creating a preview stencil that instanciates an element used
	to visually represent snippet result"
	<return: #GtOldPillarBrickStencilBuilder>

	^ previewStencilBuilder
]

{ #category : #accessing }
GtPillarScriptHandler >> scriptParameters [
	^ tokens scriptParameters
]

{ #category : #accessing }
GtPillarScriptHandler >> scriptParameters: anObject [
	scriptParameters := anObject
]

{ #category : #'accessing - convenience' }
GtPillarScriptHandler >> sourceDirectory [
	<return: #FileReference>
	^ self sourceFile parent
]

{ #category : #accessing }
GtPillarScriptHandler >> sourceFile [
	^ sourceFile
]

{ #category : #accessing }
GtPillarScriptHandler >> sourceFile: aFileReference [
	sourceFile := aFileReference
]

{ #category : #'private-styles' }
GtPillarScriptHandler >> styleExpandingCode [
	self targetText
		attributes: self expandingAttributes
		from: tokens closingBracketsEndPosition
		to: tokens closingBracketsEndPosition
]

{ #category : #'private-styles' }
GtPillarScriptHandler >> styleParameters [
	self targetText
		attributes: self parametersTextAttributes
		from: tokens parametersStartingPosition
		to: tokens parametersEndPosition
]

{ #category : #'private-styles' }
GtPillarScriptHandler >> styleScriptBody [
	| styler strategy |
	styler := BrRBTextStyler new.
	codeSnippet ifNotNil: [ 
		strategy := GtHighlightingBindingStrategy bindings: codeSnippet.
		styler workspace: strategy ].
	styler
		style:
			(self targetText
				from: tokens scriptBodyStartingPosition
				to: tokens scriptBodyEndPosition).
	self targetText
		attributes:
			{BrFontGenericFamilyAttribute monospace.
			(BrFontSizeAttribute size: 14)}
		from: tokens scriptBodyStartingPosition
		to: tokens scriptBodyEndPosition
]

{ #category : #accessing }
GtPillarScriptHandler >> targetText [
	^ targetText
]

{ #category : #accessing }
GtPillarScriptHandler >> targetText: anObject [
	targetText := anObject
]

{ #category : #accessing }
GtPillarScriptHandler >> tokens [
	^ tokens
]

{ #category : #accessing }
GtPillarScriptHandler >> tokens: anObject [
	tokens := anObject
]
