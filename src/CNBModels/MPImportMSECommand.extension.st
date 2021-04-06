Extension { #name : #MPImportMSECommand }

{ #category : #'*CNBModels' }
MPImportMSECommand >> execute [

	| importForm |
	importForm := MooseImportFromMSEForm new.
	importForm announcer
		when: MPNewModelInstalled
		do: [ :ann | self context model: ann newModel ].
	importForm openModalWithSpec
]
