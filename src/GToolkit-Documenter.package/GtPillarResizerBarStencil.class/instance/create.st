api - instantiation
create
	<return: #BlElement>
	| aComposite |
	aComposite := self stencil asElement.
	aComposite addChild: (self newResizerBarElementOn: aComposite).
	^ aComposite