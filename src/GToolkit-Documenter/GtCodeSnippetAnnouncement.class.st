Class {
	#name : #GtCodeSnippetAnnouncement,
	#superclass : #GtDocumentAnnouncement,
	#instVars : [
		'codeSnippet'
	],
	#category : 'GToolkit-Documenter-Announcements'
}

{ #category : #'instance creation' }
GtCodeSnippetAnnouncement class >> document: aGtDocument codeSnippet: aGtDebuggableCodeSnippet [
	^ self new
			document: aGtDocument;
			codeSnippet: aGtDebuggableCodeSnippet
	
]

{ #category : #accessing }
GtCodeSnippetAnnouncement >> codeSnippet [
	^ codeSnippet
]

{ #category : #accessing }
GtCodeSnippetAnnouncement >> codeSnippet: aGtDebuggableCodeSnippet [
	self 
		assert: [ aGtDebuggableCodeSnippet isNotNil ] 
		description: [ 'Code snippet has to be initialized' ].
	codeSnippet := aGtDebuggableCodeSnippet
]
