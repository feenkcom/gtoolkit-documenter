Class {
	#name : #GtChangesAnnotation,
	#superclass : #GtAnnotation,
	#category : #'GToolkit-Documenter-Model'
}

{ #category : #accessing }
GtChangesAnnotation class >> possibleParameters [
	^ {
		self constants pathParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
GtChangesAnnotation class >> tag [
	^ self constants changesAnnotationName
]

{ #category : #visitor }
GtChangesAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2ChangesAnnotation: self
]

{ #category : #'private - cache' }
GtChangesAnnotation >> annotationCacheValueClass [
	^ GtChangesAnnotationCacheValue
]

{ #category : #'private - styling' }
GtChangesAnnotation >> applyButtonAttribute [
	^ GtButtonAttribute new
		beAppend;
		stencil: (GtButtonStencilBuilder new
			label: self constants applyButtonLabel;
			icon: self constants applyButtonIcon;
			action: [ self applyChanges ])
]

{ #category : #operations }
GtChangesAnnotation >> applyChanges [
	self cachedChanges applyChanges
]

{ #category : #'private - actions' }
GtChangesAnnotation >> browseReferenceFrom: aBlClickEvent [ 
	aBlClickEvent modifiers isShift ifTrue: [ ^ self ].
	aBlClickEvent target 
		fireEvent: (GtPhlowObjectToSpawn new
			object: self cachedChanges;
			sourceElement: aBlClickEvent target)
]

{ #category : #'private - cache' }
GtChangesAnnotation >> cachedChanges [
	<return: #GtEpicea or: nil>
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
GtChangesAnnotation >> changeFile [
	<return: #FileReference or: nil>
	^ self utility 
		valueOf: self constants pathParameterName
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
GtChangesAnnotation >> changeFileExists [
	^ self isChangeFileDefined and: [ 
		self changeFile exists ]
]

{ #category : #'private - styling' }
GtChangesAnnotation >> createButtonAttribute [
	^ GtButtonAttribute new
		beAppend;
		stencil: (GtButtonStencilBuilder new
			label: self constants createButtonLabel;
			icon: self constants createButtonIcon;
			action: [ :aButton |
					aButton fireEvent: (GtPhlowObjectToSpawn new
						object: self cachedChanges;
						sourceElement: aButton) ])
]

{ #category : #'api - style' }
GtChangesAnnotation >> cursorLeftInText: aBlRope [
	self utility hideAllButLinkInText: aBlRope forAnnotation: self
]

{ #category : #'accessing - parameter values' }
GtChangesAnnotation >> defaultShowSelector [
	^ self constants defaultChangesShowSelector
]

{ #category : #testing }
GtChangesAnnotation >> doesReferenceExist [
	^ self hasChanges
]

{ #category : #'accessing - parameter values' }
GtChangesAnnotation >> expandedDefaultValue [
	^ true
]

{ #category : #'announcement handling' }
GtChangesAnnotation >> handleEpiceaUpdate: aGt2EpiceaUpdatedAnnouncement [
	aGt2EpiceaUpdatedAnnouncement impactChangedOrNumberOfEventsChanged ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
GtChangesAnnotation >> handleSystemChange: anAnnoucement [
	| aChanges |
	aChanges := self cachedChanges.
	aChanges hasChanges ifFalse: [ ^ self ].
	aChanges updateImpact
]

{ #category : #testing }
GtChangesAnnotation >> hasChanges [
	^ self cachedChanges hasChanges
]

{ #category : #testing }
GtChangesAnnotation >> isApplied [
	^ self cachedChanges hasImpact not
]

{ #category : #testing }
GtChangesAnnotation >> isChangeFileDefined [
	self changeFile ifNil: [ ^ false ].
	self changeFile exists ifFalse: [ ^ true ].
	^ self changeFile isFile 
]

{ #category : #testing }
GtChangesAnnotation >> isPreviewDefined [
	^ self hasChanges
]

{ #category : #'private - cache' }
GtChangesAnnotation >> newEpicea [
	^ GtEpicea new ombuFile: self changeFile
]

{ #category : #accessing }
GtChangesAnnotation >> objectToPreview [
	^ self cachedChanges
]

{ #category : #'accessing - parameter values' }
GtChangesAnnotation >> pathParameterValue [
	<return: #String or: nil>
	^ self utility 
		valueOf: self constants pathParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifTrue: [ aString ]
			ifFalse: [ nil ] ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #accessing }
GtChangesAnnotation >> referenceParameterName [
	^ self constants pathParameterName
]

{ #category : #subscriptions }
GtChangesAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: ClassAnnouncement, MethodAnnouncement, GtDocumentUpdateRequestedAnnouncement
		send: #handleSystemChange:
		to: self
		for: self gtSubscriber.
	self cachedChanges unsubscribe: self gtSubscriber.
	self cachedChanges 
		subscribe: GtEpiceaUpdatedAnnouncement
		send: #handleEpiceaUpdate: 
		to: self 
		for: self gtSubscriber
]

{ #category : #accessing }
GtChangesAnnotation >> sourceDirectory [
	<return: #FileReference>
	^ self gtDocument rootDirectory
]

{ #category : #'private - styling' }
GtChangesAnnotation >> styleApplyButtonInText: aBlRope [
	self isApplied ifTrue: [ ^ self ].
	(aBlRope from: self start to: self stop) 
		attribute: self applyButtonAttribute
]

{ #category : #'private - styling' }
GtChangesAnnotation >> styleCreateButtonInText: aBlRope [
	self hasChanges ifTrue: [ ^ self ].
	(aBlRope from: self start to: self stop) 
		attribute: self createButtonAttribute
]

{ #category : #'api - style' }
GtChangesAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	(self nodeStyler: aBlRope) 
		if: self isChangeFileDefined
			do: [ :aStyler | aStyler 
				name: self pathParameterValue;
				spawnObject: self cachedChanges;
				styleLinkButton ].
	self styleExpandingPreviewInText: aBlRope.
	self styleApplyButtonInText: aBlRope.
	self styleCreateButtonInText: aBlRope.
	self registerToSystemChanges
]

{ #category : #'api - style' }
GtChangesAnnotation >> styleTextWithoutInteractions: aBlRope [
	"Enforce Code view only"
	self parameters 
		at: self constants showParameterName
		put: #gtTutorialFor:.
	self utility hideMarkupsInText: aBlRope start: self start stop: self stop.
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges.
]

{ #category : #'api - style' }
GtChangesAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self nodeStyler: aBlRope)
		if: self isChangeFileDefined 
			do: [ :aStyler | aStyler autoHideNode ]
			otherwise: [ :aStyler |
				aStyler 
					keepChildDisplayed: (self nodeFinder 
						annotationParameter: self constants pathParameterName);
					autoHideNode ].
]
