Extension { #name : #FamixJavaPackage }

{ #category : #'*CNBModels' }
FamixJavaPackage >> classes [

	^ (self toScope: FamixTClass) select: [ :each | 
		  each typeContainer = self ]
]
