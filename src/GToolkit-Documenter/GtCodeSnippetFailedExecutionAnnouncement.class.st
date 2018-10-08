Class {
	#name : #GtCodeSnippetFailedExecutionAnnouncement,
	#superclass : #GtCodeSnippetExecutionAnnouncement,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Documenter-Announcements'
}

{ #category : #'instance creation' }
GtCodeSnippetFailedExecutionAnnouncement class >> document: aGtDocument codeSnippet: aGtDebuggableCodeSnippet exception: anException [
	^ (self document: aGtDocument codeSnippet: aGtDebuggableCodeSnippet)
			exception: anException
]

{ #category : #accessing }
GtCodeSnippetFailedExecutionAnnouncement >> exception [
	^ exception
]

{ #category : #accessing }
GtCodeSnippetFailedExecutionAnnouncement >> exception: anException [
	self 
		assert: [ anException isNotNil ] 
		description: [ 'Exception has to be initialized' ].
	exception := anException
]
