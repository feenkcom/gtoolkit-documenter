Class {
	#name : #Gt2DocumentUtility,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#category : #'GToolkit-NewDocumenter-Utility'
}

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> booleanValueOf: aString in: aDictionary emptyValue: emptyBooleanOrBlock defaultValue: defaultBooleanOrBlock [
	^ self 
		valueOf: aString
		in: aDictionary
		value: [ :aValue | (self convertToBoolean: aValue) ifNil: emptyBooleanOrBlock ]
		emptyValue: emptyBooleanOrBlock
		defaultValue: defaultBooleanOrBlock
]

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> classDefinitionsFromArray: aCollection [ 
	<return: #Array of: #RGClassDefinition>
	self 
		assert: [ aCollection notNil ]
		description: [ 'Class definitions has to be a collection' ].
	^ Array streamContents: [ :aStream |
			aCollection do: [ :eachClassName | 
				| aClassDef |
				aClassDef := GtSystemUtility classDefinitionFromString: eachClassName asString.
				aStream nextPut: aClassDef.
		] ].
]

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> convertToBoolean: aStringOrBoolean [ 
	<return: #Boolean or: nil>
	| aValue |
	aStringOrBoolean = true ifTrue: [ ^ aStringOrBoolean ].
	aStringOrBoolean = false ifTrue: [ ^ aStringOrBoolean ].
	aValue := aStringOrBoolean asString asLowercase trimBoth.
	aValue = 'true' ifTrue: [ ^ true ].
	aValue = 'false' ifTrue: [ ^ false ].
	^ nil
]

{ #category : #'text styling - nearby cursor' }
Gt2DocumentUtility class >> cursorNeabyInText: aBlRope forNode: aNode [
	(aBlRope from: aNode start to: aNode stop)
		clearAttributes: [ :eachAttribute | eachAttribute = Gt2HideAttribute uniqueInstance ]
]

{ #category : #'text styling - nearby cursor' }
Gt2DocumentUtility class >> cursorNearbyStartDistanceInText: aBlRope forNode: aNode [
	^ (aNode start - self constants cursorNearbyDistance) max: 1
]

{ #category : #'text styling - nearby cursor' }
Gt2DocumentUtility class >> cursorNearbyStopDistanceInText: aBlRope forNode: aNode [
	^ (aNode stop + self constants cursorNearbyDistance) min: aBlRope size
]

{ #category : #'text markups' }
Gt2DocumentUtility class >> endMarkupFor: aNode [
	^ PRPillarGrammar endMarkups at: aNode class
]

{ #category : #'text styling - hide attribute' }
Gt2DocumentUtility class >> hideAllButLinkInText: aBlRope forAnnotation: aNode [
	"Return true if hiding action happens"
	<return: #Boolean>
	| aLinkNode |
	aLinkNode := self linkNodeForAnnotation: aNode.
	aLinkNode == aNode ifTrue: [ ^ false ].
	self hideMarkupsInText: aBlRope forAnnotation: aNode exceptOfChild: aLinkNode.
	^ true
]

{ #category : #'text styling - hide attribute' }
Gt2DocumentUtility class >> hideMarkupsInText: aBlRope forAnnotation: aNode exceptOfChild: aChildNode [
	(aBlRope from: aNode start to: aChildNode start - 1)
		attribute: Gt2HideAttribute uniqueInstance.
	(aBlRope from: aChildNode stop + 1 to: aNode stop)
		attribute: Gt2HideAttribute uniqueInstance.
]

{ #category : #'text styling - hide attribute' }
Gt2DocumentUtility class >> hideMarkupsInText: aBlRope start: aStartIndex stop: aStopIndex [
	(aBlRope 
		from: aStartIndex
		to: aStopIndex)
			attribute: Gt2HideAttribute uniqueInstance.
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> horizontalLineAttribute [
	^ BrTextAdornmentDynamicAttribute new
		beReplace;
		stencil: [ BlElement new
			background: BlBackground transparent;
			constraintsDo: [ :c |
				c margin: (BlInsets top: 10 bottom: 10).
				c vertical exact: self constants horizontalLineHeight.
				c horizontal matchParent ] ]
]

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> icebergFileReferenceFrom: aString [
	<return: #FileReference>
	| aFile |
	aFile := aString asFileReference.
	aFile := aFile exists ifTrue: [ ^ aFile ].
	aFile := GtFileUtility
		fileReferenceOfFileName: aString
		relativeTo: self constants icebergRepositoriesLocation.
	aFile := aFile exists ifTrue: [ ^ aFile ].
	aFile := GtFileUtility
		fileReferenceOfFileName: aString
		relativeTo: self constants localGtDirectory.
	^ aFile
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> linkColor: aBoolean [
	"aBoolean = true means that a link is valid.
	aBoolean = false means that a link is invalid."
	^ aBoolean 
		ifTrue: [ self constants linkColor ]
		ifFalse: [ self constants linkWithErrorColor ].
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> linkNodeForAnnotation: aNode [
	^ self
		parameterValueNodeNamed: aNode referenceParameterName
		forAnnotation: aNode
]

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> methodDefinitionsFromArray: aCollection [ 
	<return: #Array of: #RGMethodDefinition>
	| aStep anIndex |
	self 
		assert: [ aCollection notNil ]
		description: [ 'Method definitions has to be a collection' ].
	aStep := 3.
	anIndex := 1.
	^ Array streamContents: [ :aStream |
		[ anIndex + aStep - 1 <= aCollection size ] whileTrue: [ 
			| aClass aSplitter aSelector aMethodDef |
			aClass := aCollection at: anIndex.
			aSplitter := aCollection at: anIndex + 1.
			aSelector := aCollection at: anIndex + 2.
			aMethodDef := GtSystemUtility methodDefinitionFromString: aClass asString, aSplitter asString, '#', aSelector asString.
			aStream nextPut: aMethodDef.
			anIndex := anIndex + aStep.
		] ].
]

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> packageDefinitionsFromArray: aCollection [ 
	<return: #Array of: #RGPackage>
	self 
		assert: [ aCollection notNil ]
		description: [ 'Package definitions has to be a collection' ].
	^ Array streamContents: [ :aStream |
			aCollection do: [ :eachPackageName | 
				| aClassDef |
				aClassDef := GtSystemUtility packageDefinitionFromString: eachPackageName asString.
				aStream nextPut: aClassDef.
		] ].
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> parameterValueNodeNamed: aParameterName forAnnotation: anAnnotation [
	"Return annotation's parameter AST node if exists.
	Return the given annotation otherwise"
	<return: #PRParameter or: #PRAbstractAnnotation>
	^ anAnnotation children first children
		detect: [ :eachParameter | 
			eachParameter key = aParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | aParameter valueNode ]
		ifNone: [ anAnnotation ].
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> shouldOpenReference: anEvent [
	^ anEvent modifiers isShift not
]

{ #category : #'text markups' }
Gt2DocumentUtility class >> startMarkupFor: aNode [
	^ PRPillarGrammar markups at: (aNode isClass ifTrue: [ aNode ] ifFalse: [ aNode class ])
]

{ #category : #'text styling - nearby cursor' }
Gt2DocumentUtility class >> styleCursorAttributeInText: aBlRope forNode: aNode [
	self 
		styleCursorAttributeInText: aBlRope 
		from: (self cursorNearbyStartDistanceInText: aBlRope forNode: aNode) 
		to: (self cursorNearbyStopDistanceInText: aBlRope forNode: aNode)  
		forNode: aNode
]

{ #category : #'text styling - nearby cursor' }
Gt2DocumentUtility class >> styleCursorAttributeInText: aBlRope from: aStartIndex to: aStopIndex forNode: aNode [
	(aBlRope from: aStartIndex to: aStopIndex) attribute: (BrTextCursorAttribute new
		enterAction: [ :aTextEditor |
			aNode cursorNearbyInText: aTextEditor text.
			aTextEditor invalidate: aStartIndex to: aStopIndex; update: aStartIndex to: aStopIndex ];
		leaveAction: [ :aTextEditor |
			aNode cursorLeftInText: aTextEditor text.
			aTextEditor invalidate: aStartIndex to: aStopIndex; update: aStartIndex to: aStopIndex ])
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> styleExpandingPreviewInText: aBlRope forNode: aNode [
	| theAttributes |
	aNode isPreviewDefined ifFalse: [ ^ self ].
	theAttributes := Gt2CachedTextExpandButtonAttributeStencil new
		attributesCreatingBlock: [ aNode previewAttributes ];
		isExpanded: aNode cachedIsExpanded;
		onCachingDo: [ :aBoolean :theAttribute | aNode cachedIsExpanded: aBoolean ];
		create.
	(aBlRope from: aNode start to: aNode stop) attributes: theAttributes
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> styleLinkInText: aBlRope forAnnotationNode: aNode [
	| aNodeToStyle |
	aNodeToStyle := self linkNodeForAnnotation: aNode.
	self styleLinkInText: aBlRope forNode: aNode withLinkAt: aNodeToStyle
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> styleLinkInText: aBlRope forNode: aNode [
	self styleLinkInText: aBlRope forNode: aNode withLinkAt: aNode
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> styleLinkInText: aBlRope forNode: aNode start: aStartIndex stop: aStopIndex [
	| aLinkColor theAttributes |
	aLinkColor := self linkColor: aNode isReferenceDefined.
	theAttributes := Array with: (BlTextForegroundAttribute new paint: aLinkColor).
	aNode isReferenceDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverStylableAttribute new 
					attribute: (BlTextUnderlineAttribute new paint: aLinkColor).
				BrTextClickAttribute new 
					action: [ :aText :aTarget :aTextEditor :anEvent | 
						aNode browseReferenceFrom: anEvent ] } ].

	(aBlRope  
		from: aStartIndex 
		to: (aStartIndex max: aStopIndex))
			attributes: theAttributes.
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> styleLinkInText: aBlRope forNode: aNode withLinkAt: aLinkNode [
	self styleLinkInText: aBlRope forNode: aNode start: aLinkNode start stop: aLinkNode stop
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> stylePreviewInText: aBlRope forNode: aNode [
	aNode isPreviewDefined ifFalse: [ ^ self ].
	(aBlRope from: aNode stop to: aNode stop) attributes: aNode previewAttributesForReadingMode
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> sublteMarkupsInText: aBlRope start: aStartIndex stop: aStopIndex [
	(aBlRope 
		from: aStartIndex
		to: aStopIndex)
			foreground: self constants subtleColor
]

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> valueOf: aString in: aDictionary value: aValueBlock emptyValue: anEmptyBlock defaultValue: aDefaultBlock [
	^ aDictionary
		at: aString
		ifPresent: [ :aValue | 
			(aValue isNil or: [ aValue = '' ])
				ifTrue: [ anEmptyBlock cull: aValue ] 
				ifFalse: [ aValueBlock cull: aValue ] ]
		ifAbsent: [ aDefaultBlock value ]
]
