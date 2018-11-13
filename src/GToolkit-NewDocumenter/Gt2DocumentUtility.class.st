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

{ #category : #'text styling' }
Gt2DocumentUtility class >> linkColor: aBoolean [
	"aBoolean = true means that a link is valid.
	aBoolean = false means that a link is invalid."
	^ aBoolean 
		ifTrue: [ self constants linkColor ]
		ifFalse: [ self constants linkWithErrorColor ].
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> parameterNodeNamed: aParameterName forAnnotation: anAnnotation [
	"Return annotation's parameter AST node if exists.
	Return the given annotation otherwise"
	<return: #PRParameter or: #PRAbstractAnnotation>
	^ anAnnotation children first children
		detect: [ :eachParameter | 
			eachParameter key = aParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | aParameter ]
		ifNone: [ anAnnotation ].
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
	(aBlRope from: aNode stop to: aNode stop) attributes: theAttributes
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> styleLinkInText: aBlRope forAnnotationNode: aNode [
	| aNodeToStyle |
	aNodeToStyle := self 
		parameterNodeNamed: aNode referenceParameterName 
		forAnnotation: aNode.
	self styleLinkInText: aBlRope forNode: aNode withLinkAt: aNodeToStyle
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> styleLinkInText: aBlRope forNode: aNode [
	self styleLinkInText: aBlRope forNode: aNode withLinkAt: aNode
]

{ #category : #'text styling' }
Gt2DocumentUtility class >> styleLinkInText: aBlRope forNode: aNode withLinkAt: aLinkNode [
	| aLinkColor theAttributes |
	aLinkColor := self linkColor: aNode isReferenceDefined.
	theAttributes := Array with: (BlTextForegroundAttribute new paint: aLinkColor).
	aNode isReferenceDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverStylableAttribute new 
					attribute: (BlTextUnderlineAttribute new paint: aLinkColor).
				BrTextClickAttribute new 
					action: [ :aText :aTarget :anEditorElement :anEvent | 
						aNode browseReferenceFrom: anEvent ] } ].

	(aBlRope  
		from: aLinkNode start 
		to: (aLinkNode start max: aLinkNode stop))
			attributes: theAttributes.
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
