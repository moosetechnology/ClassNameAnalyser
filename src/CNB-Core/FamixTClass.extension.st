Extension { #name : #FamixTClass }

{ #category : #'*CNB-Core' }
FamixTClass >> printWithBold: aStringOrText [

	^ (CNBClassHierarchyPrinter forFamixClass: self)
		  printWithEmphasisOn: aStringOrText
]
