Class {
	#name : #Gt2ExternalDataWriter,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'associatedNames',
		'counter',
		'memoryStore'
	],
	#category : #'GToolkit-NewDocumenter-XDoc-Utility'
}

{ #category : #initialization }
Gt2ExternalDataWriter class >> initialCounterValue [
	^ 999
]

{ #category : #enumerating }
Gt2ExternalDataWriter >> allFiles [
	<return: #Array of: #FileReference>
	^ self rootDirectory allFiles
]

{ #category : #accessing }
Gt2ExternalDataWriter >> exampleResultReferenceFor: aGt2ExampleAnnotation [ 
	<return: #String>
	| aPath |
	aPath := (self constants exportedResultsDirectoryPath / self nextNumber asString) withExtension: self constants exportedResultsExtension.
	self exportExampleResultOf: aGt2ExampleAnnotation to: aPath.
	associatedNames at: aGt2ExampleAnnotation put: aPath.
	^ aPath fullName
]

{ #category : #private }
Gt2ExternalDataWriter >> exportExampleResultOf: aGt2ExampleAnnotation to: aRelativePath [ 
	| aFileReference anExampleReturnValue aContainer aView |
	aFileReference := memoryStore referenceTo: aRelativePath.
	anExampleReturnValue := aGt2ExampleAnnotation methodDefinition compiledMethod gtExample returnValue.
	
	aContainer := Gt2ExporterContainerElement new.
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
Gt2ExternalDataWriter >> initialCounterValue [
	^ self class initialCounterValue
]

{ #category : #initialization }
Gt2ExternalDataWriter >> initialize [
	super initialize.
	associatedNames := Dictionary new.
	counter := self initialCounterValue.
	memoryStore := FileSystem memory
]

{ #category : #private }
Gt2ExternalDataWriter >> nextNumber [
	counter := counter + 1.
	^ counter
]

{ #category : #accessing }
Gt2ExternalDataWriter >> rootDirectory [
	<return: #FileReference>
	^ memoryStore root
]
