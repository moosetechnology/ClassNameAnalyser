Extension { #name : #RTShapeBuilder }

{ #category : #'*DMRoassalClassNameBlueprint' }
RTShapeBuilder >> withTextAbove: aSymbolOrABlock color: aColor [
	| newShape |
	newShape := RTCompositeShape new.
	newShape add: (RTLabel new color: aColor; text: aSymbolOrABlock).
	newShape add: shape.
	newShape vertical.
	newShape setAutomaticRelayout.
	shape := newShape.
]
