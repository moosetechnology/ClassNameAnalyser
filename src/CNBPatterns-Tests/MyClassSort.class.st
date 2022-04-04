Class {
	#name : #MyClassSort,
	#superclass : #Object,
	#instVars : [
		'name',
		'size'
	],
	#category : #'CNBPatterns-Tests'
}

{ #category : #accessing }
MyClassSort >> name [ 
	^ name
]

{ #category : #accessing }
MyClassSort >> name: aName [ 
	name := aName
]

{ #category : #accessing }
MyClassSort >> size [ 
	^ size
]

{ #category : #accessing }
MyClassSort >> size: aNumber [ 
	size := aNumber 
]
