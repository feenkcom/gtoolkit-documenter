Class {
	#name : #Gt2CodeblockEvalutedAnnouncement,
	#superclass : #Gt2DocumentAnnouncement,
	#instVars : [
		'codeSnippet'
	],
	#category : #'GToolkit-NewDocumenter-Announcements'
}

{ #category : #accessing }
Gt2CodeblockEvalutedAnnouncement >> codeSnippet [
	^ codeSnippet
]

{ #category : #accessing }
Gt2CodeblockEvalutedAnnouncement >> codeSnippet: anObject [
	codeSnippet := anObject
]
