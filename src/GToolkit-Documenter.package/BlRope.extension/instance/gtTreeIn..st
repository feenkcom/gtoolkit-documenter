*GToolkit-Documenter
gtTreeIn: anElement
	| view |
	view := GtMondrian new.
	self paintTreeWith: view.
	view gtLiveIn: anElement