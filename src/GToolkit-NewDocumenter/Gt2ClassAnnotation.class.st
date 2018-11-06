Class {
	#name : #Gt2ClassAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'referencedClass'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2ClassAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		}
]

{ #category : #protected }
Gt2ClassAnnotation class >> tag [
	^ self constants classAnnotationName
]

{ #category : #'private - actions' }
Gt2ClassAnnotation >> browseReferenceFrom: anEvent [
	self isClassDefined ifFalse: [ ^ self inform: 'Class does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedClass;
		sourceElement: anEvent target)
]

{ #category : #'announcement handling' }
Gt2ClassAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAdded [ 
	
]

{ #category : #'announcement handling' }
Gt2ClassAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	
]

{ #category : #testing }
Gt2ClassAnnotation >> isClassDefined [
	^ self referencedClass notNil and: [ self referencedClass isDefined ]
]

{ #category : #testing }
Gt2ClassAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self isClassDefined
]

{ #category : #testing }
Gt2ClassAnnotation >> isReferenceDefined [
	"Return true if a referenced object is defined"
	^ self isClassDefined
]

{ #category : #accessing }
Gt2ClassAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self referencedClass
]

{ #category : #accessing }
Gt2ClassAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants nameParameterName
]

{ #category : #accessing }
Gt2ClassAnnotation >> referencedClass [
	<return: #RGClassDefinition or: nil>
	^ referencedClass ifNil: [ referencedClass := 
		GtDocumenterUtility 
			valueOf: self constants nameParameterName
			in: self parameters 
			value: [ :aValue | GtSystemUtility classDefinitionFromString: aValue ] 
			emptyValue: [ nil ] 
			defaultValue: [ nil ] ]
]

{ #category : #subscriptions }
Gt2ClassAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: ClassAdded, ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: Gt2DocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber.
]

{ #category : #'api - style' }
Gt2ClassAnnotation >> styleInText: aBlRope [
	super styleInText: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges
]
