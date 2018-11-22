Class {
	#name : #Gt2DocumentNavigator,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #deprecation }
Gt2DocumentNavigator class >> isDeprecated [ 
	^ true
]

{ #category : #accessing }
Gt2DocumentNavigator >> codeblockClasses [
	"Classes with a code block comment `[[[ ... ]]]`"
	<gtExample>
	^ self class environment allClassesAndTraits select: [ :eachClassOrTrait | 
		(eachClassOrTrait comment includesSubstring: '${') not or: [ 
			eachClassOrTrait comment includesSubstring: '[[[' ] ]
]

{ #category : #accessing }
Gt2DocumentNavigator >> exemplifiedClasses [
	<gtExample>
	^ self class environment allClassesAndTraits select: [ :eachClassOrTrait | 
		(eachClassOrTrait comment includesSubstring: '${') ]
]

{ #category : #'gt-extension' }
Gt2DocumentNavigator >> gtIcebergDocumentsFor: aView [
	<gtView>
	^ aView mondrian 
		title: 'Repositories';
		priority: 1;
		painting: [ :aMondrian | 
			aMondrian nodes with: self icebergDocuments ]
]

{ #category : #accessing }
Gt2DocumentNavigator >> icebergDocuments [
	<gtExample>
	^ GtIcebergUtility pillarDocuments
]

{ #category : #accessing }
Gt2DocumentNavigator >> localDocuments [
	<gtExample>
	| aLocalDirectory |
	aLocalDirectory := self constants localGtDirectory.
	^ aLocalDirectory exists
			ifTrue: [ aLocalDirectory allChildrenMatching: GtFileUtilityConstants pillarMatchingPattern ]
			ifFalse: [ #() ]
]
