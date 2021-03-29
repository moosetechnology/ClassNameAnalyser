Class {
	#name : #CNBHierarchiesPresenter,
	#superclass : #SpDropListPresenter,
	#instVars : [
		'hierarchies'
	],
	#category : #CNBSpec
}

{ #category : #specs }
CNBHierarchiesPresenter class >> defaultSpec [
	<spec: #default>
	^ SpAbstractWidgetLayout for: self adapterName
]

{ #category : #initialization }
CNBHierarchiesPresenter >> initialize [

	super initialize.

	self
		help: 'Choose a hierarchy';
		display: [ :aHierarchy | aHierarchy name ]
]

{ #category : #initialization }
CNBHierarchiesPresenter >> run [

	<script: 'self new openWithSpec extent: 400 @ 25'>

]

{ #category : #initialization }
CNBHierarchiesPresenter >> title [

	^ 'Hierarchies'
]
