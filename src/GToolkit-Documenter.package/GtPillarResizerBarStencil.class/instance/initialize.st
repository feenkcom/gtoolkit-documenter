initialization
initialize
	super initialize.
	contentStencilBuilder := [ BlElement new ] asStencilBuilder.
	minimumExtent := 0@75.