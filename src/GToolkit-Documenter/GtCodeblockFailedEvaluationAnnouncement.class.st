Class {
	#name : #GtCodeblockFailedEvaluationAnnouncement,
	#superclass : #GtCodeblockEvalutedAnnouncement,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Documenter-Announcements'
}

{ #category : #accessing }
GtCodeblockFailedEvaluationAnnouncement >> exception [
	^ exception
]

{ #category : #accessing }
GtCodeblockFailedEvaluationAnnouncement >> exception: anObject [
	exception := anObject
]
