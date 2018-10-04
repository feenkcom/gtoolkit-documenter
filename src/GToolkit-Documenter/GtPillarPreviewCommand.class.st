Class {
	#name : #GtPillarPreviewCommand,
	#superclass : #BlCommand,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Documenter-Pillar - Card Preview'
}

{ #category : #'api - execution' }
GtPillarPreviewCommand >> result [
	<return: #BlElement>
	^ element
]
