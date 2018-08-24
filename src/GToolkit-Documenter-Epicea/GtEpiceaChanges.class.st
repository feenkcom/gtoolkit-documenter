Class {
	#name : #GtEpiceaChanges,
	#superclass : #GtPillarDocumentPart,
	#instVars : [
		'epiceaLog',
		'sourceFileReference'
	],
	#category : 'GToolkit-Documenter-Epicea'
}

{ #category : #accessing }
GtEpiceaChanges >> changeFileReference [
	<return: #FileReference>
	^ GtFileUtility 
		fileReferenceOfFileName: self pillarNode methodName
		relativeTo: self sourceDirectory
]

{ #category : #accessing }
GtEpiceaChanges >> epiceaLog [
	^ epiceaLog
]

{ #category : #'announcement handling' }
GtEpiceaChanges >> handleEpEntryAddedAnnouncement: anEpEntryAdded [ 
	self announce: (
			GtEpiceaImpactChangedAnnouncement new hasImpact: true)
]

{ #category : #'system changes' }
GtEpiceaChanges >> handleSystemChange: aSystemAnnouncement [
	self epiceaLog isValid ifFalse: [ ^ self ].
	self epiceaLog checkImpact.
	self announce: (
			GtEpiceaImpactChangedAnnouncement 
				document: self document 
				codeSnippet: self 
				withImpact: self epiceaLog hasImpact)
]

{ #category : #accessing }
GtEpiceaChanges >> pillarNode: aPRDocumentItem [
	super pillarNode: aPRDocumentItem.
	self assert: [ epiceaLog isNil ] description: [ 'Epicea log should be initialized just once' ].
	epiceaLog := GtEpiceaLog fromFileReference: self changeFileReference.
	epiceaLog 
		subscribe: EpEntryAdded 
		send: #handleEpEntryAddedAnnouncement: 
		to: self 
		for: self.
]

{ #category : #accessing }
GtEpiceaChanges >> sourceDirectory [
	"Return parent directory of a source file"
	<return: #FileReference>
	^ self sourceFileReference parent
]

{ #category : #accessing }
GtEpiceaChanges >> sourceFileReference [
	<return: #FileReference>
	self 
		assert: [ sourceFileReference notNil ]
		description: [ 'Pillar source file has to be initialized first' ].	
	^ sourceFileReference
]

{ #category : #accessing }
GtEpiceaChanges >> sourceFileReference: aFileReference [
	self assert: [ aFileReference notNil ] description: [ 'Source file has to be initialized' ].
	self assert: [ aFileReference exists ] description: [ 'Source file has to exist' ].
	sourceFileReference := aFileReference
]

{ #category : #private }
GtEpiceaChanges >> subscribeToDocument: aGtDocument [ 
	super subscribeToDocument: aGtDocument.
	aGtDocument systemChangesHandler
		subscribe: ClassAnnouncement, MethodAnnouncement
		send: #handleSystemChange:
		to: self.
]
