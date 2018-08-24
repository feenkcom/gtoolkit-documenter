Class {
	#name : #GtDocBindingExamples,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #'out bindings' }
GtDocBindingExamples >> codeSnippetWithPlaygroundBindings [
	<gtExample>
	<label: 'Code snippet with playground bindings'>
	| bindings playground |
	playground := self playgroundBindings.
	bindings := self outBindings.
	bindings bindings: playground.
	self assert: bindings bindings equals: playground.
	^ bindings
]

{ #category : #'binding strategy' }
GtDocBindingExamples >> defaultHighlightingBindingStrategy [
	<gtExample>
	<label: 'Default highlighting binding strategy'>
	^ GtHighlightingBindingStrategy new
]

{ #category : #'binding strategy' }
GtDocBindingExamples >> defaultPlaygroundBindingStrategy [
	<gtExample>
	<label: 'Default playground binding strategy'>
	^ GtPlaygroundBindingStrategy new
]

{ #category : #document }
GtDocBindingExamples >> documentWithOneCodeSnippet [
	<gtExample>
	| codeSnippet document |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self emptyDocument.
	codeSnippet := self outBindings.
	codeSnippet value: 108.
	codeSnippet index: 1.
	codeSnippet document: document.
	^ document
]

{ #category : #document }
GtDocBindingExamples >> documentWithTwoCodeSnippets [
	<gtExample>
	| codeSnippet document out |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self documentWithOneCodeSnippet.
	codeSnippet := self outBindings.
	codeSnippet value: 7.
	codeSnippet index: 2.
	codeSnippet document: document.
	out := codeSnippet bindingOf: GtDocumenterConstants resultVariableName.
	self assert: out notNil.
	self assert: out value equals: 108.
	^ document
]

{ #category : #document }
GtDocBindingExamples >> documentWithTwoUninitializedCodeSnippets [
	<gtExample>
	| codeSnippetOne document codeSnippetTwo result |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self emptyDocument.
	codeSnippetOne := self outBindings.
	codeSnippetOne index: 1.
	codeSnippetOne document: document.
	codeSnippetTwo := self outBindings.
	codeSnippetTwo index: 2.
	codeSnippetTwo document: document.
	result := codeSnippetTwo bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ document
]

{ #category : #document }
GtDocBindingExamples >> emptyDocument [
	<gtExample>
	<label: 'Default document'>
	| aDocument aSubscriptions |
	aDocument := GtDocument new.
	aSubscriptions := SystemAnnouncer uniqueInstance subscriptions subscriptions 
		select: [ :eachSubscription | eachSubscription subscriber = aDocument systemChangesHandler ].
	self assert: aSubscriptions isCollection.
	self assert: aSubscriptions isEmpty.
	^ aDocument
]

{ #category : #'binding strategy' }
GtDocBindingExamples >> highlightingBindingStrategy [
	<gtExample>
	<label: 'Initialized playground bindings'>
	^ self defaultHighlightingBindingStrategy
		bindings: self playgroundBindings
]

{ #category : #'out bindings' }
GtDocBindingExamples >> outBindings [
	<gtExample>
	<label: 'Default out bindings'>
	| bindings |
	bindings := GtOutBindings new.
	self assert: bindings result isNil.
	self assert: bindings hasResult not.
	^ bindings
]

{ #category : #document }
GtDocBindingExamples >> outsFromDocumentWithOneCodeSnippet [
	<gtExample>
	<label: 'Default document'>
	| document outs |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self documentWithOneCodeSnippet.
	outs := document bindingOf: GtDocumenterConstants resultsVariableName.
	self assert: outs notNil.
	self
		assert: outs key
		equals: GtDocumenterConstants resultsVariableName.
	self assert: outs value notNil.
	self assert: outs value size equals: 1.
	self assert: (outs value at: 1) equals: 108.
	^ outs value
]

{ #category : #document }
GtDocBindingExamples >> outsFromEmptyDocument [
	<gtExample>
	<label: 'Default document'>
	| document outs |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self emptyDocument.
	outs := document bindingOf: GtDocumenterConstants resultsVariableName.
	self assert: outs notNil.
	self assert: outs key equals: GtDocumenterConstants resultsVariableName.
	self assert: outs value notNil.
	self assert: outs value size isZero.
	^ outs value
]

{ #category : #'binding strategy' }
GtDocBindingExamples >> playgroundBindingStrategy [
	<gtExample>
	<label: 'Initialized playground bindings'>
	^ self defaultPlaygroundBindingStrategy
		bindings: self playgroundBindings
]

{ #category : #bindings }
GtDocBindingExamples >> playgroundBindings [
	<gtExample>
	<label: 'Default playground bindings'>
	^ GtPlaygroundBindings new
]

{ #category : #'out bindings' }
GtDocBindingExamples >> queryCodeSnippetResult [
	<gtExample>
	<label: 'Set code snippet bindings'>
	| bindings result |
	bindings := self setCodeSnippetResult.
	result := bindings bindingOf: self variableOneName.
	self assert: result notNil.
	self assert: result key equals: self variableOneName.
	self assert: result value equals: 42.
	^ result
]

{ #category : #'out bindings' }
GtDocBindingExamples >> queryCodeSnippetResult2 [
	<gtExample>
	<label: 'Set code snippet result'>
	| bindings result |
	bindings := self setCodeSnippetResult2.
	result := bindings
		bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ bindings
]

{ #category : #'binding strategy' }
GtDocBindingExamples >> queryDefaultHighlightingBindingStrategy [
	<gtExample>
	<label: 'Query default highlighting binding strategy'>
	| strategy result |
	strategy := self defaultHighlightingBindingStrategy.
	result := strategy bindingOf: self variableOneName.
	self assert: result isNil.
	^ strategy
]

{ #category : #'binding strategy' }
GtDocBindingExamples >> queryDefaultPlaygroundBindingStrategy [
	<gtExample>
	<label: 'Query default playground binding strategy'>
	| strategy result |
	strategy := self defaultPlaygroundBindingStrategy.
	result := strategy bindingOf: self variableOneName.
	self assert: result isNil.
	^ strategy
]

{ #category : #'out bindings' }
GtDocBindingExamples >> queryEmptyCodeSnippetResult [
	<gtExample>
	<label: 'Query empty code snippet bindings'>
	| emptyBindings result |
	emptyBindings := self outBindings.
	result := emptyBindings
		bindingOf: self variableOneName.
	self assert: result isNil.
	^ emptyBindings
]

{ #category : #'out bindings' }
GtDocBindingExamples >> queryEmptyCodeSnippetResult2 [
	<gtExample>
	<label: 'Query result of empty code snippet bindings'>
	| emptyBindings result |
	emptyBindings := self outBindings.
	result := emptyBindings
		bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ emptyBindings
]

{ #category : #bindings }
GtDocBindingExamples >> queryEmptyPlaygroundBindings [
	<gtExample>
	<label: 'Query empty bindings'>
	| emptyBindings result |
	emptyBindings := self playgroundBindings.
	result := emptyBindings
		bindingOf: self variableOneName.
	self assert: result isNil.
	^ emptyBindings
]

{ #category : #'binding strategy' }
GtDocBindingExamples >> queryHighlightingBindingStrategy [
	<gtExample>
	<label: 'Query highlighting binding strategy'>
	| strategy result |
	strategy := self highlightingBindingStrategy.
	result := strategy bindingOf: self variableOneName.
	self assert: result isNil.
	^ strategy
]

{ #category : #'binding strategy' }
GtDocBindingExamples >> queryPlaygroundBindingStrategy [
	<gtExample>
	<label: 'Query playground binding strategy'>
	| strategy result |
	strategy := self playgroundBindingStrategy.
	result := strategy bindingOf: self variableOneName.
	self assert: result notNil.
	self assert: result key equals: self variableOneName.
	self assert: result value equals: nil.
	^ result
]

{ #category : #'out bindings' }
GtDocBindingExamples >> setCodeSnippetResult [
	<gtExample>
	| bindings |
	bindings := self codeSnippetWithPlaygroundBindings.
	bindings at: self variableOneName put: 42.
	self assert: bindings result value isNil.
	^ bindings
]

{ #category : #'out bindings' }
GtDocBindingExamples >> setCodeSnippetResult2 [
	<gtExample>
	| bindings |
	bindings := self codeSnippetWithPlaygroundBindings.
	bindings at: GtDocumenterConstants resultVariableName put: 42.
	self assert: bindings result notNil.
	self assert: bindings result key equals: GtDocumenterConstants resultVariableName.
	self assert: bindings result value equals: 42.
	^ bindings
]

{ #category : #'out bindings' }
GtDocBindingExamples >> setEmptyCodeSnippetResult [
	<gtExample>
	<label: 'Set result of empty code snippet bindings'>
	| bindings result |
	bindings := self outBindings.
	bindings at: self variableOneName put: 42.
	result := bindings
		bindingOf: self variableOneName.
	self assert: result isNil.
	^ bindings
]

{ #category : #'out bindings' }
GtDocBindingExamples >> setEmptyCodeSnippetResult2 [
	<gtExample>
	<label: 'Set result of empty code snippet bindings'>
	| bindings result |
	bindings := self outBindings.
	bindings value: 42.
	result := bindings
		bindingOf: GtDocumenterConstants resultVariableName.
	"The result is nil, because out refers to a previous script."
	self assert: result isNil.
	^ bindings
]

{ #category : #bindings }
GtDocBindingExamples >> setPlaygroundBindings [
	<gtExample>
	<label: 'Set variable one'>
	| bindings result |
	bindings := self playgroundBindings.
	bindings at: self variableOneName put: 42.
	result := bindings
		bindingOf: self variableOneName.
	self assert: result notNil.
	self assert: result value equals: 42.
	self assert: result key equals: self variableOneName.
	^ bindings
]

{ #category : #accessing }
GtDocBindingExamples >> variableOneName [
	<gtExample>
	<label: 'Variable one name'>
	^ #variableOne
]
