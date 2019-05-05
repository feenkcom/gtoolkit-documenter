Class {
	#name : #GtCacheValue,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'clearActions'
	],
	#category : #'GToolkit-Documenter-Cache'
}

{ #category : #accessing }
GtCacheValue >> clearAction: aValuable [
	"Add a clear action that should be performed by GtStyledNodeBuilder"
	self clearActions addLast: aValuable
]

{ #category : #accessing }
GtCacheValue >> clearActions [
	^ clearActions ifNil: [ clearActions := OrderedCollection new: 2 ]
]
