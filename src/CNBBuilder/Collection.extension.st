Extension { #name : #Collection }

{ #category : #'*CNBBuilder' }
Collection >> hasMoreThanOneElement [

	^ self size > 1
]

{ #category : #'*CNBBuilder' }
Collection >> hasOneElement [

	^ self size = 1
]
