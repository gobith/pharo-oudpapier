Class {
	#name : #GeoOPArchiveRole,
	#superclass : #GeoOPUserRole,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPArchiveRole class >> roleName [

	^'Archief'
]

{ #category : #accessing }
GeoOPArchiveRole class >> roleString [

	^'archive'
]

{ #category : #testing }
GeoOPArchiveRole >> showInSchedule [

	^false
]
