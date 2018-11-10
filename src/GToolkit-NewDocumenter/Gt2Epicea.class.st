Class {
	#name : #Gt2Epicea,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'ombuFile',
		'epiceaLog',
		'events'
	],
	#category : #'GToolkit-NewDocumenter-Epicea'
}

{ #category : #modification }
Gt2Epicea >> addEvent: anEpEvent [ 
	self ombuFile parent exists ifFalse: [ self ombuFile parent ensureCreateDirectory ].
	self 
		assert: [ self ombuFile parent exists ] 
		description: [ 'The parent directory of the Epicea change file must exist' ].
	self log addEntryWith: anEpEvent tags: [ :tags | "ignore" ].
	events addLast: anEpEvent.
]

{ #category : #accessing }
Gt2Epicea >> entries [
	<return: #OrderedeCollection of: #OmEntry>
	^ self log entries
]

{ #category : #accessing }
Gt2Epicea >> events [
	<return: #OrderedeCollection of: #EpEvent>
	^ self entries collect: #content
]

{ #category : #accessing }
Gt2Epicea >> log [
	<return: #EpLog>
	^ epiceaLog
]

{ #category : #accessing }
Gt2Epicea >> numberOfEvents [
	<return: #Integer>
	^ events ifNotNil: #size ifNil: 0
]

{ #category : #accessing }
Gt2Epicea >> ombuFile [
	<return: #FileReference>
	^ ombuFile
]

{ #category : #accessing }
Gt2Epicea >> ombuFile: aFileReference [
	ombuFile := aFileReference.
	epiceaLog := EpLog fromFile: "freshFromFile:" ombuFile.
	events := self events.
]

{ #category : #modification }
Gt2Epicea >> removeEvent: anEpEvent [
	| aNewEvents |
	aNewEvents := self events reject: [ :eachEvent | eachEvent = anEpEvent ].
	ombuFile ensureDelete.
	aNewEvents do: [ :eachEvent | self addEvent: eachEvent ].
	events := aNewEvents.
]
