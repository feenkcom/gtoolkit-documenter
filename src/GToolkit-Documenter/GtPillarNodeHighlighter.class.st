Class {
	#name : #GtPillarNodeHighlighter,
	#superclass : #GtPillarPartHighlighter,
	#instVars : [
		'pillarNode'
	],
	#category : #'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'instance creation' }
GtPillarNodeHighlighter class >> highlight: aPRDocumentItem using: aGtPillarDocumenterHighlighter [
	<return: #GtPillarNodeHighlighter>
	^ self new
		pillarNode: aPRDocumentItem;
		rootHighlighter: aGtPillarDocumenterHighlighter;
		highlight
]

{ #category : #testing }
GtPillarNodeHighlighter class >> isAbstract [
	^ self name = #GtPillarNodeHighlighter 
]

{ #category : #accessing }
GtPillarNodeHighlighter >> pillarNode [
	<return: #PRDocumentItem>
	^ pillarNode
]

{ #category : #accessing }
GtPillarNodeHighlighter >> pillarNode: aPRDocumentItem [
	pillarNode := aPRDocumentItem
]

{ #category : #'private - styling' }
GtPillarNodeHighlighter >> styleCollapsedTextExpandAttribute: anAttributeCreatingBlock [
	| anExpandingAttribute |
	anExpandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: anAttributeCreatingBlock.
	self targetText 
		attributes: { anExpandingAttribute }
		from: self pillarNodeStop
		to: self pillarNodeStop
]

{ #category : #'private - styling' }
GtPillarNodeHighlighter >> styleExpandedTextExpandAttribute: anAttributeCreatingBlock [
	| anExpandingAttribute aPreviewAttribute |
	anExpandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: anAttributeCreatingBlock.
	aPreviewAttribute := anAttributeCreatingBlock value.
	anExpandingAttribute isExpanded: true.
	anExpandingAttribute createdAttributes: { aPreviewAttribute }.
	self targetText 
		attributes: { anExpandingAttribute . aPreviewAttribute }
		from: self pillarNodeStop
		to: self pillarNodeStop
]

{ #category : #'api - actions' }
GtPillarNodeHighlighter >> stylePillarNodeText [
	(self targetText from: self pillarNode start to: self pillarNode stop)
		foreground: Color gray
]
