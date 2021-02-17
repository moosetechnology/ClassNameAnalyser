Extension { #name : #RSComposite }

{ #category : #'*CNBVisualization' }
RSComposite >> color [
	^ paint
	ifNil: [ DMPalette new monoClassColor ]
]
