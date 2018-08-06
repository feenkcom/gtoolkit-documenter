private - accessing
figureFileReferenceOrNil
	"Return a figure file reference or nil if figure reference is not file"
	<return: #FileReference or: nil>
	| aFileName |
	(self pillarNode reference beginsWith: 'file://') ifFalse: [ ^ nil ].
	aFileName := self pillarNode reference
	                copyFrom: 'file://' size + 1
	                to: self pillarNode reference size.
	^ GtFileUtility 
		fileReferenceOfFileName: aFileName 
		relativeTo: self fileReference parent