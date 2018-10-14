Class {
	#name : #GtPillarDocumentPartHighlighter,
	#superclass : #GtPillarPartHighlighter,
	#instVars : [
		'documentPart'
	],
	#category : #'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'instance creation' }
GtPillarDocumentPartHighlighter class >> highlight: aGtPillarExecutableNode using: aGtPillarDocumenterHighlighter [
	<return: #GtPillarDocumentPartHighlighter>
	^ self new
		documentPart: aGtPillarExecutableNode;
		rootHighlighter: aGtPillarDocumenterHighlighter;
		highlight
]

{ #category : #testing }
GtPillarDocumentPartHighlighter class >> isAbstract [
	^ self name = #GtPillarDocumentPartHighlighter
]

{ #category : #accessing }
GtPillarDocumentPartHighlighter >> documentPart [
	<return: #GtPillarDocumentPart>
	^ documentPart
]

{ #category : #accessing }
GtPillarDocumentPartHighlighter >> documentPart: aGtPillarExecutableNode [
	self
		assert: [ aGtPillarExecutableNode notNil ] 
		description: [ 'Executable node has to be initialized' ].
	documentPart := aGtPillarExecutableNode
]

{ #category : #'private - styling' }
GtPillarDocumentPartHighlighter >> expandingStyleAttributes [
	<return: #Array of: #BlTextAttribute>
	^ #()
]

{ #category : #accessing }
GtPillarDocumentPartHighlighter >> pillarNode [
	<return: #PRDocumentItem>
	^ self documentPart pillarNode
]

{ #category : #'private - styling' }
GtPillarDocumentPartHighlighter >> styleAnnotationExpandingAttribute [
	(self targetText
		from: self pillarNodeStop
		to: self pillarNodeStop)
			attributes: self expandingStyleAttributes
]

{ #category : #'private - styling' }
GtPillarDocumentPartHighlighter >> styleAnnotationParameters [
	(self targetText
		from: self pillarNodeStart
		to: self pillarNodeStop)
			foreground: Color gray
]
