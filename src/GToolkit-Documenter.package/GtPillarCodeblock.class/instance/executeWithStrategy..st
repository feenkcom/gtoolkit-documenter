actions
executeWithStrategy: aGtBindingStrategy
	| newValue aBindings aCompiler |
	self 
		assert: [ aGtBindingStrategy notNil ] 
		description: [ 'Binding strategy has to be defined' ].

	aBindings := GtOutBindings new.
	aBindings bindings: self document.
	aGtBindingStrategy bindings: aBindings.
	aCompiler := self documentClass compiler
		source: self sourceCode readStream;
		compilationContext: (CompilationContext new
			class: self documentClass;
			forSyntaxHighlighting: false;
			bindings: aGtBindingStrategy;
			requestor: aGtBindingStrategy);
		receiver: self document.
	[ 
		newValue := aCompiler evaluate.
		aBindings value: newValue.
		result := newValue.
		isException := false.
		announcer announce: (GtCodeSnippetSuccessfulExecutionAnnouncement document: self document codeSnippet: self newValue: newValue).
	] on: Error do: [ :anException | 
		aBindings value: anException.
		result := anException.
		isException := true.
		announcer announce: (GtCodeSnippetFailedExecutionAnnouncement document: self document codeSnippet: self exception: anException).
	].
	