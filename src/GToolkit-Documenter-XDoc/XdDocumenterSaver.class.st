"
I store a {{gtClass:GtDocumenter}} content (text) into a {{gtClass:XdFile}}.
I am used by {{gtClass:GtDocumenter}}.


"
Class {
	#name : #XdDocumenterSaver,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'document',
		'information',
		'storage',
		'file'
	],
	#category : #'GToolkit-Documenter-XDoc-Publishers'
}

{ #category : #'instance creation' }
XdDocumenterSaver class >> forDocument: aDocumenter [
	^ self new document: aDocumenter
]

{ #category : #'api - accessing' }
XdDocumenterSaver >> document [
	<return: #GtDocumenter>
	self 
		assert: [ document isNotNil ] 
		description: [ 'Documenter must be initialized before accessing it' ].
	^ document
]

{ #category : #'api - accessing' }
XdDocumenterSaver >> document: aGtDocumenter [
	document := aGtDocumenter
]

{ #category : #accessing }
XdDocumenterSaver >> file [
	<return: #XdFile>
	^ file
]

{ #category : #accessing }
XdDocumenterSaver >> file: anXdFile [
	file := anXdFile
]

{ #category : #testing }
XdDocumenterSaver >> hasFile [
	<return: #Boolean>
	^ self file isNotNil
]

{ #category : #'api - accessing' }
XdDocumenterSaver >> information [
	<return: #XdShareInformation>
	^ information
]

{ #category : #'api - accessing' }
XdDocumenterSaver >> information: anXdShareInformation [
	information := anXdShareInformation
]

{ #category : #initialization }
XdDocumenterSaver >> initialize [
	super initialize.
	information := XdShareInformation new.
	storage := XdStreamingStrategy bytes.
]

{ #category : #'api - publishing' }
XdDocumenterSaver >> save [
	<return: #XdFile>
	^ file := XdWriter new
			streamingStrategy: self storage;
			document: self document;
			documentHtml: self document;
			preview;
			title: self information title asString;
			authorName: self information author asString;
			description: self information description asString;
			write.
]

{ #category : #'api - accessing' }
XdDocumenterSaver >> storage [
	<return: #XdStreamingStrategy>
	^ storage
]

{ #category : #'api - accessing' }
XdDocumenterSaver >> storage: anXdStreamingStrategy [
	storage := anXdStreamingStrategy
]
