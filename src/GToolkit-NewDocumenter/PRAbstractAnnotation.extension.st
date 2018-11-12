Extension { #name : #PRAbstractAnnotation }

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> annotationCacheValueClass [
	^ Gt2AnnotationCacheValue
]

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> cacheKey [
	^ Gt2AnnotationCacheKey new
		name: self tag;
		parameters: self parameters;
		counter: self counter
]

{ #category : #'*GToolkit-NewDocumenter' }
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

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> cachedIsExpanded: aBoolean [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue isExpanded: aBoolean ]
		ifAbsentPut: [ 
			self annotationCacheValueClass new isExpanded: aBoolean ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> cachedPreview [
	<return: #BlElement or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview ] 
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> cachedPreview: anElement [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview: anElement ]
		ifAbsentPut: [ 
			self annotationCacheValueClass new 
				preview: anElement;
				isExpanded: true ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> expandedDefaultValue [
	^ false
]

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> expandedEmptyValue [
	^ true
]

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> expandedParameterValue [
	^ Gt2DocumentUtility
		booleanValueOf: Gt2DocumentConstants expandedParameterName 
		in: self parameters 
		emptyValue: [ self expandedEmptyValue ] 
		defaultValue: [ self expandedDefaultValue ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> styleInText: aBlRope [ 
	"Subclasses can add more styling"
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: Gt2DocumentConstants subtleColor
]
