Extension { #name : #PRFigure }

{ #category : #'*GToolkit-Documenter' }
PRFigure >> addClearAction: aValuable [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue clearAction: aValuable ]
		ifAbsentPut: [ 
			GtAnnotationCacheValue new 
				clearAction: aValuable ]
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> cacheKey [
	^ GtFigureCacheKey new
		fileName: self figureFileReference;
		counter: self counter
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> cachedIsExpanded [
	<return: #Boolean>
	self gtDocument
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			^ aCachedValue isExpanded ifNil: [ self expandedParameterValue ] ]
		ifAbsentPut: [ GtAnnotationCacheValue new
				isExpanded: self expandedParameterValue ].
	^ self expandedParameterValue
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> cachedIsExpanded: aBoolean [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue isExpanded: aBoolean ]
		ifAbsentPut: [ 
			GtAnnotationCacheValue new isExpanded: aBoolean ]
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> cachedPreview [
	<return: #BlElement or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview ] 
		ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> cachedPreview: anElement [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview: anElement ]
		ifAbsentPut: [ 
			GtAnnotationCacheValue new 
				preview: anElement ]
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> clearActions [
	<return: #Collection of: #BlockClosure>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue clearActions ]
		ifAbsent: [ #() ]
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> doesReferenceExist [
	^ self figureFileReference ifNil: false ifNotNil: #exists
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> expandedParameterValue [
	^ true
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> figureFileReference [
	"Return a figure file reference or nil if figure reference is not file"
	<return: #FileReference or: nil>
	^ self 
		propertyAt: #figureFileReference 
		ifAbsentPut: [ 
			| aFileReference |
			aFileReference := (GtFileUtility
				fileReferenceOfUri: self reference 
				relativeTo: self gtDocument rootDirectory).
			(aFileReference isNotNil and: [
			aFileReference exists ])
				ifTrue: [ aFileReference ]
				ifFalse: [ | anIcebergFile |
				
					anIcebergFile := (GtResourcesUtility resourceAtPath: self localFileOrExternalReference).
					anIcebergFile exists 
						ifTrue: [ anIcebergFile ] 
						ifFalse: [ aFileReference ] ]
		]
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> heightParameterValue [
	^ GtDocumentConstants defaultPreviewHeight
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> isPreviewDefined [
	^ self doesReferenceExist
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> objectToPreview [
	^ self figureFileReference
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> previewAttributes [
	^ {GtCachedAttribute new
		attribute:
			(GtResizablePreviewAttribute new
				result: self objectToPreview;
				showSelector: self showParameterValue;
				height: self heightParameterValue);
		cache: self cachedPreview;
		onCachingDo:
				[ :aCachedElement :theAttribute | self cachedPreview: aCachedElement ]}
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> showParameterValue [
	^ GtDocumentConstants defaultFigureShowSelector
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> startMarkup [
	^ self utility startMarkupFor: self class
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self utility subtleMarkupsInText: aBlRope start: self start stop: self stop.
	(self gtNodeStyler: aBlRope)
		if: self doesReferenceExist
			do: [ :aStyler | aStyler 
				icon: BrGlamorousIcons inspect; 
				spawnObject: [ self figureFileReference ];
				iconButton ].
	self utility styleExpandingPreviewInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> styleTextWithoutInteractions: aBlRope [
	(self gtNodeStyler: aBlRope)
		if: self doesReferenceExist
			do: [ :aStyler | aStyler hideNode ].
	self utility stylePreviewInText: aBlRope forNode: self.
]

{ #category : #'*GToolkit-Documenter' }
PRFigure >> styleTextWithoutMarkup: aBlRope [
	super styleTextWithoutMarkup: aBlRope.
	self utility subtleMarkupsInText: aBlRope start: self start stop: self stop.
	(self gtNodeStyler: aBlRope)
		if: self doesReferenceExist
			do: [ :aStyler | aStyler 
				revealAction: [ :sameStyler | sameStyler
					if: self doesReferenceExist
						do: [ sameStyler 
							icon: BrGlamorousIcons inspect; 
							spawnObject: [ self figureFileReference ];
							clearIt;
							iconButton ] ].
				aStyler autoHideNode ].
	self utility stylePreviewInText: aBlRope forNode: self.
]
