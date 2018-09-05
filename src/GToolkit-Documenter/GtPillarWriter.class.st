Class {
	#name : #GtPillarWriter,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'writer',
		'node'
	],
	#category : #'GToolkit-Documenter-Pillar - Writers'
}

{ #category : #accessing }
GtPillarWriter >> canvas [
	^ self writer gtCanvas
]

{ #category : #accessing }
GtPillarWriter >> node [
	^ node
]

{ #category : #accessing }
GtPillarWriter >> node: anObject [
	node := anObject
]

{ #category : #writing }
GtPillarWriter >> write [
	self subclassResponsibility
]

{ #category : #accessing }
GtPillarWriter >> writer [
	^ writer
]

{ #category : #accessing }
GtPillarWriter >> writer: anObject [
	writer := anObject
]
