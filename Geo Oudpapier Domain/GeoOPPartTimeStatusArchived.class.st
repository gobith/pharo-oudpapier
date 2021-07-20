Class {
	#name : #GeoOPPartTimeStatusArchived,
	#superclass : #GeoOPPartTimeStatus,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPPartTimeStatusArchived >> buttonString [

	^'Archiveer'
]

{ #category : #testing }
GeoOPPartTimeStatusArchived >> isActive [

	^false
]

{ #category : #testing }
GeoOPPartTimeStatusArchived >> isArchived [

	^true
]

{ #category : #accessing }
GeoOPPartTimeStatusArchived >> nextStatus [

	^GeoOPPartTimeStatusOpen singleInstance
]

{ #category : #accessing }
GeoOPPartTimeStatusArchived >> scheduleImageFor: aStatus [

	^aStatus scheduleImageClosed
]

{ #category : #accessing }
GeoOPPartTimeStatusArchived >> scheduleStringFor: aStatus [

	^aStatus scheduleStringArchived
]

{ #category : #accessing }
GeoOPPartTimeStatusArchived >> statusString [

	^'Gearchiveerd'
]

{ #category : #accessing }
GeoOPPartTimeStatusArchived >> statusSymbol [

	^#archived
]
