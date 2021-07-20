Class {
	#name : #GeoOPDriverRole,
	#superclass : #GeoOPUserRole,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #'as yet unclassified' }
GeoOPDriverRole class >> roleName [

	^'Bestuurder Kar'
]

{ #category : #'as yet unclassified' }
GeoOPDriverRole class >> roleString [

	^'driver'
]

{ #category : #testing }
GeoOPDriverRole >> isDriver [

	^true
]
