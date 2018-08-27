"
I am a wrapper over a string. I expect the string to be a Pillar document.

I am particularly useful for providing inspection possibilities for a string.

[[[
'!This is a Pillar string' asPillar
]]]
"
Class {
	#name : #GtDocumenterPillarString,
	#superclass : #Object,
	#instVars : [
		'string'
	],
	#category : 'GToolkit-Documenter-Utility'
}

{ #category : #ui }
GtDocumenterPillarString >> gtPillarFor: aView [
	<gtView>
	^ aView explicit
		title: 'Pillar';
		priority: 50;
		stencil: [ GtDocumenter editorForText: self string ]
]

{ #category : #accessing }
GtDocumenterPillarString >> string [
	^ string
]

{ #category : #accessing }
GtDocumenterPillarString >> string: anObject [
	string := anObject
]
