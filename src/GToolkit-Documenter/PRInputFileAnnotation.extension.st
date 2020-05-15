Extension { #name : #PRInputFileAnnotation }

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> alignmentParameterValue [
	^ GtDocumentUtility
			valueOf: GtDocumentConstants alignmentParameterName
			in: self parameters
			value: [ :anAlignment | (GtDocumentConstants alignmentTypes includes: anAlignment) 
				ifTrue: [ anAlignment ]
				ifFalse: [ GtDocumentConstants defaultAlignment ] ]
			emptyValue: [ GtDocumentConstants defaultAlignment ]
			defaultValue: [ GtDocumentConstants defaultAlignment ]
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self doesReferenceExist ifFalse: [ ^ self inform: 'Input file does not exist' ].
	anEvent target phlow spawnObject: self fileReference.
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation class >> constants [
	^ GtDocumentConstants
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
PRInputFileAnnotation class >> gtDocumenterParameters [
	^ {
		#path.
		self constants alignmentParameterName.
	}.
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
PRInputFileAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self utility styleLinkInText: aBlRope forAnnotationNode: self.
	(self gtNodeStyler: aBlRope) 
		if: self doesReferenceExist
			do: [ :aStyler | aStyler 
				name: self referenceParameterValue;
				spawnObject: self fileReference;
				splitURI;
				linkButton ].
	self styleExpandingPreviewInText: aBlRope.
	
]

{ #category : #'*GToolkit-Documenter' }
PRInputFileAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self gtNodeStyler: aBlRope)
		if: self doesReferenceExist 
			do: [ :aStyler | aStyler autoHideNode ]
			otherwise: [ :aStyler |
				aStyler 
					keepChildDisplayed: (self gtNodeFinder 
						annotationParameter: self constants pathParameterName);
					autoHideNode ].
]
