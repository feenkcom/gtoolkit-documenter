Class {
	#name : #Gt2CodeblockFailedEvaluationAnnouncement,
	#superclass : #Gt2CodeblockEvalutedAnnouncement,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-NewDocumenter-Announcements'
}

{ #category : #accessing }
Gt2CodeblockFailedEvaluationAnnouncement >> exception [
	^ exception
]

{ #category : #accessing }
Gt2CodeblockFailedEvaluationAnnouncement >> exception: anObject [
	exception := anObject
]
