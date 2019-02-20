Class {
	#name : #XdExternalDataWriter,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'associatedNames',
		'counter',
		'memoryStore'
	],
	#category : #'GToolkit-Documenter-XDoc-Utility'
}

{ #category : #accessing }
XdExternalDataWriter class >> constants [
	^ GtDocumentConstants
]

{ #category : #initialization }
XdExternalDataWriter class >> initialCounterValue [
	^ 999
]

{ #category : #enumerating }
XdExternalDataWriter >> allFiles [
	<return: #Array of: #FileReference>
	^ self rootDirectory allFiles
]

{ #category : #accessing }
XdExternalDataWriter >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
XdExternalDataWriter >> exampleResultReferenceFor: aGt2ExampleAnnotation [ 
	<return: #String>
	| aPath |
	aPath := (self constants exportedResultsDirectoryPath / self nextNumber asString) withExtension: self constants exportedResultsExtension.
	self exportExampleResultOf: aGt2ExampleAnnotation to: aPath.
	associatedNames at: aGt2ExampleAnnotation put: aPath.
	^ aPath fullName
]

{ #category : #private }
XdExternalDataWriter >> exportExampleResultOf: aGt2ExampleAnnotation to: aRelativePath [ 
	| aFileReference anExampleReturnValue aContainer aView |
	aFileReference := memoryStore referenceTo: aRelativePath.
	anExampleReturnValue := aGt2ExampleAnnotation methodDefinition compiledMethod gtExample returnValue.
	
	aContainer := XdExporterContainerElement new.
	"recommended size"
	aContainer size: 500@300.

	GtPhlowUseTaskItView 
		value: false during: [  
			aView := GtPhlowView empty 
				on: anExampleReturnValue 
				perform: aGt2ExampleAnnotation previewShowSelector.
			aView asElementDo: [ :anElement | aContainer addChild: anElement ].
	
			aContainer forceLayout.

			aFileReference ensureDelete.
			aFileReference parent ensureCreateDirectory.
			
			BlExporter png 
				scaled: 2;
				background: Color white;
				element: aContainer; 
				fileName: aFileReference; 
				export ].
]

{ #category : #initialization }
XdExternalDataWriter >> initialCounterValue [
	^ self class initialCounterValue
]

{ #category : #initialization }
XdExternalDataWriter >> initialize [
	super initialize.
	associatedNames := Dictionary new.
	counter := self initialCounterValue.
	memoryStore := FileSystem memory
]

{ #category : #private }
XdExternalDataWriter >> nextNumber [
	counter := counter + 1.
	^ counter
]

{ #category : #accessing }
XdExternalDataWriter >> rootDirectory [
	<return: #FileReference>
	^ memoryStore root
]
