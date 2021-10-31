Class {
	#name : #GtSplitTextStencilExamples,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants + TBlDebug',
	#classTraits : 'TGt2DocumentConstants classTrait + TBlDebug classTrait',
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #'examples - basic' }
GtSplitTextStencilExamples >> basicStencil [
	<gtExample>
	| aStencil |
	aStencil := GtSplitTextStencil new.
	self assert: aStencil isNotNil.
	^ aStencil
]

{ #category : #'examples - text samples' }
GtSplitTextStencilExamples >> helloFeenkCollection [
	<gtExample>
	| aString aCollection |
	aString := self helloFeenkString.
	aCollection := Character space split: aString.
	self assert: aCollection size equals: 2.
	^ aCollection
]

{ #category : #'examples - text samples' }
GtSplitTextStencilExamples >> helloFeenkString [
	<gtExample>
	^ 'Hello Feenk'
]

{ #category : #'examples - elements' }
GtSplitTextStencilExamples >> splitHelloFeenkIntoElements [
	<gtExample>
	<noTest>
	| theWords aStencil theElements |
	theWords := self helloFeenkCollection.
	aStencil := self basicStencil stringParts: theWords.
	theElements := aStencil create.
	self assert: theElements size equals: theWords size.
	^ theElements
]

{ #category : #'examples - elements' }
GtSplitTextStencilExamples >> splitQuestionIntoElements [
	<gtExample>
	<noTest>
	| aSentence theWords aStencil theElements |
	aSentence := self stringQuestion.
	theWords := Character space split: aSentence.
	aStencil := self basicStencil.
	aStencil stringParts: theWords.
	theElements := aStencil create.
	self assert: theElements size equals: theWords size.
	^ theElements
]

{ #category : #'examples - text samples' }
GtSplitTextStencilExamples >> stringLoremIpsum300 [
	<gtExample>
	^ String loremIpsum: 300.
]

{ #category : #'examples - text samples' }
GtSplitTextStencilExamples >> stringQuestion [
	<gtExample>
	^ 'How do you feenk today?'
]

{ #category : #'examples - text samples' }
GtSplitTextStencilExamples >> stringWordHello [
	<gtExample>
	^ 'Hello'
]
