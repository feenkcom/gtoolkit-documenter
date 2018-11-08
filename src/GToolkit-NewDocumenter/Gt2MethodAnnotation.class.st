Class {
	#name : #Gt2MethodAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'referencedMethod'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2MethodAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #rendering }
Gt2MethodAnnotation class >> tag [
	^ self constants methodAnnotationName
]

{ #category : #'private - actions' }
Gt2MethodAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isMethodDefined ifFalse: [ ^ self inform: 'Method does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedMethod;
		sourceElement: anEvent target)
]

{ #category : #'announcement handling' }
Gt2MethodAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAdded [ 
	(self referencedMethod notNil and: [ 
		aClassAdded classAffected originalName = self referencedMethod parentName ])
			ifFalse: [ ^ self ].
	self gtDocument editor styleText
]

{ #category : #'announcement handling' }
Gt2MethodAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	(self referencedMethod notNil and: [ 
			aClassRenamed newName = self referencedMethod parentName or: [ 
				aClassRenamed oldName = self referencedMethod parentName ] ])
			ifFalse: [ ^ self ].
	self gtDocument editor styleText
]

{ #category : #'announcement handling' }
Gt2MethodAnnotation >> handleMethodAnnouncement: aMethodModified [ 
	(self referencedMethod notNil and: [ 
		aMethodModified classAffected name = self referencedMethod parentName  
			and: [ aMethodModified selector = self referencedMethod selector ]])
				ifFalse: [ ^ self ].
	self gtDocument editor styleText
]

{ #category : #testing }
Gt2MethodAnnotation >> isMethodDefined [
	"Return true if a method is defined in the system"
	^ self referencedMethod notNil and: [ self referencedMethod isDefined ]
]

{ #category : #testing }
Gt2MethodAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self isMethodDefined
]

{ #category : #testing }
Gt2MethodAnnotation >> isReferenceDefined [
	"Return true if a referenced object is defined"
	^ self isMethodDefined 
]

{ #category : #accessing }
Gt2MethodAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self referencedMethod
]

{ #category : #accessing }
Gt2MethodAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants nameParameterName
]

{ #category : #'accessing - parameter values' }
Gt2MethodAnnotation >> referencedMethod [
	<return: #RGMethodDefinition or: nil>
	^ referencedMethod ifNil: [ referencedMethod := self utility 
		valueOf: self constants nameParameterName
		in: self parameters 
		value: [ :aValue | GtSystemUtility methodDefinitionFromString: aValue ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ] ]
]

{ #category : #subscriptions }
Gt2MethodAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: MethodAdded, MethodRemoved
			send: #handleMethodAnnouncement:
			to: self
			for: self gtSubscriber;
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
Gt2MethodAnnotation >> styleInText: aBlRope [
	super styleInText: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges
]
