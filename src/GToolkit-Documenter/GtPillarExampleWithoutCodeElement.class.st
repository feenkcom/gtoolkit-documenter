Class {
	#name : #GtPillarExampleWithoutCodeElement,
	#superclass : #GtPillarExampleElement,
	#category : 'GToolkit-Documenter-Brick'
}

{ #category : #initialization }
GtPillarExampleWithoutCodeElement >> initialize [
	super initialize.
	
	previewHeight := 200
]

{ #category : #initialization }
GtPillarExampleWithoutCodeElement >> initializeElements [
	super initializeElements.
		
	"prewview should be visible by default"
	self showPreview: previewShowBlock
]
