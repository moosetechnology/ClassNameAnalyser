Extension { #name : #FAMIXPackageGroup }

{ #category : #'*DMConceptualModel' }
FAMIXPackageGroup >> allClassModels [
	^self collect: [ :each | each classmodels ]
]

{ #category : #'*DMConceptualModel' }
FAMIXPackageGroup >> packagemodels [
	^self collect: [ :each | each packagemodel ]
]
