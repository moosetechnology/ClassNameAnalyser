Trait {
	#name : #CNBTRootOrganizer,
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBTRootOrganizer >> selectAttributedNodes: nodesCollection [ 

	^ nodesCollection 
		select: [ :each | each 
						model root isNotNil and: [ each 
						model root model = self model and: [ each children isNil ]
						] 
					]
]
