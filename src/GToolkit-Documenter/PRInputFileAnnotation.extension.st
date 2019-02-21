Extension { #name : #PRInputFileAnnotation }

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self doesReferenceExist ifFalse: [ ^ self inform: 'Input file does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self fileReference;
		sourceElement: anEvent target)
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> cursorLeftInText: aBlRope [
	self utility hideAllButLinkInText: aBlRope forAnnotation: self
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> defaultShowSelector [
	^ GtDocumentConstants defaultShowSelector
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> doesReferenceExist [
	^ self fileReference ifNotNil: #exists ifNil: false
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> fileReference [
	<return: #FileReference or: nil>
	^ self 
		propertyAt: #fileReference 
		ifAbsentPut: [ 
			GtDocumentUtility 
				valueOf: GtDocumentConstants pathParameterName
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

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> heightParameterValue [
	^ GtDocumentUtility
			valueOf: GtDocumentConstants heightParameterName
			in: self parameters
			value: [ :aNumber | aNumber isNumber 
				ifTrue: [ aNumber ]
				ifFalse: [ GtDocumentConstants defaultPreviewHeight ] ]
			emptyValue: [ GtDocumentConstants defaultPreviewHeight ]
			defaultValue: [ GtDocumentConstants defaultPreviewHeight ]
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> isPreviewDefined [
	^ self doesReferenceExist
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> objectToPreview [
	^ self fileReference
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> previewAttributes [
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
PRInputFileAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ GtDocumentConstants pathParameterName
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> referenceParameterValue [
	<return: #String>
	^ self utility 
		valueOf: self constants pathParameterName
		in: self parameters
		value: [ :aValue | aValue asString ]
		emptyValue: [ 'N/A' ] 
		defaultValue: [ 'N/A' ]
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> showEmptyValue [
	^ self defaultShowSelector
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> showParameterValue [
	<return: #Symbol>
	^ GtDocumentUtility
		valueOf: GtDocumentConstants showParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ self showEmptyValue ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ self showEmptyValue ]
		defaultValue: [ self defaultShowSelector ]
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> styleExpandingPreviewInText: aBlRope [
	GtDocumentUtility styleExpandingPreviewInText: aBlRope forNode: self
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> styleLinkButtonInText: aBlRope [
	(aBlRope from: self start to: self stop) 
		attribute: (GtButtonAttribute new
			beAppend;
			stencil: (GtButtonStencilBuilder new
				label: self referenceParameterValue;
				icon: BrGlamorousIcons inspect;
				action: [ :button | button phlow spawnObject: self fileReference] ))
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self utility styleLinkInText: aBlRope forAnnotationNode: self.
	self styleLinkButtonInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self utility mayHideMarkupsInText: aBlRope start: self start stop: self stop forNode: self.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
