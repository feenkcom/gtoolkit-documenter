Class {
	#name : #Gt2XDocListAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'client'
	],
	#category : #'GToolkit-NewDocumenter-XDoc-Model'
}

{ #category : #accessing }
Gt2XDocListAnnotation class >> possibleParameters [
	^ {
		self constants expandedParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
Gt2XDocListAnnotation class >> tag [
	^ self constants xdocListAnnotationName
]

{ #category : #'private - actions' }
Gt2XDocListAnnotation >> browseReferenceFrom: anEvent [
	"Ignore, should not happen"
]

{ #category : #accessing }
Gt2XDocListAnnotation >> client [
	<return: #XdClient>
	^ client
]

{ #category : #accessing }
Gt2XDocListAnnotation >> client: anXdClient [
	self
		assert: [ anXdClient notNil ] 
		description: [ 'XDoc client must be non-nil' ].
	client := anXdClient.
]

{ #category : #'accessing - parameter values' }
Gt2XDocListAnnotation >> defaultShowSelector [
	^ self constants defaultXDocsShowSelector
]

{ #category : #testing }
Gt2XDocListAnnotation >> doesReferenceExist [
	"Return true if a referenced object is defined"
	^ false
]

{ #category : #'accessing - parameter values' }
Gt2XDocListAnnotation >> expandedDefaultValue [
	^ true
]

{ #category : #initialization }
Gt2XDocListAnnotation >> initialize [
	super initialize.
	client := XdClient new.
]

{ #category : #testing }
Gt2XDocListAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ true
]

{ #category : #accessing }
Gt2XDocListAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self client
]

{ #category : #'api - style' }
Gt2XDocListAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
]

{ #category : #'api - style' }
Gt2XDocListAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
]
