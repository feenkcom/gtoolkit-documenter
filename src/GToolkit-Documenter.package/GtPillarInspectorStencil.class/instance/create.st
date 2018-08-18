api - instantiation
create
	| view button |
	view := GtPhlowEmptyView on: self inspectedObject perform: self showMethod.
	view actionStencil: [ 
		button := BrButton new.
		button 
				look: BrMaterialToggleIconifiedLook;
				icon: GLMUIThemeExtraIcons glamorousInspect asElement;
				action: [ button fireEvent: (GtPhlowObjectToSpawn new
					object: inspectedObject;
					sourceElement: button) ] ].
	^ view asElementDo: [ :element |
		element constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]