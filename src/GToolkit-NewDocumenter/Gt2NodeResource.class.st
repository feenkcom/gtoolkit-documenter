Class {
	#name : #Gt2NodeResource,
	#superclass : #Gt2Resource,
	#instVars : [
		'resources',
		'document'
	],
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #adding }
Gt2NodeResource >> addResource: aGt2Resource [
	self resources add: aGt2Resource.
]

{ #category : #accessing }
Gt2NodeResource >> allResources [
	^ OrderedCollection streamContents: [ :aStream | 
		self resources do: [ :each | 
			aStream nextPut: each.
			aStream nextPutAll: each allResources ] ]
]

{ #category : #accessing }
Gt2NodeResource >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2NodeResource >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGtDocument
]

{ #category : #'gt-extension' }
Gt2NodeResource >> gtResourcesFor: aView [
	<gtView>
	^ (self resources gtItemsFor: aView)
		title: 'Resources'
]

{ #category : #'gt-extension' }
Gt2NodeResource >> gtTextFor: aView [
	<gtView>
	self document ifNil: [ ^ aView empty ].
	^ self document gtTextFor: aView
]

{ #category : #initialization }
Gt2NodeResource >> initialize [
	super initialize.
	resources := OrderedCollection new.
]

{ #category : #accessing }
Gt2NodeResource >> resources [
	^ resources
]
