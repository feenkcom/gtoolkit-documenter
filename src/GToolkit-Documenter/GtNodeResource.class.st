Class {
	#name : #GtNodeResource,
	#superclass : #GtResource,
	#instVars : [
		'resources',
		'document'
	],
	#category : #'GToolkit-Documenter-Resourcer'
}

{ #category : #adding }
GtNodeResource >> addResource: aGt2Resource [
	self resources add: aGt2Resource.
]

{ #category : #accessing }
GtNodeResource >> allResources [
	^ OrderedCollection streamContents: [ :aStream | 
		self resources do: [ :each | 
			aStream nextPut: each.
			aStream nextPutAll: each allResources ] ]
]

{ #category : #accessing }
GtNodeResource >> document [
	<return: #GtDocumenter>
	^ document
]

{ #category : #accessing }
GtNodeResource >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGtDocument
]

{ #category : #'gt-extension' }
GtNodeResource >> gtResourcesFor: aView [
	<gtView>
	^ (self resources gtItemsFor: aView)
		title: 'Resources'
]

{ #category : #'gt-extension' }
GtNodeResource >> gtTextFor: aView [
	<gtView>
	self document ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Document';
		stencil: [ self document ]
]

{ #category : #initialization }
GtNodeResource >> initialize [
	super initialize.
	resources := OrderedCollection new.
]

{ #category : #testing }
GtNodeResource >> isDocument [
	^ true
]

{ #category : #accessing }
GtNodeResource >> resources [
	^ resources
]

{ #category : #accessing }
GtNodeResource >> withAllResources [
	^ Array with: self withAll: self allResources
]
