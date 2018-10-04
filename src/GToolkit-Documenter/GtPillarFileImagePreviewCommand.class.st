Class {
	#name : #GtPillarFileImagePreviewCommand,
	#superclass : #GtPillarPreviewCommand,
	#instVars : [
		'fileReference'
	],
	#category : #'GToolkit-Documenter-Pillar - Card Preview'
}

{ #category : #'api - execution' }
GtPillarFileImagePreviewCommand >> execute [
	element := (ImageReadWriter formFromFileNamed: self fileReference) asElement
]

{ #category : #accessing }
GtPillarFileImagePreviewCommand >> fileReference [
	<return: #FileReference or: nil>
	^ fileReference
]

{ #category : #accessing }
GtPillarFileImagePreviewCommand >> fileReference: aFileReference [
	self 
		assert: [ aFileReference notNil ]
		description: [ 'Pillar file reference must be non-nil' ].
	self 
		assert: [ aFileReference exists ]
		description: [ 'Pillar file reference must exists' ].
	fileReference := aFileReference 
]
