Class {
	#name : #GtOldAnnouncableCodeSnippet,
	#superclass : #GtOldCodeSnippetResult,
	#traits : 'GtAnnouncerTrait',
	#classTraits : 'GtAnnouncerTrait classTrait',
	#instVars : [
		'announcer'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'announcer - accessing' }
GtOldAnnouncableCodeSnippet >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #initialization }
GtOldAnnouncableCodeSnippet >> initialize [
	super initialize.
	announcer := Announcer new
]
