Class {
	#name : #GtCodeblockEvalutedAnnouncement,
	#superclass : #GtDocumentAnnouncement,
	#instVars : [
		'codeSnippet'
	],
	#category : 'GToolkit-Documenter-Announcements'
}

{ #category : #accessing }
GtCodeblockEvalutedAnnouncement >> codeSnippet [
	^ codeSnippet
]

{ #category : #accessing }
GtCodeblockEvalutedAnnouncement >> codeSnippet: anObject [
	codeSnippet := anObject
]
