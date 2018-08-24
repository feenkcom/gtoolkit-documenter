Class {
	#name : #GtOldEpiceaCodeSnippet,
	#superclass : #GtOldAnnouncableCodeSnippet,
	#instVars : [
		'epiceaLog'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldEpiceaCodeSnippet >> epiceaLog [
	^ epiceaLog
]

{ #category : #'gt-inspector-extension' }
GtOldEpiceaCodeSnippet >> gtInspectorEntriesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ epiceaLog ifNotNil: [ :aLog | 
		(aLog gtInspectorEntriesIn: composite) ]
]

{ #category : #'announcement handling' }
GtOldEpiceaCodeSnippet >> handleEpEntryAddedAnnouncement: anEpEntryAdded [ 
	self announce: (
			GtEpiceaImpactChangedAnnouncement new hasImpact: true)
]

{ #category : #'announcement handling' }
GtOldEpiceaCodeSnippet >> handleSystemChange: aSystemAnnouncement [
	self epiceaLog isValid ifFalse: [ ^ self ].
	self epiceaLog checkImpact.
	self announce: (
			GtEpiceaImpactChangedAnnouncement 
				document: self document 
				codeSnippet: self 
				withImpact: self epiceaLog hasImpact)
]

{ #category : #initialization }
GtOldEpiceaCodeSnippet >> initializeFromTokens: aGtPillarScriptTokens [
	"Initialize code snippet using an information from a Pillar document"
	super initializeFromTokens: aGtPillarScriptTokens.
	self assert: [ epiceaLog isNil ] description: [ 'Epicea log should be initialized just once' ].
	epiceaLog := GtEpiceaLog fromFileReference: aGtPillarScriptTokens epiceaParameterValue.
	epiceaLog 
		subscribe: EpEntryAdded 
		send: #handleEpEntryAddedAnnouncement: 
		to: self 
		for: self.
]

{ #category : #private }
GtOldEpiceaCodeSnippet >> subscribeToDocument: aGtDocument [ 
	super subscribeToDocument: aGtDocument.
	aGtDocument systemChangesHandler
		subscribe: ClassAnnouncement, MethodAnnouncement
		send: #handleSystemChange:
		to: self.
]
