Class {
	#name : #GtPillarCodeblockHighlighter,
	#superclass : #GtPillarDocumentPartHighlighter,
	#category : 'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'accessing - pillar node' }
GtPillarCodeblockHighlighter >> closingBracketsEndPosition [
	<return: #Integer>
	^ self documentPart pillarNode stop
]

{ #category : #'accessing - pillar node' }
GtPillarCodeblockHighlighter >> closingBracketsStartingPosition [
	<return: #Integer>
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.	
	^ aPillarNode stop - self endMarkupSize
]

{ #category : #'accessing - pillar node' }
GtPillarCodeblockHighlighter >> endMarkupSize [
	^ (PR2PillarGrammar endMarkups at: PRCodeblock) size
]

{ #category : #'api - actions' }
GtPillarCodeblockHighlighter >> highlight [
	self styleParameters.
	self styleClosingBrackets.
	self pillarNode isSmalltalkLanguage ifFalse: [
		self styleScriptBody.
		^ self ].
	self styleSmalltalkScriptBody.
	self styleExecutableCode.
	self documentPart hasResult ifTrue: [ self styleResultPreview ].
]

{ #category : #'instance creation' }
GtPillarCodeblockHighlighter >> newExecuteCodeButtonForText: aBrText inEditor: aTextElement [
	"Instantiate an element that has a role of code/example/result preview container."
	<return: #BlElement>

	| aStencil anAction |

	anAction := nil.
	anAction := [
		"create a `once` subscription to restyle text once code snippet is executed.
		We should not restyle text right after the `execute` statement since execution
		could happen asynchronous"
		(self documentPart
			when: GtCodeSnippetExecutionAnnouncement
			doOnce: [
				aTextElement editor styleText ]
			for: anAction).
		self documentPart executeWithPlaygroundStrategy ].

	aStencil := GtPillarPlayButtonStencil new.
	aStencil label: self runButtonLabel.
	aStencil action: anAction.

	^ aStencil asElement
]

{ #category : #'instance creation' }
GtPillarCodeblockHighlighter >> newExecuteCodeSnippetAttribute [
	^ GtPillarInlinedTextAdornmentDynamicAttribute new
		beAppend;
		stencil: [ :aBrText :aTextElement | 
			self newExecuteCodeButtonForText: aBrText inEditor: aTextElement ]
]

{ #category : #'executable node - accessing' }
GtPillarCodeblockHighlighter >> parametersStop [
	<return: #Integer>
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.	
	^ aPillarNode stop - aPillarNode text size - self endMarkupSize - 2
]

{ #category : #'private-styles' }
GtPillarCodeblockHighlighter >> resultPreviewAttributes [
	^ {
		BrTextAdornmentDynamicAttribute new
			beAppend;
			stencil: (GtPillarCodeblockResultPreviewStencilBuilder new documentPart: self documentPart)
		}
]

{ #category : #'accessing - pillar node' }
GtPillarCodeblockHighlighter >> runButtonLabel [
	<return: #String>
	^ self documentPart pillarNode label 
		ifEmpty: [ GtDocumenterConstants defaultExecuteButtonLabel ]
]

{ #category : #'accessing - pillar node' }
GtPillarCodeblockHighlighter >> scriptBodyEndPosition [
	<return: #Integer>
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.	
	^ aPillarNode stop - self endMarkupSize - 1
]

{ #category : #'accessing - pillar node' }
GtPillarCodeblockHighlighter >> scriptBodyStartingPosition [
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.
	^ aPillarNode stop - self endMarkupSize - aPillarNode text size - 1
]

{ #category : #'private-styles' }
GtPillarCodeblockHighlighter >> styleClosingBrackets [
	(self targetText
		from: self pillarNodeStop - self endMarkupSize
		to: self pillarNodeStop)
			foreground: Color gray
]

{ #category : #'private-styles' }
GtPillarCodeblockHighlighter >> styleExecutableCode [
	(self targetText
		from: self closingBracketsStartingPosition
		to: self closingBracketsEndPosition - 1)
			attributes: { self newExecuteCodeSnippetAttribute }
]

{ #category : #'private-styles' }
GtPillarCodeblockHighlighter >> styleParameters [
	(self targetText
		from: self pillarNodeStart 
		to: self parametersStop)
			foreground: Color gray
]

{ #category : #'private-styles' }
GtPillarCodeblockHighlighter >> styleResultPreview [
	(self targetText
		from: self closingBracketsEndPosition
		to: self closingBracketsEndPosition)
			attributes: self resultPreviewAttributes
]

{ #category : #'private-styles' }
GtPillarCodeblockHighlighter >> styleScriptBody [
	(self targetText
		from: self scriptBodyStartingPosition
		to: self scriptBodyEndPosition)
		monospace;
		fontSize: 14
]

{ #category : #'private-styles' }
GtPillarCodeblockHighlighter >> styleSmalltalkScriptBody [
	| styler strategy |
	styler := BrRBTextStyler new.
	strategy := GtHighlightingBindingStrategy
		bindings: self documentPart outBindings.
	styler workspace: strategy.
	styler
		style:
			(self targetText
				from: self scriptBodyStartingPosition
				to: self scriptBodyEndPosition).
	self styleScriptBody
]
