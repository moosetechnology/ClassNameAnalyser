Extension { #name : #FAMIXNamespaceGroup }

{ #category : #'*DMModels' }
FAMIXNamespaceGroup >> allClassModels [
	^self collect: [ :each | each classmodels ]
]
