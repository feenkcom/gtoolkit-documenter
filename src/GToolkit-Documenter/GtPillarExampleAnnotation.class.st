Class {
	#name : #GtPillarExampleAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'GtDocumenterConstantsTrait + GtAssertingTrait + GtAnnouncerTrait + GtPillarNodeWithDocumentTrait',
	#classTraits : 'GtDocumenterConstantsTrait classTrait + GtAssertingTrait classTrait + GtAnnouncerTrait classTrait + GtPillarNodeWithDocumentTrait classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Documenter-Pillar - Nodes'
}

{ #category : #accessing }
GtPillarExampleAnnotation class >> possibleParameters [
	^ {self constants nameParameterName.
		self constants showParameterName.
		self constants expandedViewParameterName.
		self constants expandedPreviewParemeterName.
		self constants doNotDisplaySourceCodeParameterName.
		self constants heightParameterName.
		self constants previewHeightParameterName}
]

{ #category : #protected }
GtPillarExampleAnnotation class >> tag [
	^ self constants exampleTag
]

{ #category : #visitor }
GtPillarExampleAnnotation >> accept: aVisitor [
	^ aVisitor visitGtPillarExampleAnnotation: self
]

{ #category : #'announcer - accessing' }
GtPillarExampleAnnotation >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'accessing - parameter values' }
GtPillarExampleAnnotation >> doNotDisplaySourceCodeParameterValue [
	<return: #Symbol>
	^ GtDocumenterUtility 
		booleanValueOf: self constants doNotDisplaySourceCodeParameterName
		in: self parameters
		emptyValue: [ true ]
		defaultValue: [ false ]
]

{ #category : #accessing }
GtPillarExampleAnnotation >> exampleMethod [
	<return: #CompiledMethod or: nil>
	^ self isMethodDefined
		ifTrue: [ self methodDefinition compiledMethod ] 
		ifFalse: [ nil ]
]

{ #category : #'accessing - parameter values' }
GtPillarExampleAnnotation >> expandedParameterValue [
	^ GtDocumenterUtility 
		booleanValueOf: self constants expandedViewParameterName
		in: self parameters
		emptyValue: [ true ]
		defaultValue: [ true ]
]

{ #category : #'accessing - parameter values' }
GtPillarExampleAnnotation >> expandedPreviewParameterValue [
	^ GtDocumenterUtility 
		booleanValueOf: self constants expandedPreviewParemeterName
		in: self parameters
		emptyValue: [ true ]
		defaultValue: [ 
			self doNotDisplaySourceCodeParameterValue ]
]

{ #category : #'announcement handling' }
GtPillarExampleAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAnnouncement [
	self methodClassName ifNil: [ ^ self ].
	((aClassAnnouncement classAffected name = self methodClassName) or: [ 
		aClassAnnouncement classAffected name = ('AnObsolete', self methodClassName) ]) 
			ifFalse: [ ^ self ].
	self notifyExampleUpdated
]

{ #category : #'announcement handling' }
GtPillarExampleAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	self methodClassName ifNil: [ ^ self ].
	((aClassRenamed classAffected name = self methodClassName) or: [ 
		aClassRenamed newName = self methodClassName or: [ 
			aClassRenamed oldName = self methodClassName ] ])
			ifFalse: [ ^ self ].
	self notifyExampleUpdated
]

{ #category : #'announcement handling' }
GtPillarExampleAnnotation >> handleDocumentUpdateRequestedAnnouncement: aGtDocumentUpdateRequestedAnnouncement [
	self notifyExampleUpdated
]

{ #category : #'announcement handling' }
GtPillarExampleAnnotation >> handleMethodAnnouncement: aMethodModified [
	(aMethodModified classAffected name = self methodClassName
		and: [ aMethodModified selector = self methodDefinition selector ])
		ifFalse: [ ^ self ].
	self notifyExampleUpdated
]

{ #category : #testing }
GtPillarExampleAnnotation >> hasCaption [
	^ false
]

{ #category : #testing }
GtPillarExampleAnnotation >> hasLabel [
	^ false
]

{ #category : #'accessing - parameter values' }
GtPillarExampleAnnotation >> heightParameterValue [
	^ GtDocumenterUtility 
		valueOf: self constants heightParameterName
		in: self parameters
		value: [ :aNumber | aNumber ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #initialization }
GtPillarExampleAnnotation >> initialize [
	super initialize.
	announcer := Announcer new.
]

{ #category : #testing }
GtPillarExampleAnnotation >> isMethodClassDefined [
	| aMethodDefinition |
	aMethodDefinition := self methodDefinition.
	^ aMethodDefinition notNil and: [ aMethodDefinition parent isDefined ]
]

{ #category : #testing }
GtPillarExampleAnnotation >> isMethodDefined [
	| aMethodDefinition |
	aMethodDefinition := self methodDefinition.
	^ aMethodDefinition notNil and: [ aMethodDefinition isDefined ]
]

{ #category : #testing }
GtPillarExampleAnnotation >> isPreviewHeightDefined [
	^ self previewHeightParameterValue notNil
]

{ #category : #accessing }
GtPillarExampleAnnotation >> methodClassName [
	<return: #String>
	^ self methodDefinition 
		ifNotNil: [ :aMethodDefinition | aMethodDefinition parent name ]
		ifNil: [ 'undefined' ]
]

{ #category : #'accessing - parameter values' }
GtPillarExampleAnnotation >> methodDefinition [
	<return: #RGMethodDefinition or: nil>
	"Return Ring method definition from a string method definition, e.g., MyClass>>#myMethod"
	^ GtDocumenterUtility 
		valueOf: self constants nameParameterName
		in: self parameters
		value: [ :aString | GtSystemUtility methodDefinitionFromString: aString ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #'accessing - parameter values' }
GtPillarExampleAnnotation >> methodName [
	<return: #String or: nil>
	^ GtDocumenterUtility 
		valueOf: self constants nameParameterName
		in: self parameters
		value: [ :aString | aString ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #notifying }
GtPillarExampleAnnotation >> notifyExampleUpdated [
	self announcer
		announce:
			(GtExampleClassUpdatedAnnouncement
				document: self document
				codeSnippet: self)
]

{ #category : #'accessing - parameter values' }
GtPillarExampleAnnotation >> previewHeightParameterValue [
	^ GtDocumenterUtility 
		valueOf: self constants previewHeightParameterName
		in: self parameters
		value: [ :aNumber | aNumber ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #'accessing - parameter values' }
GtPillarExampleAnnotation >> showParameterValue [
	<return: #Symbol>
	^ GtDocumenterUtility 
		valueOf: self constants showParameterName
		in: self parameters
		value: [ :selector | selector asSymbol ]
		emptyValue: [ self constants defaultShowMethodName ]
		defaultValue: [ self constants defaultShowMethodName ]
]
