private-container protocol
highlight
	self styleParameters.
	self styleScriptBody.
	self styleExecutableCode.
	"self codeSnippet hasResult ifTrue: [ self styleExpandingCode ]."