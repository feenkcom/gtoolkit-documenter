instance creation
newPreviewElement
	"Instantiate and return an element playing a role of a container for
	the resulting GT-Example element"
	<return: #BlElement>

	^ BlElement new
		layout: BlLinearLayout new