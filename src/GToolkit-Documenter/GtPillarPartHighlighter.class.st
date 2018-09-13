Class {
	#name : #GtPillarPartHighlighter,
	#superclass : #Object,
	#traits : 'GtDocumenterConstantsTrait + GtAssertingTrait',
	#classTraits : 'GtDocumenterConstantsTrait classTrait + GtAssertingTrait classTrait',
	#instVars : [
		'rootHighlighter'
	],
	#category : 'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'instance creation' }
GtPillarPartHighlighter class >> highlight: anObject using: aGtPillarDocumenterHighlighter [
	<return: #GtPillarPartHighlighter>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtPillarPartHighlighter >> document [
	<return: #GtDocument>
	^ self rootHighlighter document
]

{ #category : #'private - accessing' }
GtPillarPartHighlighter >> documentDirectory [
	<return: #FileReference>
	^ self fileReference parent
]

{ #category : #accessing }
GtPillarPartHighlighter >> fileReference [
	"return a main document file reference"
	<return: #FileReference>
	^ self rootHighlighter fileReference
]

{ #category : #'api - actions' }
GtPillarPartHighlighter >> highlight [
	self subclassResponsibility
]

{ #category : #accessing }
GtPillarPartHighlighter >> pillarNode [
	<return: #PRDocumentItem>
	^ self subclassResponsibility
]

{ #category : #'pillar node - accessing' }
GtPillarPartHighlighter >> pillarNodeStart [
	<return: #Integer>
	^ self pillarNode start
]

{ #category : #'pillar node - accessing' }
GtPillarPartHighlighter >> pillarNodeStop [
	<return: #Integer>
	^ self pillarNode stop
]

{ #category : #accessing }
GtPillarPartHighlighter >> rootHighlighter [
	<return: #GtPillarDocumenterHighlighter>
	^ rootHighlighter
]

{ #category : #accessing }
GtPillarPartHighlighter >> rootHighlighter: aGtPillarDocumenterHighlighter [
	self
		assert: [ aGtPillarDocumenterHighlighter notNil ] 
		description: [ 'Highlighter has to be initialized' ].
	rootHighlighter := aGtPillarDocumenterHighlighter
]

{ #category : #'root highlighter - accessing' }
GtPillarPartHighlighter >> targetText [
	^ self rootHighlighter targetText
]
