Class {
	#name : #GtDocumentAnnouncement,
	#superclass : #Announcement,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'document'
	],
	#category : #'GToolkit-Documenter-Announcements'
}

{ #category : #accessing }
GtDocumentAnnouncement >> document [
	^ document
]

{ #category : #accessing }
GtDocumentAnnouncement >> document: aGtDocument [
	self assert: [ aGtDocument isNotNil ] description: [ 'Document has to be initialized' ].
	document := aGtDocument
]
