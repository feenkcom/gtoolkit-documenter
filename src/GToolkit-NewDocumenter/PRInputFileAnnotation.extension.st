Extension { #name : #PRInputFileAnnotation }

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isReferenceDefined ifFalse: [ ^ self inform: 'Input file does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self fileReference;
		sourceElement: anEvent target)
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> cursorLeftInText: aBlRope [
	self utility hideAllButLinkInText: aBlRope forAnnotation: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> defaultShowSelector [
	^ Gt2DocumentConstants defaultShowSelector
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> fileReference [
	<return: #FileReference or: nil>
	^ self 
		propertyAt: #fileReference 
		ifAbsentPut: [ 
			Gt2DocumentUtility 
				valueOf: Gt2DocumentConstants pathParameterName
				in: self parameters 
				value: [ :aValue | 
					| aFile |
					aValue isString 
						ifFalse: [ nil ]
						ifTrue: [ 
							aFile := aValue asFileReference.
							aFile := aFile exists 
								ifTrue: [ aFile ]
								ifFalse: [ 
									aFile := GtFileUtility 
											fileReferenceOfFileName: aValue 
											relativeTo: self gtDocument rootDirectory ].
							aFile exists ifTrue: [ aFile ] ifFalse: [ nil ] ] ]
				emptyValue: [ nil ] 
				defaultValue: [ nil ] ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> heightParameterValue [
	^ Gt2DocumentUtility
			valueOf: Gt2DocumentConstants heightParameterName
			in: self parameters
			value: [ :aNumber | aNumber isNumber 
				ifTrue: [ aNumber ]
				ifFalse: [ Gt2DocumentConstants defaultPreviewHeight ] ]
			emptyValue: [ Gt2DocumentConstants defaultPreviewHeight ]
			defaultValue: [ Gt2DocumentConstants defaultPreviewHeight ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> isPreviewDefined [
	^ self isReferenceDefined
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> isReferenceDefined [
	^ self fileReference ifNotNil: #exists ifNil: false
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> objectToPreview [
	^ self fileReference
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> previewAttributes [
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
PRInputFileAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ Gt2DocumentConstants pathParameterName
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> showEmptyValue [
	^ self defaultShowSelector
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> showParameterValue [
	<return: #Symbol>
	^ Gt2DocumentUtility
		valueOf: Gt2DocumentConstants showParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ self showEmptyValue ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ self showEmptyValue ]
		defaultValue: [ self defaultShowSelector ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> styleExpandingPreviewInText: aBlRope [
	Gt2DocumentUtility styleExpandingPreviewInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self utility styleLinkInText: aBlRope forAnnotationNode: self.
	self styleExpandingPreviewInText: aBlRope.
	
]

{ #category : #'*GToolkit-NewDocumenter' }
PRInputFileAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self utility mayHideAllButLinkInText: aBlRope forAnnotation: self) ifFalse: [ ^ self ].
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
