Extension { #name : #FAMIXNamespaceGroup }

{ #category : #'*DMConceptualModel' }
FAMIXNamespaceGroup >> allClassModels [
	^self collect: [ :each | each classmodels ]
]

{ #category : #'*DMConceptualModel' }
FAMIXNamespaceGroup >> packagemodels [
	^self collect: [ :each | each packagemodel ]
]
