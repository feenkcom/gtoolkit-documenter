*GToolkit-Documenter
gtInspectorTree2RepresentationIn: composite
	<gtInspectorPresentationOrder: 29>
	composite tree
		title: 'S-Tree';
		children: [ :item | 
					item hasChildren
						ifTrue: [ item children ] ];
		format: [ :item | (item class name allButFirst: 2) , '(' , ((PRPillarWriter write: item) printStringLimitedTo: 200) lines first , ')' ]