Class {
	#name : #Gt2ExamplesAnnotationCacheValue,
	#superclass : #Gt2AnnotationCacheValue,
	#instVars : [
		'exampleGroup'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #accessing }
Gt2ExamplesAnnotationCacheValue >> exampleGroup [
	^ exampleGroup
]

{ #category : #accessing }
Gt2ExamplesAnnotationCacheValue >> exampleGroup: anObject [
	exampleGroup := anObject
]
