Class {
	#name : #GtOldPillarStyler,
	#superclass : #BrTextStyler,
	#instVars : [
		'workspace',
		'fileReference'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldPillarStyler >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtOldPillarStyler >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #private }
GtOldPillarStyler >> privateStyle: aText [ 
	GtOldPillarHighlightingParser new 
		fileReference: fileReference;
		targetText: aText;
		workspace: workspace;
		parse: aText asString;
		cleanWorkspace.
	^ aText
]

{ #category : #accessing }
GtOldPillarStyler >> workspace [
	^ workspace
]

{ #category : #accessing }
GtOldPillarStyler >> workspace: anObject [
	workspace := anObject
]
