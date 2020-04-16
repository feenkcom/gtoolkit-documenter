Class {
	#name : #XdDocumenterShareInformation,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'lastInformation'
	],
	#category : #'GToolkit-Documenter-XDoc-Settings'
}

{ #category : #accessing }
XdDocumenterShareInformation >> last [
	^ lastInformation ifNil: [ lastInformation := XdShareInformation new ]
]
