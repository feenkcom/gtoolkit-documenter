Class {
	#name : #GtDocumentMissingReferencesVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'missingReferences'
	],
	#category : 'GToolkit-Documenter-Validation'
}

{ #category : #actions }
GtDocumentMissingReferencesVisitor >> missingReferencesInClassCommentFor: aClass [
	| parser |
	parser := PRPillarParser new optimize.
	^ self 
		missingReferencesInClassCommentFor: aClass 
		usingParser: parser
]

{ #category : #actions }
GtDocumentMissingReferencesVisitor >> missingReferencesInClassCommentFor: aClass usingParser: aParser [
	| result |
	result := self 
		missingReferencesInString: aClass comment
		usingParser: aParser.
	result documentSource: aClass.
	^ result
]

{ #category : #actions }
GtDocumentMissingReferencesVisitor >> missingReferencesInString: aString usingParser: aParser [ 
	| pillarDoc result |
	PRValidation beSilentDuring: [ 
		pillarDoc := aParser parse: (aString ifNil: [ '' ]) ].
	pillarDoc accept: self.
	result := self result.
	^ result
]

{ #category : #accessing }
GtDocumentMissingReferencesVisitor >> result [
	^ missingReferences ifNil: [ missingReferences := GtDocumentMissingReferencesResult new ]
]

{ #category : #visiting }
GtDocumentMissingReferencesVisitor >> visitGt2ClassAnnotation: aGtClassAnnotation [  
	aGtClassAnnotation doesReferenceExist ifFalse: [ 
		self result addMissingClassAnnotation: aGtClassAnnotation ]
]

{ #category : #visiting }
GtDocumentMissingReferencesVisitor >> visitGt2ExampleAnnotation: aGtExampleAnnotation [ 
	aGtExampleAnnotation doesReferenceExist ifFalse: [ 
		self result addMissingExampleAnnotation: aGtExampleAnnotation ]
]

{ #category : #visiting }
GtDocumentMissingReferencesVisitor >> visitGt2MethodAnnotation: aGtMethodAnnotation [ 
	aGtMethodAnnotation doesReferenceExist ifFalse: [ 
		self result addMissingMethodAnnotation: aGtMethodAnnotation ]
]
