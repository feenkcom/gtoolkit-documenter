Extension { #name : #ConfigurationForPillar }

{ #category : #'*GToolkit-NewDocumenter' }
ConfigurationForPillar >> gtDataWriter [
	<return: #Gt2ExternalDataWriter>
	^ self propertyAt: #gtDataWriter ifAbsentPut: [ Gt2ExternalDataWriter new ]
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

{ #category : #'*GToolkit-NewDocumenter' }
ConfigurationForPillar >> gtUniqueIdGenerator [
	<return: #Gt2UniqueIdGenerator>
	^ self propertyAt: #gtUniqueIdGenerator ifAbsentPut: [ Gt2UniqueIdGenerator new ]
]

{ #category : #'*GToolkit-NewDocumenter' }
ConfigurationForPillar >> gtUniqueIdGenerator: aGt2UniqueIds [ 
	^ self propertyAt: #gtUniqueIdGenerator put: aGt2UniqueIds
]
