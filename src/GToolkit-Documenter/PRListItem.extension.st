Extension { #name : 'PRListItem' }

{ #category : '*GToolkit-Documenter' }
PRListItem >> gtListItemStyler [
	<return: #GtListItemStyler>
	^ self propertyAt: #gtListItemStyler
]

{ #category : '*GToolkit-Documenter' }
PRListItem >> gtListItemStyler: aGt2ListItemStyler [
	self propertyAt: #gtListItemStyler put: aGt2ListItemStyler
]

{ #category : '*GToolkit-Documenter' }
PRListItem >> gtNodeStyler: aBlText [
	^ GtStyledListItemBuilder new 
		document: self gtDocument; 
		node: self;
		itemStyler: self gtListItemStyler;
		text: aBlText
]

{ #category : '*GToolkit-Documenter' }
PRListItem >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(self gtNodeStyler: aBlRope)
		adornListItemSymbolInMarkupViewMode.
]

{ #category : '*GToolkit-Documenter' }
PRListItem >> styleTextWithoutInteractions: aBlRope [
	"Do nothing"
]

{ #category : '*GToolkit-Documenter' }
PRListItem >> styleTextWithoutMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(self gtNodeStyler: aBlRope)
		adornListItemSymbolInNoMarkupViewMode;
		autoHideListItemSymbol
]
