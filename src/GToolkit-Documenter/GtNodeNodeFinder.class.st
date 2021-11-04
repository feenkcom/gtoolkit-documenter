Class {
	#name : #GtNodeNodeFinder,
	#superclass : #Object,
	#traits : 'TLepiterConstants + TBlDebug',
	#classTraits : 'TLepiterConstants classTrait + TBlDebug classTrait',
	#instVars : [
		'node'
	],
	#category : #'GToolkit-Documenter-Styler Builder'
}

{ #category : #find }
GtNodeNodeFinder >> annotationParameter: aParameterName [
	"Return annotation's parameter AST node if exists.
	Return the given annotation otherwise"
	<return: #PRParameter or: #PRAbstractAnnotation>
	^ self node children first children
		detect: [ :eachParameter | 
			eachParameter key = aParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | aParameter valueNode ]
		ifNone: [ self node ].
]

{ #category : #accessing }
GtNodeNodeFinder >> node [
	^ node
]

{ #category : #accessing }
GtNodeNodeFinder >> node: anObject [
	node := anObject
]
