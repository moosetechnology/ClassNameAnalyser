Extension { #name : #MooseEntity }

{ #category : #'*DMConceptualModel' }
MooseEntity >> conceptualPackageModels [

	^ DMPackageModelGroup new addAll: (self packagemodels)
]
