Extension { #name : #MiAbstractBrowser }

{ #category : #'*CNBVisualization' }
MiAbstractBrowser >> canFollowEntity: anObject [

	"whether the browser accepts to deal with anObject"

	^ anObject isMooseEntity 
]
