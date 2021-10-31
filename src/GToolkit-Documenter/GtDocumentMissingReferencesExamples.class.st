Class {
	#name : #GtDocumentMissingReferencesExamples,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Validation'
}

{ #category : #accessing }
GtDocumentMissingReferencesExamples >> documentTextWithMissingMethod [
	^ '
	Present class annotation:
	${class:Object}$
	
	Missing method in existing class:
	${method:GtDocumentMissingReferencesExamples>>#missingMethodInExistingClass}$
'
	
	

]

{ #category : #accessing }
GtDocumentMissingReferencesExamples >> documentTextWithMultipleMissingReferences [
	^ '
	Missing class annotation:
	${class:MissingClassAnnotation}$
	
	Missing method in existing class:
	${method:GtDocumentMissingReferencesExamples>>#missingMethodInExistingClass}$
	
	Missing example in existing class:
	${example:GtDocumentMissingReferencesExamples>>#missingMethodInExistingClass}$
'
	
	

]

{ #category : #accessing }
GtDocumentMissingReferencesExamples >> documentTextWithNoMissingReferences [
	^ '
	Present class annotation:
	${class:Object}$
	
	Missing method in existing class:
	${method:Class>>#name}$
'
	
	

]

{ #category : #examples }
GtDocumentMissingReferencesExamples >> emptyMissingReferences [
	<gtExample>
	| documentText visitor missingReferences |
	documentText := self documentTextWithNoMissingReferences.
	visitor := GtDocumentMissingReferencesVisitor new.
	missingReferences :=  visitor 
		missingReferencesInString: documentText
		usingParser: PRPillarParser new optimize.
	
	self assert:	 missingReferences isNotEmpty not.
	self assert: missingReferences exampleAnnotations size equals: 0.
	self assert: missingReferences methodAnnotations size equals: 0.
	self assert: missingReferences classAnnotations size equals: 0.
	
	^ missingReferences
]

{ #category : #examples }
GtDocumentMissingReferencesExamples >> missingReferencesGroup [
	<gtExample>
	
]

{ #category : #examples }
GtDocumentMissingReferencesExamples >> missingReferencesResultWithMissingMethod [
	<gtExample>
	| documentText visitor missingReferences |
	documentText := self documentTextWithMissingMethod.
	visitor := GtDocumentMissingReferencesVisitor new.
	missingReferences :=  visitor 
		missingReferencesInString: documentText
		usingParser: PRPillarParser new optimize.
	
	self assert:	 missingReferences isNotEmpty.
	self assert: missingReferences exampleAnnotations size equals: 0.
	self assert: missingReferences methodAnnotations size equals: 1.
	self assert: missingReferences classAnnotations size equals: 0.
	
	^ missingReferences
]

{ #category : #examples }
GtDocumentMissingReferencesExamples >> missingReferencesResultWithMultipleReferenceTypes [
	<gtExample>
	| documentText visitor missingReferences |
	documentText := self documentTextWithMultipleMissingReferences.
	visitor := GtDocumentMissingReferencesVisitor new.
	missingReferences :=  visitor 
		missingReferencesInString: documentText
		usingParser: PRPillarParser new optimize.
	
	self assert:	 missingReferences isNotEmpty.
	self assert: missingReferences exampleAnnotations size equals: 1.
	self assert: missingReferences methodAnnotations size equals: 1.
	self assert: missingReferences classAnnotations size equals: 1.
	
	^ missingReferences
]
