Class {
	#name : #GtCodeSnippetSuccessfulExecutionAnnouncement,
	#superclass : #GtCodeSnippetExecutionAnnouncement,
	#instVars : [
		'newValue'
	],
	#category : 'GToolkit-Documenter-Announcements'
}

{ #category : #'instance creation' }
GtCodeSnippetSuccessfulExecutionAnnouncement class >> document: aGtDocument codeSnippet: aGtDebuggableCodeSnippet newValue: anObject [
	^ (self document: aGtDocument codeSnippet: aGtDebuggableCodeSnippet)
			newValue: anObject
]

{ #category : #accessing }
GtCodeSnippetSuccessfulExecutionAnnouncement >> newValue [
	^ newValue
]

{ #category : #accessing }
GtCodeSnippetSuccessfulExecutionAnnouncement >> newValue: anObject [
	newValue := anObject
]
