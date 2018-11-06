Class {
	#name : #Gt2DocumentAnnouncement,
	#superclass : #Announcement,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'document'
	],
	#category : #'GToolkit-NewDocumenter-Announcements'
}

{ #category : #accessing }
Gt2DocumentAnnouncement >> document [
	^ document
]

{ #category : #accessing }
Gt2DocumentAnnouncement >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGtDocument
]
