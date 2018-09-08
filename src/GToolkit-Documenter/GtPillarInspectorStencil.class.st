"
I create an Inspector element on a provided inspected object to be embedded within a Document

Example:

[[[
	(GtPillarInspectorStencil new inspect: Object new) asElement
]]]
"
Class {
	#name : #GtPillarInspectorStencil,
	#superclass : #BrStencil,
	#instVars : [
		'inspectedObject',
		'showMethod'
	],
	#category : 'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #'api - instantiation' }
GtPillarInspectorStencil >> create [
	| aView |
	aView := GtPhlowView empty on: self inspectedObject perform: self showMethod.
	^ aView asElementDo: [ :element |
		element constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]
]

{ #category : #initialization }
GtPillarInspectorStencil >> initialize [
	super initialize.
	inspectedObject := self.
	showMethod := GtDocumenterConstants defaultShowMethodName.
]

{ #category : #accessing }
GtPillarInspectorStencil >> inspect: anObject [
	inspectedObject := anObject
]

{ #category : #accessing }
GtPillarInspectorStencil >> inspectedObject [
	^ inspectedObject
]

{ #category : #accessing }
GtPillarInspectorStencil >> showMethod [
	<return: #Symbol>
	^ showMethod
]

{ #category : #accessing }
GtPillarInspectorStencil >> showMethod: aSymbol [
	self 
		assert: [ aSymbol notNil ] 
		description: [ 'Show method must be non-nil' ].
	showMethod := aSymbol asSymbol
]
