Class {
	#name : #Gt2ExampleAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'referencedExample',
		'example'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2ExampleAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedParameterName.
		"source code"
		self constants codeHeightParameterName.
		self constants codeExpandedParameterName.
		self constants codeShowParameterName.
		"result"
		self constants resultHeightParameterName.
		self constants resultExpandedParameterName.
		self constants resultShowParameterName.
		}
]

{ #category : #protected }
Gt2ExampleAnnotation class >> tag [
	^ self constants exampleAnnotationName
]

{ #category : #'private - actions' }
Gt2ExampleAnnotation >> browseReferenceFrom: anEvent [ 
	self isExampleDefined ifFalse: [ ^ self inform: 'Example method does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedExample;
		sourceElement: anEvent target)
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> codeExpanded [
	<return: #Boolean>
	^ self utility 
		booleanValueOf: self constants codeExpandedParameterName 
		in: self parameters 
		emptyValue: [ true ] 
		defaultValue: [ true ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> codeHeight [
	^ self utility 
		valueOf: self constants codeHeightParameterName
		in: self parameters
		value: [ :aNumber | aNumber isNumber 
			ifTrue: [ aNumber ]
			ifFalse: [ self constants defaultPreviewHeight ] ]
		emptyValue: [ self constants defaultPreviewHeight ]
		defaultValue: [ self constants defaultPreviewHeight ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> codeShow [
	<return: #Boolean>
	^ self utility 
		booleanValueOf: self constants codeShowParameterName 
		in: self parameters 
		emptyValue: [ true ] 
		defaultValue: [ true ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> example [
	^ example ifNil: [ example := self referencedExample compiledMethod gtExample ]
]

{ #category : #testing }
Gt2ExampleAnnotation >> isExampleDefined [
	"Return true if an example method is defined in the system"
	^ self referencedExample notNil and: [ self referencedExample isDefined ]
]

{ #category : #testing }
Gt2ExampleAnnotation >> isPreviewDefined [
	^ self isExampleDefined
]

{ #category : #testing }
Gt2ExampleAnnotation >> isReferenceDefined [
	^ self isExampleDefined
]

{ #category : #accessing }
Gt2ExampleAnnotation >> objectToPreview [
	^ self referencedExample compiledMethod gtExample
]

{ #category : #'private - styling' }
Gt2ExampleAnnotation >> previewAttributes [
	^ { Gt2CachedAttribute new attribute:
			(Gt2ExamplePreviewAttribute new
				beAppend;
				example: self example;
				codeExpanded: self codeExpanded;
				codeHeight: self codeHeight;
				codeShow: self codeShow;
				resultShowSelector: self resultShowSelector;
				resultHeight: self resultHeight);
		cache: self cachedPreview;
		onCachingDo: [ :aCachedElement :theAttribute | 
			self cachedPreview: aCachedElement ] }
]

{ #category : #accessing }
Gt2ExampleAnnotation >> referenceParameterName [
	^ self constants nameParameterName 
]

{ #category : #accessing }
Gt2ExampleAnnotation >> referencedExample [
	<return: #RGMethodDefinition or: nil>
	^ referencedExample ifNil: [ referencedExample := self utility 
		valueOf: self constants nameParameterName
		in: self parameters 
		value: [ :aValue | 
			aValue isString 
				ifTrue: [ GtSystemUtility methodDefinitionFromString: aValue ]
				ifFalse: [ nil ] ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ] ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> resultHeight [
	^ self utility 
		valueOf: self constants resultHeightParameterName
		in: self parameters
		value: [ :aNumber | aNumber isNumber 
			ifTrue: [ aNumber ]
			ifFalse: [ self constants defaultPreviewHeight ] ]
		emptyValue: [ self constants defaultPreviewHeight ]
		defaultValue: [ self constants defaultPreviewHeight ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> resultShowSelector [
	<return: #Symbol>
	^ self utility 
		valueOf: self constants resultShowParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ self showEmptyValue ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ self showEmptyValue ]
		defaultValue: [ self defaultShowSelector ]
]

{ #category : #'api - style' }
Gt2ExampleAnnotation >> styleInText: aBlRope [
	super styleInText: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	"self registerToSystemChanges"
]
