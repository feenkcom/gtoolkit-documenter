api - actions
highlight
	self styleParameters.
	self styleClosingBrackets.
	self pillarNode isSmalltalkLanguage ifFalse: [
		self styleScriptBody.
		^ self ].
	self styleSmalltalkScriptBody.
	self styleExecutableCode.
	self documentPart hasResult ifTrue: [ self styleResultPreview ].