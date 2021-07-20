Class {
	#name : #GeoOPUserStatusScheduled,
	#superclass : #GeoOPUserStatusParticipating,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserStatusScheduled class >> statusSymbol [

	^#scheduled
]

{ #category : #accessing }
GeoOPUserStatusScheduled class >> userStatusString [

	^'Ingepland'
]

{ #category : #accessing }
GeoOPUserStatusScheduled >> color [

	^Color blue lighter
]

{ #category : #testing }
GeoOPUserStatusScheduled >> isScheduled [

	^true
]

{ #category : #accessing }
GeoOPUserStatusScheduled >> nextAdminStatusesOn: coll user: aUser [
	coll
		add: self iCanStatus;
		add: self iCannotStatus;
		add: self confirmedStatus
]

{ #category : #accessing }
GeoOPUserStatusScheduled >> nextConfirmedStatusOrNil [

	^self confirmedStatus 
]

{ #category : #'accessing schedule' }
GeoOPUserStatusScheduled >> scheduleStringClosed [

	^'?'
]

{ #category : #accessing }
GeoOPUserStatusScheduled >> userButtonString [

	^'Plan in'
]
