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

{ #category : #'private - cache' }
Gt2ChangesAnnotation >> annotationCacheValueClass [
	^ Gt2ChangesAnnotationCacheValue
]

{ #category : #'private - styling' }
Gt2ChangesAnnotation >> applyButtonAttribute [
	^ Gt2ButtonAttribute new
		beAppend;
		equality: self constants applyButtonLabel;
		stencil: [
			BrButton new
				label: self constants applyButtonLabel;
				icon: self constants applyButtonIcon asElement;
				look: BrGlamorousButtonWithIconLook + BrGlamorousButtonLabelLook;
				action: [ self applyChanges ]]
]

{ #category : #operations }
Gt2ChangesAnnotation >> applyChanges [
	self cachedChanges applyChanges
]

{ #category : #'private - actions' }
Gt2ChangesAnnotation >> browseReferenceFrom: aBlClickEvent [ 
	aBlClickEvent modifiers isShift ifTrue: [ ^ self ].
	aBlClickEvent target 
		fireEvent: (GtPhlowObjectToSpawn new
			object: self cachedChanges;
			sourceElement: aBlClickEvent target)
]

{ #category : #'private - cache' }
Gt2ChangesAnnotation >> cachedChanges [
	<return: #Gt2Epicea or: nil>
	| aNewEpicea |
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			aNewEpicea := aCachedValue epicea.
			aNewEpicea ifNil: [ 
				aNewEpicea := self newEpicea.
				aCachedValue epicea: aNewEpicea ] ]
		ifAbsentPut: [ 
			aNewEpicea := self newEpicea.
			self annotationCacheValueClass new 
				epicea: aNewEpicea;
				isExpanded: self expandedParameterValue ].
	^ aNewEpicea
]

{ #category : #'accessing - parameter values' }
Gt2ChangesAnnotation >> changeFile [
	<return: #FileReference or: nil>
	^ self utility 
		valueOf: self constants fileParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifTrue: [ 
				| aFileNameWithExtension |
				aFileNameWithExtension := (aString endsWith: self constants changesFileExtension)
					ifTrue: [ aString ]
					ifFalse: [ aString, self constants changesFileExtension ].
				GtFileUtility 
					fileReferenceOfFileName: aFileNameWithExtension
					relativeTo: self sourceDirectory ]
			ifFalse: [ nil ] ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #testing }
Gt2ChangesAnnotation >> changeFileExists [
	^ self isChangeFileDefined and: [ 
		self changeFile exists ]
]

{ #category : #'private - styling' }
Gt2ChangesAnnotation >> createButtonAttribute [
	^ Gt2ButtonAttribute new
		beAppend;
		equality: self constants createButtonLabel;
		stencil: [ 
			BrButton new
				label: self constants createButtonLabel ;
				icon:  self constants createButtonIcon asElement ;
				look: BrGlamorousButtonWithIconLook + BrGlamorousButtonLabelLook;
				action: [ :aButton |
					aButton fireEvent: (GtPhlowObjectToSpawn new
						object: self cachedChanges;
						sourceElement: aButton) ]]
]

{ #category : #'accessing - parameter values' }
Gt2ChangesAnnotation >> expandedDefaultValue [
	^ true
]

{ #category : #'announcement handling' }
Gt2ChangesAnnotation >> handleEpiceaUpdate: aGt2EpiceaUpdatedAnnouncement [
	aGt2EpiceaUpdatedAnnouncement impactChangedOrNumberOfEventsChanged ifFalse: [ ^ self ].
	self gtDocument editor styleText
]

{ #category : #'announcement handling' }
Gt2ChangesAnnotation >> handleSystemChange: anAnnoucement [
	| aChanges |
	aChanges := self cachedChanges.
	aChanges hasChanges ifFalse: [ ^ self ].
	aChanges updateImpact
]

{ #category : #testing }
Gt2ChangesAnnotation >> hasChanges [
	^ self cachedChanges hasChanges
]

{ #category : #testing }
Gt2ChangesAnnotation >> isApplied [
	^ self cachedChanges hasImpact not
]

{ #category : #testing }
Gt2ChangesAnnotation >> isChangeFileDefined [
	self changeFile ifNil: [ ^ false ].
	self changeFile exists ifFalse: [ ^ true ].
	^ self changeFile isFile 
]

{ #category : #testing }
Gt2ChangesAnnotation >> isPreviewDefined [
	^ self hasChanges
]

{ #category : #testing }
Gt2ChangesAnnotation >> isReferenceDefined [
	^ self hasChanges
]

{ #category : #'private - cache' }
Gt2ChangesAnnotation >> newEpicea [
	^ Gt2Epicea new ombuFile: self changeFile
]

{ #category : #accessing }
Gt2ChangesAnnotation >> objectToPreview [
	^ self cachedChanges
]

{ #category : #subscriptions }
Gt2ChangesAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: ClassAnnouncement, MethodAnnouncement, Gt2DocumentUpdateRequestedAnnouncement
		send: #handleSystemChange:
		to: self
		for: self gtSubscriber.
	self cachedChanges unsubscribe: self gtSubscriber.
	self cachedChanges 
		subscribe: Gt2EpiceaUpdatedAnnouncement
		send: #handleEpiceaUpdate: 
		to: self 
		for: self gtSubscriber
]

{ #category : #accessing }
Gt2ChangesAnnotation >> sourceDirectory [
	<return: #FileReference>
	^ self gtDocument rootDirectory
]

{ #category : #'private - styling' }
Gt2ChangesAnnotation >> styleApplyButtonInText: aBlRope [
	self isApplied ifTrue: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self applyButtonAttribute
]

{ #category : #'private - styling' }
Gt2ChangesAnnotation >> styleCreateButtonInText: aBlRope [
	self hasChanges ifTrue: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self createButtonAttribute
]

{ #category : #'api - style' }
Gt2ChangesAnnotation >> styleInText: aBlRope [
	super styleInText: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self styleApplyButtonInText: aBlRope.
	self styleCreateButtonInText: aBlRope.
	self registerToSystemChanges
]
