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

{ #category : #'*GToolkit-NewDocumenter' }
ConfigurationForPillar >> gtDocument [
	<return: #Gt2Document>
	^ self propertyAt: #gtDocument
]

{ #category : #'*GToolkit-NewDocumenter' }
ConfigurationForPillar >> gtDocument: aGt2Document [
	^ self propertyAt: #gtDocument put: aGt2Document
]
