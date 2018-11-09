Class {
	#name : #Gt2ChangesAnnotation,
	#superclass : #Gt2Annotation,
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2ChangesAnnotation class >> possibleParameters [
	^ {
		self constants fileParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
Gt2ChangesAnnotation class >> tag [
	^ self constants changesAnnotationName
]

{ #category : #'accessing - parameter values' }
Gt2ChangesAnnotation >> changeFile [
	<return: #FileReference or: nil>
	^ self utility 
		valueOf: self constants fileParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifTrue: [ GtFileUtility 
				fileReferenceOfFileName: aString
				relativeTo: self sourceDirectory  ] ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #testing }
Gt2ChangesAnnotation >> changeFileExists [
	^ self changeFile ifNil: [ false ] ifNotNil: #exists
]

{ #category : #testing }
Gt2ChangesAnnotation >> isPreviewDefined [
	^ self changeFileExists
]

{ #category : #testing }
Gt2ChangesAnnotation >> isReferenceDefined [
	^ self changeFileExists
]

{ #category : #accessing }
Gt2ChangesAnnotation >> sourceDirectory [
	<return: #FileReference>
	^ self gtDocument rootDirectory
]

{ #category : #'api - style' }
Gt2ChangesAnnotation >> styleInText: aBlRope [
	super styleInText: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	"self registerToSystemChanges"
]
