Class {
	#name : #GtExampleAnnotationCacheValue,
	#superclass : #GtAnnotationCacheValue,
	#instVars : [
		'example'
	],
	#category : 'GToolkit-Documenter-Cache'
}

{ #category : #accessing }
GtExampleAnnotationCacheValue >> example [
	<return: #GtExampleWithResult>
	^ example
]

{ #category : #accessing }
GtExampleAnnotationCacheValue >> example: aGtExampleWithResult [
	example := aGtExampleWithResult
]
