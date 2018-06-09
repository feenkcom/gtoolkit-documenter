as yet unclassified
newExecuteCodeButtonForText: aBrText inEditor: aTextElement
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
				self inform: 'styling'.
				self styleScriptBody.
				self styleResultPreview.
				aTextElement fireEvent: (BrTextStyledEvent new text: self targetText).
				aTextElement editor styleText ]
			for: anAction).
		self documentPart executeWithPlaygroundStrategy ].

	aStencil := GtPillarPlayButtonStencil new.
	aStencil label: self runButtonLabel.
	aStencil action: anAction.

	^ aStencil asElement