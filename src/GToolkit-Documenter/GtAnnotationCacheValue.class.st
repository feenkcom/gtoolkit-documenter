Class {
	#name : 'GtAnnotationCacheValue',
	#superclass : 'GtCacheValue',
	#instVars : [
		'preview',
		'isExpanded'
	],
	#category : 'GToolkit-Documenter-Cache'
}

{ #category : 'initialization' }
GtAnnotationCacheValue >> initialize [
	super initialize.
	isExpanded := false.
	preview := nil.
]

{ #category : 'accessing' }
GtAnnotationCacheValue >> isExpanded [
	^ isExpanded
]

{ #category : 'accessing' }
GtAnnotationCacheValue >> isExpanded: anObject [
	isExpanded := anObject
]

{ #category : 'accessing' }
GtAnnotationCacheValue >> preview [
	^ preview
]

{ #category : 'accessing' }
GtAnnotationCacheValue >> preview: anObject [
	preview := anObject
]

{ #category : 'printing' }
GtAnnotationCacheValue >> printOn: aStream [
	self isExpanded ifNil: [ ^ super printOn: aStream ].
	self isExpanded 
		ifTrue: [ aStream nextPutAll: 'expanded preview: ' ]
		ifFalse: [ aStream nextPutAll: 'collapsed preview: ' ].
	aStream print: self preview.
]
