Extension { #name : #PRFigure }

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> browseReferenceFrom: aBlClickEvent [ 
	aBlClickEvent modifiers isShift ifTrue: [ ^ self ].
	aBlClickEvent target 
		fireEvent: (GtPhlowObjectToSpawn new
			object: self figureFileReference;
			sourceElement: aBlClickEvent target)
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> cacheKey [
	^ Gt2FigureCacheKey new
		fileName: self figureFileReference;
		counter: self counter
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> cachedIsExpanded [
	<return: #Boolean>
	self gtDocument
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			^ aCachedValue isExpanded ifNil: [ self expandedParameterValue ] ]
		ifAbsentPut: [ Gt2AnnotationCacheValue new
				isExpanded: self expandedParameterValue ].
	^ self expandedParameterValue
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> cachedIsExpanded: aBoolean [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue isExpanded: aBoolean ]
		ifAbsentPut: [ 
			Gt2AnnotationCacheValue new isExpanded: aBoolean ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> cachedPreview [
	<return: #BlElement or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview ] 
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> cachedPreview: anElement [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview: anElement ]
		ifAbsentPut: [ 
			Gt2AnnotationCacheValue new 
				preview: anElement ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> expandedParameterValue [
	^ true
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> figureFileReference [
	"Return a figure file reference or nil if figure reference is not file"
	<return: #FileReference or: nil>
	^ self 
		propertyAt: #figureFileReference 
		ifAbsentPut: [ 
			GtFileUtility
				fileReferenceOfUri: self reference 
				relativeTo: self gtDocument rootDirectory ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> heightParameterValue [
	^ Gt2DocumentConstants defaultPreviewHeight
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> isPreviewDefined [
	^ self isReferenceDefined
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> isReferenceDefined [
	^ self figureFileReference ifNil: false ifNotNil: #exists
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> objectToPreview [
	^ self figureFileReference
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> previewAttributes [
	^ {Gt2CachedAttribute new
		attribute:
			(Gt2ResizablePreviewAttribute new
				result: self objectToPreview;
				showSelector: self showParameterValue;
				height: self heightParameterValue);
		cache: self cachedPreview;
		onCachingDo:
				[ :aCachedElement :theAttribute | self cachedPreview: aCachedElement ]}
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> showParameterValue [
	^ Gt2DocumentConstants defaultFigureShowSelector
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self utility styleLinkInText: aBlRope forNode: self.
	self utility styleExpandingPreviewInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope
]
