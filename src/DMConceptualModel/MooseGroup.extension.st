Extension { #name : #MooseGroup }

{ #category : #'*DMConceptualModel' }
MooseGroup >> conceptualPackageModels [

	^ DMPackageModelGroup new addAll: (self packagemodels)
]

{ #category : #'*DMConceptualModel' }
MooseGroup >> packagemodels [
	^self collect: [ :each | each packagemodel ]
]
