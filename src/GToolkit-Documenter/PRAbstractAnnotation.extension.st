Extension { #name : 'PRAbstractAnnotation' }

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> annotationCacheValueClass [
	^ GtAnnotationCacheValue
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> cacheKey [
	^ GtAnnotationCacheKey new
		name: self tag;
		parameters: self parameters;
		counter: self counter
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> cachedIsExpanded [
	<return: #Boolean>
	self gtDocument
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			^ aCachedValue isExpanded ifNil: [ self expandedParameterValue ] ]
		ifAbsentPut: [ self annotationCacheValueClass new
				isExpanded: self expandedParameterValue ].
	^ self expandedParameterValue
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> cachedIsExpanded: aBoolean [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue isExpanded: aBoolean ]
		ifAbsentPut: [ 
			self annotationCacheValueClass new isExpanded: aBoolean ]
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> cachedPreview [
	<return: #BlElement or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview ] 
		ifAbsent: [ nil ]
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> cachedPreview: anElement [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview: anElement ]
		ifAbsentPut: [ 
			self annotationCacheValueClass new 
				preview: anElement;
				isExpanded: true ]
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> expandedDefaultValue [
	^ false
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> expandedEmptyValue [
	^ true
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> expandedParameterValue [
	^ GtDocumentUtility
		booleanValueOf: GtDocumentConstants expandedParameterName 
		in: self parameters 
		emptyValue: [ self expandedEmptyValue ] 
		defaultValue: [ self expandedDefaultValue ]
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> gtDocumenterParameters [
	^ self class gtDocumenterParameters
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation class >> gtDocumenterParameters [
	^ self possibleParameters
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation class >> gtWithParameters: aPRParameters [
	| anInstance |
	anInstance := self with: aPRParameters.
	PRParserUtility gtFixAndValidateParameters: aPRParameters for: anInstance.
	^ anInstance
]

{ #category : '*GToolkit-Documenter' }
PRAbstractAnnotation >> styleTextWithMarkup: aBlRope [
	"Subclasses can add more styling"
	super styleTextWithMarkup: aBlRope.
	self utility subtleMarkupsInText: aBlRope start: self start stop: self stop.
]
