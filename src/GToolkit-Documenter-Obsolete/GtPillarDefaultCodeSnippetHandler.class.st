Class {
	#name : #GtPillarDefaultCodeSnippetHandler,
	#superclass : #GtPillarScriptHandler,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #initialization }
GtPillarDefaultCodeSnippetHandler >> defaultPreviewStencilBuilder [
	^ [
		| composite |
		composite := BlElement new
			layout: BlLinearLayout new;
			padding: (BlInsets all: 5);
			border: (BlBorder paint: Color veryLightGray width: 1);
			constraintsDo: [ :c | 
				c textFlow pushLine.
				c vertical exact: 100.
				c horizontal matchParent ].
			(Compiler evaluate: tokens scriptBodyString)
				perform: tokens showParameterValue
				withArguments: {composite}.
		composite ]
]

{ #category : #private }
GtPillarDefaultCodeSnippetHandler >> doHandle [
	"Handle (style) given script, represented by script parameters and tokens, in the target text"

	self styleParameters.
	tokens scriptBodyString ifEmpty: [ ^ self ].
	self styleScriptBody.
	tokens hasShowParameter ifFalse: [ ^ self ].
	self styleExpandingCode
]
