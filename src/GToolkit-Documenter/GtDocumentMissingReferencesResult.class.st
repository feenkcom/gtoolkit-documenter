Class {
	#name : 'GtDocumentMissingReferencesResult',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'documentSource',
		'classAnnotations',
		'methodAnnotations',
		'exampleAnnotations'
	],
	#category : 'GToolkit-Documenter-Validation'
}

{ #category : 'adding' }
GtDocumentMissingReferencesResult >> addMissingClassAnnotation: aClassAnnotation [
	classAnnotations add: aClassAnnotation
]

{ #category : 'adding' }
GtDocumentMissingReferencesResult >> addMissingExampleAnnotation: anExampleAnnotation [
	exampleAnnotations add: anExampleAnnotation
]

{ #category : 'adding' }
GtDocumentMissingReferencesResult >> addMissingMethodAnnotation: aClassAnnotation [
	methodAnnotations add: aClassAnnotation
]

{ #category : 'accessing' }
GtDocumentMissingReferencesResult >> classAnnotations [
	^ classAnnotations 
]

{ #category : 'accessing' }
GtDocumentMissingReferencesResult >> documentSource [
	^ documentSource
]

{ #category : 'accessing' }
GtDocumentMissingReferencesResult >> documentSource: anObject [
	documentSource := anObject
]

{ #category : 'accessing' }
GtDocumentMissingReferencesResult >> exampleAnnotations [
	^ exampleAnnotations
]

{ #category : 'printing' }
GtDocumentMissingReferencesResult >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	documentSource ifNotNil: [ 
		aStream nextPut: $(.
		documentSource gtDisplayOn: aStream.
		aStream nextPut: $) ]
]

{ #category : 'ui' }
GtDocumentMissingReferencesResult >> gtViewMissingClassesListFor: aView [
	<gtView>
	^ aView list 
		title: 'Classes';
		items: [ classAnnotations ];
		itemFormat: [ :aClassAnnotation | aClassAnnotation referencedClass name ];
		send:  [ :aClassAnnotation | aClassAnnotation referencedClass ]
]

{ #category : 'ui' }
GtDocumentMissingReferencesResult >> gtViewMissingExamplesListFor: aView [
	<gtView>
	^ aView list 
		title: 'Examples';
		items: [ exampleAnnotations ];
		itemFormat: [ :anExampleAnnotation | anExampleAnnotation referencedExample gtDisplayString ];
		send: [ :anExampleAnnotation | anExampleAnnotation referencedExample ]
]

{ #category : 'ui' }
GtDocumentMissingReferencesResult >> gtViewMissingMethodsListFor: aView [
	<gtView>
	^ aView list 
		title: 'Methods';
		items: [ methodAnnotations ];
		itemFormat: [ :aMethodAnnotation | aMethodAnnotation referencedMethod gtDisplayString ];
		send: [ :aMethodAnnotation | aMethodAnnotation referencedMethod ]
]

{ #category : 'initialization' }
GtDocumentMissingReferencesResult >> initialize [
	super initialize.
	classAnnotations := OrderedCollection new.
	methodAnnotations := OrderedCollection new.
	exampleAnnotations := OrderedCollection new.
	
	
]

{ #category : 'testing' }
GtDocumentMissingReferencesResult >> isNotEmpty [ 
	^ classAnnotations notEmpty or: [ 
		methodAnnotations notEmpty or: [ 
			exampleAnnotations notEmpty ] ]
]

{ #category : 'accessing' }
GtDocumentMissingReferencesResult >> methodAnnotations [
	^ methodAnnotations 
]
