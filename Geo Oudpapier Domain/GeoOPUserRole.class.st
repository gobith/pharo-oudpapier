Class {
	#name : #GeoOPUserRole,
	#superclass : #Object,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserRole class >> fromString: aString [ 
	
	
	^(self subclasses detect: [ : cls | cls roleString = aString ] ifNone: [ GeoOPNormalRole  ]) new
]

{ #category : #accessing }
GeoOPUserRole class >> roleClasses [

	^{ GeoOPNormalRole . GeoOPDriverRole . GeoOPCoordinatorRole . GeoOPArchiveRole }
]

{ #category : #accessing }
GeoOPUserRole class >> roleName [

	^self subclassResponsibility 
]

{ #category : #accessing }
GeoOPUserRole class >> roleString [

	^self subclassResponsibility 
]

{ #category : #testing }
GeoOPUserRole >> inSchedule [
	^true
]

{ #category : #testing }
GeoOPUserRole >> isDriver [

	^false
]

{ #category : #testing }
GeoOPUserRole >> isNormal [

	^false
]

{ #category : #testing }
GeoOPUserRole >> roleString [

	^self class roleString
]

{ #category : #testing }
GeoOPUserRole >> showInSchedule [

	^true
]
