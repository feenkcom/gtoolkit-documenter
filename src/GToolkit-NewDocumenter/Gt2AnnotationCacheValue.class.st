Class {
	#name : #Gt2AnnotationCacheValue,
	#superclass : #Gt2CacheValue,
	#instVars : [
		'preview',
		'isExpanded'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #initialization }
Gt2AnnotationCacheValue >> initialize [
	super initialize.
	isExpanded := false.
	preview := nil.
]

{ #category : #accessing }
Gt2AnnotationCacheValue >> isExpanded [
	^ isExpanded
]

{ #category : #accessing }
Gt2AnnotationCacheValue >> isExpanded: anObject [
	isExpanded := anObject
]

{ #category : #accessing }
Gt2AnnotationCacheValue >> preview [
	^ preview
]

{ #category : #accessing }
Gt2AnnotationCacheValue >> preview: anObject [
	preview := anObject
]

{ #category : #printing }
Gt2AnnotationCacheValue >> printOn: aStream [
	self isExpanded ifNil: [ ^ super printOn: aStream ].
	self isExpanded 
		ifTrue: [ aStream nextPutAll: 'expanded preview: ' ]
		ifFalse: [ aStream nextPutAll: 'collapsed preview: ' ].
	aStream print: self preview.
]
