Class {
	#name : #GtDocumenterUtilityExamples,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #'pillar - parameter values' }
GtDocumenterUtilityExamples >> defaultBooleanValue [
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #anotherKey. '' })
		emptyValue: [ self error: 'Should not call empty value block' ] 
		defaultValue: [ 'default-value' ].
	self assert: aValue equals: 'default-value'.
	^ aValue
]

{ #category : #'pillar - examples method parameter' }
GtDocumenterUtilityExamples >> emptyExampleMethods [
	<gtExample>
	| theMethods anArray |
	anArray := #().
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 0.
	^ theMethods
]

{ #category : #'pillar - parameter values' }
GtDocumenterUtilityExamples >> emptyLiteralValue [
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #key. '' })
		emptyValue: [ 'empty-value' ] 
		defaultValue: [ self error: 'Shold not call default value block' ].
	self assert: aValue equals: 'empty-value'.
	^ aValue
]

{ #category : #'pillar - parameter values' }
GtDocumenterUtilityExamples >> falseLiteralValue [
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #key. false })
		emptyValue: [ self error: 'Should not call empty value block' ] 
		defaultValue: [ self error: 'Shold not call default value block' ].
	self assert: aValue not.
	^ aValue
]

{ #category : #'pillar - parameter values' }
GtDocumenterUtilityExamples >> falseStringValue [
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #key. 'FaLsE' })
		emptyValue: [ self error: 'Should not call empty value block' ] 
		defaultValue: [ self error: 'Shold not call default value block' ].
	self assert: aValue not.
	^ aValue
]

{ #category : #'pillar - examples method parameter' }
GtDocumenterUtilityExamples >> incompleteExampleMethodDefinitionOnExistingClass [
	<gtExample>
	| theMethods anArray |
	anArray := #(GtDocumenterExamples).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 0.
	^ theMethods
]

{ #category : #'pillar - examples method parameter' }
GtDocumenterUtilityExamples >> incompleteExampleMethodDefinitionOnNonExistingClass [
	<gtExample>
	| theMethods anArray |
	anArray := #(NotExistingClass).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 0.
	^ theMethods
]

{ #category : #'pillar - examples method parameter' }
GtDocumenterUtilityExamples >> nonExistingExampleMethod [
	<gtExample>
	| theMethods anArray |
	anArray := #(GtDocumenterExamples>>#nonExistingMethod).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 1.
	self assert: theMethods first methodClass equals: GtDocumenterExamples.
	self assert: theMethods first selector equals: #nonExistingMethod.
	^ theMethods
]

{ #category : #'pillar - examples method parameter' }
GtDocumenterUtilityExamples >> oneExistingExampleMethod [
	<gtExample>
	| theMethods anArray |
	anArray := #(GtDocumenterExamples>>#referencedMethod).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 1.
	self assert: theMethods first compiledMethod equals: GtDocumenterExamples>>#referencedMethod.
	^ theMethods
]

{ #category : #'pillar - parameter values' }
GtDocumenterUtilityExamples >> trueLiteralValue [
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #key. true })
		emptyValue: [ self error: 'Should not call empty value block' ] 
		defaultValue: [ self error: 'Shold not call default value block' ].
	self assert: aValue.
	^ aValue
]

{ #category : #'pillar - parameter values' }
GtDocumenterUtilityExamples >> trueStringValue [
	<gtExample>
	| aValue |
	aValue := self utility 
		booleanValueOf: #key 
		in: (Dictionary newFromPairs: { #key. 'tRuE' })
		emptyValue: [ self error: 'Should not call empty value block' ] 
		defaultValue: [ self error: 'Shold not call default value block' ].
	self assert: aValue.
	^ aValue
]

{ #category : #'pillar - examples method parameter' }
GtDocumenterUtilityExamples >> twoExistingExampleMethods [
	<gtExample>
	| theMethods anArray |
	anArray := #(GtDocumenterExamples>>#referencedMethod GtDocumenterExamples>>#referencedMethodTwo).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 2.
	self assert: theMethods first compiledMethod equals: GtDocumenterExamples>>#referencedMethod.
	self assert: theMethods second compiledMethod equals: GtDocumenterExamples>>#referencedMethodTwo.
	^ theMethods
]

{ #category : #accessing }
GtDocumenterUtilityExamples >> utility [
	<gtExample>
	^ GtDocumenterUtility
]
