Class {
	#name : #Gt2EpiceaUpdatedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'hasImpact',
		'impactChanged',
		'numberOfEvents',
		'previousNumberOfEvents'
	],
	#category : #'GToolkit-NewDocumenter-Announcements'
}

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> eventDifference [
	^ self numberOfEvents - self previousNumberOfEvents
]

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> hasImpact [
	^ hasImpact
]

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> hasImpact: anObject [
	hasImpact := anObject
]

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> impactChanged [
	^ impactChanged
]

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> impactChanged: anObject [
	impactChanged := anObject
]

{ #category : #testing }
Gt2EpiceaUpdatedAnnouncement >> impactChangedOrNumberOfEventsChanged [
	^ self impactChanged or: [ self eventDifference isZero not ]
]

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> numberOfEvents [
	^ numberOfEvents
]

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> numberOfEvents: anObject [
	numberOfEvents := anObject
]

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> previousNumberOfEvents [
	^ previousNumberOfEvents
]

{ #category : #accessing }
Gt2EpiceaUpdatedAnnouncement >> previousNumberOfEvents: anObject [
	previousNumberOfEvents := anObject
]

{ #category : #printing }
Gt2EpiceaUpdatedAnnouncement >> printOn: aStream [
	aStream
		nextPutAll: 'Epicea updated, impact: ';
		print: self hasImpact;
		nextPutAll: ', changed: ';
		print: self impactChanged;
		nextPutAll: ', events: ';
		print: self numberOfEvents;
		nextPutAll: ', previously: ';
		print: self previousNumberOfEvents
]
