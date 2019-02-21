Class {
	#name : #GtFigure,
	#superclass : #GtLeaveResource,
	#category : #'GToolkit-Documenter-Resourcer'
}

{ #category : #'gt-extension' }
GtFigure >> gtFigureFor: aView [
	<gtView>
	self resource ifNil: [ ^ aView empty ].
	^ self resource gtFigureFor: aView
]

{ #category : #testing }
GtFigure >> isFigure [
	^ true
]
