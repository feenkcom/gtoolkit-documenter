Extension { #name : #ConfigurationForPillar }

{ #category : #'*GToolkit-NewDocumenter' }
ConfigurationForPillar >> gtDataWriter [
	<return: #Gt2ExternalDataWriter>
	^ self propertyAt: #gtDataWriter
]

{ #category : #'*GToolkit-NewDocumenter' }
ConfigurationForPillar >> gtDataWriter: aGt2ExternalDataWriter [ 
	^ self propertyAt: #gtDataWriter put: aGt2ExternalDataWriter
]
