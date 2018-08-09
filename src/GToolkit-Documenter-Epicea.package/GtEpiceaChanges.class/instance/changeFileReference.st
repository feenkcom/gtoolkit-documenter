accessing
changeFileReference
	<return: #FileReference>
	^ GtFileUtility 
		fileReferenceOfFileName: self pillarNode methodName
		relativeTo: self sourceDirectory