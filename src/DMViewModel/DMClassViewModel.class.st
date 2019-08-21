Class {
	#name : #DMClassViewModel,
	#superclass : #Object,
	#instVars : [
		'classRef',
		'color'
	],
	#category : #DMViewModel
}

{ #category : #accessing }
DMClassViewModel >> classRef [
	^ classRef
]

{ #category : #accessing }
DMClassViewModel >> classRef: aClass [
	classRef := aClass
]

{ #category : #accessing }
DMClassViewModel >> color [
	^ color
]

{ #category : #accessing }
DMClassViewModel >> color: aColor [
	color := aColor 
]
