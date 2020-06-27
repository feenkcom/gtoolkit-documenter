"
I publish a ${class:GtDocumenter}$ content (text) as a ${class:XdFile}$.
I am used by ${class:GtDocumenter}$.

"
Class {
	#name : #XdDocumenterPublisher,
	#superclass : #XdDocumenterSaver,
	#category : #'GToolkit-Documenter-XDoc-Publishers'
}

{ #category : #'api - publishing' }
XdDocumenterPublisher >> delete [
	<return: #XdCommandAnswer>
	^ XdClient new 
			username: self information username asString
			password: self information password asString;
			deleteUrl: self information publicUrl asString.
]

{ #category : #'api - publishing' }
XdDocumenterPublisher >> publish [
	<return: #XdCommandAnswer>
	self hasFile ifFalse: [ self save ].
	^ XdClient new 
			username: self information username asString
			password: self information password asString;
			publish: self file
]

{ #category : #'api - publishing' }
XdDocumenterPublisher >> update [
	<return: #XdCommandAnswer>
	self hasFile ifFalse: [ self save ].
	^ XdClient new 
			username: self information username asString
			password: self information password asString;
			update: self file url: self information publicUrl asString.
]
