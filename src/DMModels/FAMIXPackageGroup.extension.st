Extension { #name : #FAMIXPackageGroup }

{ #category : #'*DMModels' }
FAMIXPackageGroup >> allClassModels [
	^self collect: [ :each | each classmodels ]
]
