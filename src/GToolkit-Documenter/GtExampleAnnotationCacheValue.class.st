Class {
	#name : #GtExampleAnnotationCacheValue,
	#superclass : #GtAnnotationCacheValue,
	#instVars : [
		'example'
	],
	#category : #'GToolkit-Documenter-Cache'
}

{ #category : #accessing }
GtExampleAnnotationCacheValue >> example [
	^ example
]

{ #category : #accessing }
GtExampleAnnotationCacheValue >> example: anObject [
	example := anObject
]
