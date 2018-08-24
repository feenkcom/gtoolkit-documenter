Class {
	#name : #GtPillarExtendedParserExamples,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtPillarExtendedParserExamples >> header [
	<gtExample>
	| aText aDocument |
	aText := '! Hello' asRopedText.
	aDocument := GtPillarExtendedParser parse: aText.
	self assert: aDocument notNil.
	self assert: aDocument isPetitFailure not.
	^ aDocument
]
