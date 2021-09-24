Class {
	#name : 'GtLeaveResource',
	#superclass : 'GtResource',
	#instVars : [
		'resource'
	],
	#category : 'GToolkit-Documenter-Resourcer'
}

{ #category : 'accessing' }
GtLeaveResource >> allResources [
	^ #()
]

{ #category : 'accessing' }
GtLeaveResource >> resource [
	^ resource
]

{ #category : 'accessing' }
GtLeaveResource >> resource: anObject [
	self 
		assert: [ anObject notNil ]
		description: [ 'Resource must be non-nil' ].
	resource := anObject
]

{ #category : 'accessing' }
GtLeaveResource >> resources [
	^ #()
]
