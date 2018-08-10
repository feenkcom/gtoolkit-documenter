instance creation
newArrowElement
	"Instantiate and return a new element playing a role of an arrow
	used to show / hide a preview"
	<return: #BlElement>

	^ BlElement new
		size: 16@24;
		geometry: (BlPolygon vertices: { 0@0 . 24@0 . 12@16 } );
		margin: (BlInsets top: 5 right: 0 bottom: 5 left: 0);
		background: Color veryVeryLightGray