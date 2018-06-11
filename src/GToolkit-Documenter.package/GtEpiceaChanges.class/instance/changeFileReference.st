accessing
changeFileReference
	<return: #FileReference>
	^ GtFileUtility 
		fileReferenceOfFileName: self pillarNode fileParameterValue
		relativeTo: self sourceDirectory