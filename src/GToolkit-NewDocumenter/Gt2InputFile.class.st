Class {
	#name : #Gt2InputFile,
	#superclass : #Gt2Resource,
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #'gt-extension' }
Gt2InputFile >> gtTextFor: aView [
	<gtView>
	self resource ifNil: [ ^ aView empty ].
	^ self resource gtTextFor: aView
]
