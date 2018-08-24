Class {
	#name : #BrTextPetitStreamExamples,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-BrTextPetitParserCompatibility'
}

{ #category : #literals }
BrTextPetitStreamExamples >> literarParser [
	<gtExample>
	| aResult |
	aResult := '!' asParser parse: '!' asRopedText.
	self assert: aResult isPetitFailure not.
	self flag: 'I am not sure if it is correct that aResult is a String.'.
	self assert: aResult isString.
	self flag: 'Maybe we should make BrText responding isString to true?'.
	self assert: ('!' = '!' asRopedText) not.
	self flag: 'Check PPLiteralSequenceParser>>#parseOn:'.
	^ aResult
]
