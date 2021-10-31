Class {
	#name : #GtDocumentAnnouncement,
	#superclass : #Announcement,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'document'
	],
	#category : 'GToolkit-Documenter-Announcements'
}

{ #category : #accessing }
GtDocumentAnnouncement >> document [
	^ document
]

{ #category : #accessing }
GtDocumentAnnouncement >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGtDocument
]
