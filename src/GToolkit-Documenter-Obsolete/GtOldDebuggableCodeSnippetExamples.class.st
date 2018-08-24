Class {
	#name : #GtOldDebuggableCodeSnippetExamples,
	#superclass : #Object,
	#instVars : [
		'fileSystemExamples'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #initialization }
GtOldDebuggableCodeSnippetExamples >> initialize [
	super initialize.
	fileSystemExamples := GtFileSystemExamples new.
]
