Class {
	#name : #Gt2ExamplesAnnotation,
	#superclass : #Gt2Annotation,
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2ExamplesAnnotation class >> possibleParameters [
	^ {
		self constants methodsParameterName.
		self constants classesParameterName.
		self constants packagesParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
Gt2ExamplesAnnotation class >> tag [
	^ self constants examplesAnnotationName
]
