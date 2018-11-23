Class {
	#name : #Gt2LeaveResource,
	#superclass : #Gt2Resource,
	#instVars : [
		'resource'
	],
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #accessing }
Gt2LeaveResource >> allResources [
	^ #()
]

{ #category : #accessing }
Gt2LeaveResource >> resource [
	^ resource
]

{ #category : #accessing }
Gt2LeaveResource >> resource: anObject [
	self 
		assert: [ anObject notNil ]
		description: [ 'Resource must be non-nil' ].
	resource := anObject
]
