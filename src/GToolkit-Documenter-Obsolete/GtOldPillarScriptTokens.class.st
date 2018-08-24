Class {
	#name : #GtOldPillarScriptTokens,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'tokens',
		'parameters',
		'sourceFileReference'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> booleanValueOf: aString emptyValue: emptyBooleanOrBlock defaultValue: defaultBooleanOrBlock [
	^ self 
		valueOf: aString
		value: [ :aValue | 
			(aValue asString asLowercase trimBoth = 'true') or: [ 
				aValue asString trimBoth = '' ] ]
		emptyValue: emptyBooleanOrBlock
		defaultValue: defaultBooleanOrBlock
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> closingBracketsEndPosition [
	^ tokens last stop
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> closingBracketsStartingPosition [
	^ tokens last start
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> codeParameterName [
	^ 'code'
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> epiceaParameterName [
	^ 'epicea'
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> epiceaParameterStringValue [
	<return: #String>
	^ self 
		valueOf: self epiceaParameterName
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> epiceaParameterValue [
	<return: #FileReference>
	^ self 
		valueOf: self epiceaParameterName
		value: [ :aString | 
			GtFileUtility fileReferenceOfFileName: aString relativeTo: self sourceDirectory ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> exampleParameterName [
	^ 'example'
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> exampleParameterValue [
	<return: #String>
	^ self 
		valueOf: self exampleParameterName
		value: [ :aString | aString ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> expandedParameterName [
	^ 'expanded'
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> expandedPreviewParameterName [
	^ 'expandedPreview'
]

{ #category : #'gt-inspector-extension' }
GtOldPillarScriptTokens >> gtInspectorParametersIn: composite [
	<gtInspectorPresentationOrder: -2>
	^ parameters ifNotNil: [ :aDictionary |
		(aDictionary gtInspectorItemsIn: composite)
			title: [ 'Parameters' translated ] ]
]

{ #category : #'gt-inspector-extension' }
GtOldPillarScriptTokens >> gtInspectorSourceCodeIn: composite [
	<gtInspectorPresentationOrder: -4>
	^ composite text
		title: [ 'Source code' ];
		display: [ self scriptBodyString ];
		when: [ self scriptBodyString notNil ]
]

{ #category : #testing }
GtOldPillarScriptTokens >> hasExampleParameter [
	^ self includesParameter: self exampleParameterName
]

{ #category : #testing }
GtOldPillarScriptTokens >> hasParameters [
	^ parameters isNotEmpty
]

{ #category : #testing }
GtOldPillarScriptTokens >> hasShowParameter [
	^ (self scriptParameters includesKey: self showParameterName) or: [ 
			self shouldExpandPreview ]
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> heightParameterName [
	^ 'height'
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> heightParameterValue [
	<return: #String>
	^ self 
		valueOf: self heightParameterName
		value: [ :aString | (Number readFromString: aString) ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #testing }
GtOldPillarScriptTokens >> includesParameter: aString [ 
	^ parameters includesKey: aString
]

{ #category : #testing }
GtOldPillarScriptTokens >> isPreviewHeightDefined [
	^ self heightParameterValue notNil 
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> labelParameterName [
	"Script label parameter name used for example for button labels, [[[label=Run]]]"
	^ 'label'
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> labelParameterValue [
	<return: #String>
	^ self 
		valueOf: self labelParameterName
		emptyValue: [ GtDocumenterConstants defaultExecuteButtonLabel ]
		defaultValue: [ GtDocumenterConstants defaultExecuteButtonLabel ]
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> noCodeParameterName [
	^ 'noCode'
]

{ #category : #accessing }
GtOldPillarScriptTokens >> parameters [
	<return: #Array>
	self 
		assert: [ parameters notNil ] 
		description: [ 'You should not ask for parameters before the object initialization' ].
	^ parameters
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> parametersEndPosition [
	^ self closingBracketsStartingPosition - 1
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> parametersStartingPosition [
	^ self startingBracketsEndPosition + 1
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> scriptBodyEndPosition [
	^ self scriptBodyToken stop
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> scriptBodyStartingPosition [
	^ self scriptBodyToken start
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> scriptBodyString [
	^ String withAll: self scriptBodyToken parsedValue
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> scriptBodyToken [
	^ tokens third
]

{ #category : #accessing }
GtOldPillarScriptTokens >> scriptParameters [
	^ parameters
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> shouldBeExpanded [
	<return: #Boolean>
	^ self 
		booleanValueOf: self expandedParameterName
		emptyValue: true
		defaultValue: true
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> shouldDisplayCode [
	<return: #Boolean>
	^ self booleanValueOf: self codeParameterName emptyValue: true defaultValue: [ 
		(self booleanValueOf: self noCodeParameterName emptyValue: true defaultValue: false) not ]
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> shouldExpandPreview [
	<return: #Boolean>
	^ self 
		booleanValueOf: self expandedPreviewParameterName
		emptyValue: true
		defaultValue: false
]

{ #category : #'accessing - parameter names' }
GtOldPillarScriptTokens >> showParameterName [
	^ 'show'
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> showParameterValue [
	<return: #Symbol or: nil>
	^ self 
		valueOf: self showParameterName
		value: [ :selector | selector asSymbol ]
		emptyValue: [ GtDocumenterConstants defaultShowMethodName ]
		defaultValue: [ GtDocumenterConstants defaultShowMethodName ]
]

{ #category : #accessing }
GtOldPillarScriptTokens >> sourceDirectory [
	"Return parent directory of a source file"
	<return: #FileReference>
	self 
		assert: [ self sourceFileReference notNil ]
		description: [ 'Pillar source file has to be initialized first' ].
	^ self sourceFileReference parent
]

{ #category : #accessing }
GtOldPillarScriptTokens >> sourceFileReference [
	^ sourceFileReference
]

{ #category : #accessing }
GtOldPillarScriptTokens >> sourceFileReference: aFileReference [
	self assert: [ aFileReference notNil ] description: [ 'Source file has to be initialized' ].
	self assert: [ aFileReference exists ] description: [ 'Source file has to exist' ].
	sourceFileReference := aFileReference
]

{ #category : #'accessing - tokens' }
GtOldPillarScriptTokens >> startingBracketsEndPosition [
	^ tokens first stop
]

{ #category : #accessing }
GtOldPillarScriptTokens >> tokens: aCollection [ 
	tokens := aCollection.
	parameters := aCollection second asDictionary keysAndValuesRemove: [ :key :value | key isEmpty and: [ value isNil ] ].
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> valueOf: aString emptyValue: emptyBlock defaultValue: defaultBlock [
	^ self 
		valueOf: aString 
		value: [ :aValueString | aValueString ] 
		emptyValue: emptyBlock 
		defaultValue: defaultBlock
]

{ #category : #'accessing - parameter values' }
GtOldPillarScriptTokens >> valueOf: aString value: valueBlock emptyValue: emptyBlock defaultValue: defaultBlock [
	^ self scriptParameters 
		at: aString
		ifPresent: [ :aValue | 
			aValue isEmptyOrNil 
				ifTrue: [ emptyBlock value ]
				ifFalse: [ valueBlock cull: aValue ] ]
		ifAbsent: [ defaultBlock value ]
]
