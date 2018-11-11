Class {
	#name : #GtPillarIcebergFileAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'GtDocumenterConstantsTrait + TBlDebug',
	#classTraits : 'GtDocumenterConstantsTrait classTrait + TBlDebug classTrait',
	#category : #'GToolkit-Documenter-Pillar - Nodes'
}

{ #category : #accessing }
GtPillarIcebergFileAnnotation class >> possibleParameters [
	^ {
		self constants pathParameterName.
		}
]

{ #category : #protected }
GtPillarIcebergFileAnnotation class >> tag [
	^ self constants icebergFileTag
]

{ #category : #visitor }
GtPillarIcebergFileAnnotation >> accept: aVisitor [
	^ aVisitor visitGtPillarIcebergFileAnnotation: self
]
