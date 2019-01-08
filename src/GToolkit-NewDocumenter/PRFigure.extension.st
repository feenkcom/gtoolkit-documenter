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
PRFigure >> cursorLeftInText: aBlRope [
	self doesReferenceExist
		ifTrue: [ self utility hideMarkupsInText: aBlRope start: self start stop: self stop ]
		ifFalse: [ 
			self hasChildren 
				ifTrue: [ self styleTextWithoutMarkupWithCaption: aBlRope ]
				ifFalse: [ self styleTextWithoutMarkupWithoutCaption: aBlRope ] ].
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> doesReferenceExist [
	^ self figureFileReference ifNil: false ifNotNil: #exists
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
	^ self doesReferenceExist
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
PRFigure >> startMarkup [
	^ self utility startMarkupFor: self class
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self utility styleLinkInText: aBlRope forNode: self.
	self utility styleExpandingPreviewInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> styleTextWithoutMarkup: aBlRope [
	super styleTextWithoutMarkup: aBlRope.
	self utility subtleMarkupsInText: aBlRope start: self start stop: self stop.
	self utility styleLinkInText: aBlRope forNode: self.
	self doesReferenceExist
		ifTrue: [ self utility mayHideMarkupsInText: aBlRope start: self start stop: self stop forNode: self ]
		ifFalse: [ 
			self hasChildren 
				ifTrue: [ self styleTextWithoutMarkupWithCaption: aBlRope ]
				ifFalse: [ self styleTextWithoutMarkupWithoutCaption: aBlRope ] ].
	self utility stylePreviewInText: aBlRope forNode: self.
	self utility styleCursorAttributeInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> styleTextWithoutMarkupWithCaption: aBlRope [
	| aStartIndex aStopIndex |
	aStartIndex := self startMarkup size + self start.
	aStopIndex := self children first stop.
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: self start
		stop: aStartIndex - 1
		forNode: self.
	self utility 
		mayHideMarkupsInText: aBlRope 
		start: aStopIndex + 1
		stop: self stop
		forNode: self.		
]

{ #category : #'*GToolkit-NewDocumenter' }
PRFigure >> styleTextWithoutMarkupWithoutCaption: aBlRope [
	| aStartIndex aStopIndex aMarkup |
	aMarkup := self startMarkup.
	aStartIndex := self start + aMarkup size.
	aStopIndex := self stop - aMarkup size.
	self utility
		mayHideMarkupsInText: aBlRope
		start: self start
		stop: aStartIndex - 1
		forNode: self.
	self utility
		mayHideMarkupsInText: aBlRope
		start: aStopIndex + 1
		stop: self stop
		forNode: self
]
