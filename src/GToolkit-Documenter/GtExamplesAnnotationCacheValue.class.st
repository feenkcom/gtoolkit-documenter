Class {
	#name : 'GtExamplesAnnotationCacheValue',
	#superclass : 'GtAnnotationCacheValue',
	#instVars : [
		'exampleGroup'
	],
	#category : 'GToolkit-Documenter-Cache'
}

{ #category : 'accessing' }
GtExamplesAnnotationCacheValue >> exampleGroup [
	^ exampleGroup
]

{ #category : 'accessing' }
GtExamplesAnnotationCacheValue >> exampleGroup: anObject [
	exampleGroup := anObject
]
