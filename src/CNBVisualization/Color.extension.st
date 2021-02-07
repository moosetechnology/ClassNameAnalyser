Extension { #name : #Color }

{ #category : #'*CNBVisualization' }
Color class >> value: aColor [
		^ColorRegistry at: aColor
]
