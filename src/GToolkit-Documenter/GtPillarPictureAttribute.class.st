"
I am an attributes that embeds a Form picture in text
"
Class {
	#name : #GtPillarPictureAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'image'
	],
	#category : 'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtPillarPictureAttribute class >> image: aForm [
	^ self new image: aForm
]

{ #category : #accessing }
GtPillarPictureAttribute >> affect: aBrText in: anEditorElement [

	| anImageElement |
	anImageElement := BlElement new
		size: self image extent;
		background: (BlBackground builder image: self image; build);
		yourself.

	^ GtDocumenterUtility newResizableAndPannableElementFor: anImageElement height: self image height
]

{ #category : #accessing }
GtPillarPictureAttribute >> image [
	<return: #Form>

	^ image
]

{ #category : #accessing }
GtPillarPictureAttribute >> image: aForm [
	image := aForm
]

{ #category : #initialization }
GtPillarPictureAttribute >> initialize [
	super initialize.
	self beAppend.
]
