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

{ #category : #'private - styling' }
Gt2ChangesAnnotation >> applyButtonAttribute [
	^ Gt2ButtonAttribute new
		beAppend;
		stencil: (Gt2ButtonStencilBuilder new
			label: self constants applyButtonLabel;
			look: BrGlamorousButtonWithIconLook + BrGlamorousButtonLabelLook;
			action: [ self applyChanges ])
]

{ #category : #operations }
Gt2ChangesAnnotation >> applyChanges [
	self halt.
]

{ #category : #'private - cache' }
Gt2ChangesAnnotation >> cachedChanges [
	^ self
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

{ #category : #'private - styling' }
Gt2ChangesAnnotation >> editButtonAttribute [
	| aLabel anIcon |
	aLabel := self changeFileExists 
		ifTrue: [ self constants editButtonLabel ]
		ifFalse: [ self constants createButtonLabel ].
	anIcon := self changeFileExists 
		ifTrue: [ self constants editButtonIcon ]
		ifFalse: [ self constants createButtonIcon ].
	^ Gt2ButtonAttribute new
		beAppend;
		stencil: (Gt2ButtonStencilBuilder new
			label: aLabel;
			icon: anIcon;
			look: BrGlamorousButtonWithIconLook + BrGlamorousButtonLabelLook;
			action: [ :aButton |
				aButton fireEvent: (GtPhlowObjectToSpawn new
					object: self cachedChanges;
					sourceElement: aButton) ])
]

{ #category : #testing }
Gt2ChangesAnnotation >> isApplied [
	^ self changeFileExists not
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

{ #category : #'private - styling' }
Gt2ChangesAnnotation >> styleApplyButtonInText: aBlRope [
	self isApplied ifTrue: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self applyButtonAttribute
]

{ #category : #'private - styling' }
Gt2ChangesAnnotation >> styleEditButtonInText: aBlRope [
	self isApplied ifFalse: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self editButtonAttribute
]

{ #category : #'api - style' }
Gt2ChangesAnnotation >> styleInText: aBlRope [
	super styleInText: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self styleApplyButtonInText: aBlRope.
	self styleEditButtonInText: aBlRope.
	"self registerToSystemChanges"
]
