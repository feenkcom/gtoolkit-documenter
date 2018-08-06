*GToolkit-Documenter
sourceFile
	^ self 
		propertyAt: #sourceFile 
		ifAbsent: [ self error: 'Source file should be initialized first' ]