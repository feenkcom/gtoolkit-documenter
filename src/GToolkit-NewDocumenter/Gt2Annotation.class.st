Class {
	#name : #Gt2Annotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #testing }
Gt2Annotation class >> isAbstract [
	^ self name = #Gt2Annotation 
]

{ #category : #'api - style' }
Gt2Annotation >> styleInText: aBlRope [
	"Subclasses can add another styling"
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: self constants subtleColor.
]
