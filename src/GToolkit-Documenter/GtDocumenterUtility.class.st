Class {
	#name : #GtDocumenterUtility,
	#superclass : #Object,
	#category : #'GToolkit-Documenter-Utility'
}

{ #category : #'pillar - parameter values' }
GtDocumenterUtility class >> booleanValueOf: aString in: aDictionary emptyValue: emptyBooleanOrBlock defaultValue: defaultBooleanOrBlock [
	^ self 
		valueOf: aString
		in: aDictionary
		value: [ :aValue | (self convertToBoolean: aValue) ifNil: emptyBooleanOrBlock ]
		emptyValue: emptyBooleanOrBlock
		defaultValue: defaultBooleanOrBlock
]

{ #category : #'pillar - parsing parameter values' }
GtDocumenterUtility class >> classDefinitionsFromArray: aCollection [ 
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
GtDocumenterUtility class >> convertToBoolean: aStringOrBoolean [ 
	<return: #Boolean or: nil>
	| aValue |
	aStringOrBoolean = true ifTrue: [ ^ aStringOrBoolean ].
	aStringOrBoolean = false ifTrue: [ ^ aStringOrBoolean ].
	aValue := aStringOrBoolean asString asLowercase trimBoth.
	aValue = 'true' ifTrue: [ ^ true ].
	aValue = 'false' ifTrue: [ ^ false ].
	^ nil
]

{ #category : #'pillar - parsing parameter values' }
GtDocumenterUtility class >> methodDefinitionsFromArray: aCollection [ 
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

{ #category : #brick }
GtDocumenterUtility class >> newPharoEditorElementFor: aBlText [
	| aTextEditor anEditorElement |
	aBlText attributes: {
		BlFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
		(BlFontSizeAttribute size: 14) beNotOverwritableByStyler }.
	aTextEditor := BrTextEditor new.
	aTextEditor styler: (BrRBTextStyler new workspace: GtBindingStrategy new).
	aTextEditor text: aBlText.
	anEditorElement := BrEditorElement new.
	^ anEditorElement editor: aTextEditor.
	
]

{ #category : #brick }
GtDocumenterUtility class >> newPharoEditorElementFor: aBlText styler: aStyler [
	<return: #BrEditorElement>
	| aTextEditor anEditorElement |
	aBlText attributes: {
		BlFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
		(BlFontSizeAttribute size: 14) beNotOverwritableByStyler }.
	aTextEditor := BrTextEditor new.
	aTextEditor styler: aStyler.
	aTextEditor text: aBlText.
	anEditorElement := BrEditorElement new.
	^ anEditorElement editor: aTextEditor.
	
]

{ #category : #brick }
GtDocumenterUtility class >> newResizableAndPannableElementFor: aWrappedElement [
	<return: #BlElement>
	^ self newResizableAndPannableElementFor: aWrappedElement height: 300
]

{ #category : #brick }
GtDocumenterUtility class >> newResizableAndPannableElementFor: aWrappedElement height: aHeightInteger [
	<return: #BlElement>
	| aScalableElement aResizer aContainer |

	aContainer := BlElement new.

	aScalableElement := BlPannableElement new.

	aScalableElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	aScalableElement contentElement: aWrappedElement.

	aResizer := BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new resizeTarget: aContainer; minimumExtent: 0@75).

	aContainer 
		look: GtPillarExpandedPreviewLook;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: aHeightInteger ];
		addChild: aScalableElement; 
		addChild: aResizer.
	 ^ aContainer
]

{ #category : #brick }
GtDocumenterUtility class >> newResizableElementFor: aWrappedElement [
	<return: #BlElement>
	^ self newResizableElementFor: aWrappedElement height: 300
]

{ #category : #brick }
GtDocumenterUtility class >> newResizableElementFor: aWrappedElement height: aHeightInteger [
	<return: #BlElement>
	| aResizer aContainer |

	aContainer := BlElement new.

	aResizer := BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new resizeTarget: aContainer; minimumExtent: 0@75).
	aWrappedElement constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	aContainer 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: aHeightInteger ];
		addChild: aWrappedElement;
		addChild: aResizer.
	 ^ aContainer
]

{ #category : #brick }
GtDocumenterUtility class >> newResizerBarElementOn: aResizableElement [
	<return: #BlElement>
	^ self newResizerBarElementOn: aResizableElement minimumExtent: 0@75
]

{ #category : #brick }
GtDocumenterUtility class >> newResizerBarElementOn: aResizableElement minimumExtent: aPoint [
	<return: #BlElement>
	
	^ BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new 
			resizeTarget: aResizableElement; 
			minimumExtent: aPoint)
]

{ #category : #'pillar - parsing parameter values' }
GtDocumenterUtility class >> packageDefinitionsFromArray: aCollection [ 
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

{ #category : #'pillar - parameter values' }
GtDocumenterUtility class >> valueOf: aString in: aDictionary value: valueBlock emptyValue: emptyBlock defaultValue: defaultBlock [
	^ aDictionary
		at: aString
		ifPresent: [ :aValue | 
			(aValue isNil or: [ aValue = '' ])
				ifTrue: [ emptyBlock cull: aValue ] 
				ifFalse: [ valueBlock cull: aValue ] ]
		ifAbsent: [ defaultBlock value ]
]
