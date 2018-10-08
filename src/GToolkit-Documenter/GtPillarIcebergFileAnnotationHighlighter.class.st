Class {
	#name : #GtPillarIcebergFileAnnotationHighlighter,
	#superclass : #GtPillarInputFileAnnotationHighlighter,
	#category : #'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #initialization }
GtPillarIcebergFileAnnotationHighlighter >> initializeFileReference [
	GtDocumenterUtility 
		valueOf: self constants pathParameterName
		in: self pillarNode parameters 
		value: [ :aValue | 
			| aFile |
			aFile := aValue asFileReference.
			aFile exists ifTrue: [ fileReference := aFile. ^ self ].
			aFile := GtFileUtility 
					fileReferenceOfFileName: aValue 
					relativeTo: GtIcebergUtility repositoriesLocation.
			aFile exists ifTrue: [ fileReference := aFile. ^ self ].
			aFile := GtFileUtility 
					fileReferenceOfFileName: aValue 
					relativeTo: FileLocator workingDirectory / self constants localGtDirectory.
			aFile exists ifTrue: [ fileReference := aFile. ^ self ] ] 
		emptyValue: [ "do nothing" ] 
		defaultValue: [ "do nothing" ]
]
