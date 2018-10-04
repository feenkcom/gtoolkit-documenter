Class {
	#name : #GtPillarCardPreviewVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'fileReference',
		'previewCommand'
	],
	#category : #'GToolkit-Documenter-Pillar - Card Preview'
}

{ #category : #accessing }
GtPillarCardPreviewVisitor >> documentDirectory [
	<return: #FileReference>
	^ self fileReference 
		ifNotNil: [ :aFileReference | aFileReference parent ] 
		ifNil: [ FileLocator workingDirectory ]
]

{ #category : #accessing }
GtPillarCardPreviewVisitor >> fileReference [
	<return: #FileReference or: nil>
	^ fileReference
]

{ #category : #accessing }
GtPillarCardPreviewVisitor >> fileReference: aFileReference [
	self 
		assert: [ aFileReference notNil ]
		description: [ 'Pillar file reference must be non-nil' ].
	self 
		assert: [ aFileReference exists ]
		description: [ 'Pillar file reference must exists' ].
	fileReference := aFileReference
]

{ #category : #initialization }
GtPillarCardPreviewVisitor >> initialize [
	super initialize.
	fileReference := nil.

]

{ #category : #accessing }
GtPillarCardPreviewVisitor >> previewCommand [
	^ previewCommand
]

{ #category : #'visiting-document' }
GtPillarCardPreviewVisitor >> visitFigure: aPRFigure [
	| aFigureFileReference |
	previewCommand ifNotNil: [ ^ self ].
	aFigureFileReference := GtFileUtility
		fileReferenceOfUri: aPRFigure reference 
		relativeTo: self documentDirectory.
	aFigureFileReference exists ifFalse: [ ^ self ].
	previewCommand := GtPillarFileImagePreviewCommand new fileReference: aFigureFileReference.
]
