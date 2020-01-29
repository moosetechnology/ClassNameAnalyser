Extension { #name : #MooseGroup }

{ #category : #'*DMModels' }
MooseGroup >> conceptualPackageModels [

	^ (DMPackageModelGroup new addAll: (self packagemodels))
]

{ #category : #'*DMModels' }
MooseGroup >> packagemodels [
	^self collect: [ :each | each packagemodel ]
]
