"
I publish a ${class:GtDocumenter}$ content (text) as a ${class:XdFile}$.
I am used by ${class:GtDocumenter}$.

"
Class {
	#name : #XdDocumenterPublisher,
	#superclass : #XdDocumenterSaver,
	#classInstVars : [
		'defaultXdClient'
	],
	#category : #'GToolkit-Documenter-XDoc-Publishers'
}

{ #category : #accessing }
XdDocumenterPublisher class >> defaultXdClient [
	defaultXdClient ifNil: [ defaultXdClient := XdClient  new ].
	^ defaultXdClient
]

{ #category : #accessing }
XdDocumenterPublisher class >> defaultXdClient: anXdClient [
	defaultXdClient := anXdClient 
]

{ #category : #'api - publishing' }
XdDocumenterPublisher >> delete [
	<return: #XdCommandAnswer>
	^ self class defaultXdClient 
			username: self information username asString
			password: self information password asString;
			deleteUrl: self information publicUrl asString.
]

{ #category : #'api - publishing' }
XdDocumenterPublisher >> publish [
	<return: #XdCommandAnswer>
	self hasFile ifFalse: [ self save ].
	^ self class defaultXdClient
			username: self information username asString
			password: self information password asString;
			publish: self file
]

{ #category : #'api - publishing' }
XdDocumenterPublisher >> update [
	<return: #XdCommandAnswer>
	self hasFile ifFalse: [ self save ].
	^ self class defaultXdClient 
			username: self information username asString
			password: self information password asString;
			update: self file url: self information publicUrl asString.
]
