api - actions
highlight
	self styleParameters.
	self styleScriptBody.
	self styleExecutableCode.
	self documentPart hasResult ifTrue: [ self styleResultPreview ].