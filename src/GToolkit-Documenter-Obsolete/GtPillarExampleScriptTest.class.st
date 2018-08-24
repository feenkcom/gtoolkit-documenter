"
A GtPillarExampleScriptTest is a test class for testing the behavior of GtPillarExampleScript.
Execute the inherited test cases.
"
Class {
	#name : #GtPillarExampleScriptTest,
	#superclass : #PRTextTest,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'as yet unclassified' }
GtPillarExampleScriptTest class >> stringExample [
	"<gtExample>
	<label: 'I am used for testing'>"
	^ 'Example text'
]

{ #category : #accessing }
GtPillarExampleScriptTest >> classToTest [
	^ GtOldPillarExampleCodeblock
]
