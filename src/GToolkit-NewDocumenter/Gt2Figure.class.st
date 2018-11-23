Class {
	#name : #Gt2Figure,
	#superclass : #Gt2LeaveResource,
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #'gt-extension' }
Gt2Figure >> gtFigureFor: aView [
	<gtView>
	self resource ifNil: [ ^ aView empty ].
	^ self resource gtFigureFor: aView
]

{ #category : #testing }
Gt2Figure >> isFigure [
	^ true
]
