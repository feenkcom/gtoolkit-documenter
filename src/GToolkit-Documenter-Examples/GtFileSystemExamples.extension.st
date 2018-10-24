Extension { #name : #GtFileSystemExamples }

{ #category : #'*GToolkit-Documenter-Examples' }
GtFileSystemExamples >> addPillarFileWithContent: aString [
	^ self 
		addFileNamed: self pillarFileName 
		toDirectory: self rootDirectory 
		withContent: aString
]

{ #category : #'*GToolkit-Documenter-Examples' }
GtFileSystemExamples >> pillarFileName [
	<gtExample>
	<label: 'Pillar filename'>
	^ 'index.pillar'
]

{ #category : #'*GToolkit-Documenter-Examples' }
GtFileSystemExamples >> pillarFileReference [
	<gtExample>
	<label: 'FileReference with a Pillar content'>
	^ (self rootDirectory / self pillarFileName)
]
