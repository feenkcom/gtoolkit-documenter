Class {
	#name : #GtDocumentNavigator,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#category : #'GToolkit-Documenter-Resourcer'
}

{ #category : #accessing }
GtDocumentNavigator class >> constants [
	^ GtDocumentConstants
]

{ #category : #deprecation }
GtDocumentNavigator class >> isDeprecated [ 
	^ true
]

{ #category : #accessing }
GtDocumentNavigator >> codeblockClasses [
	"Classes with a code block comment `[[[ ... ]]]`"
	<gtExample>
	^ self class environment allClassesAndTraits select: [ :eachClassOrTrait | 
		(eachClassOrTrait comment includesSubstring: '${') not or: [ 
			eachClassOrTrait comment includesSubstring: '[[[' ] ]
]

{ #category : #accessing }
GtDocumentNavigator >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtDocumentNavigator >> exemplifiedClasses [
	<gtExample>
	^ self class environment allClassesAndTraits select: [ :eachClassOrTrait | 
		(eachClassOrTrait comment includesSubstring: '${') ]
]

{ #category : #'gt-extension' }
GtDocumentNavigator >> gtIcebergDocumentsFor: aView [
	<gtView>
	^ aView mondrian 
		title: 'Repositories';
		priority: 1;
		painting: [ :aMondrian | 
			aMondrian nodes with: self icebergDocuments ]
]

{ #category : #accessing }
GtDocumentNavigator >> icebergDocuments [
	<gtExample>
	^ GtIcebergUtility pillarDocuments
]

{ #category : #accessing }
GtDocumentNavigator >> localDocuments [
	<gtExample>
	| aLocalDirectory |
	aLocalDirectory := self constants localGtDirectory.
	^ aLocalDirectory exists
			ifTrue: [ aLocalDirectory allChildrenMatching: GtFileUtilityConstants pillarMatchingPattern ]
			ifFalse: [ #() ]
]
