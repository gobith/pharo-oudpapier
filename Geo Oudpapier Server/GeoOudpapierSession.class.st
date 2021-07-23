Class {
	#name : #GeoOudpapierSession,
	#superclass : #Object,
	#instVars : [
		'teapot',
		'schedule'
	],
	#category : #'Geo Oudpapier Server'
}

{ #category : #initialization }
GeoOudpapierSession >> addRoutes [

	teapot
		GET: '/getuser' -> [ :request | self request_user: request ];
		GET: '/login' -> [ :request | self request_login: request ];
		GET: '/users' -> [ :request | self request_users: request ];
		GET: '/years' -> [ :request | self request_years: request ];
		GET: '/current-year' -> [ :request | self request_currentYear: request ]
]

{ #category : #initialization }
GeoOudpapierSession >> initialize [ 

	super initialize .
	
]

{ #category : #initialization }
GeoOudpapierSession >> login: aRequest [

	^'{"test": 12}'
]

{ #category : #initialization }
GeoOudpapierSession >> portNumber [
	^ 8090
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_currentYear: aRequest [ 
	^schedule currentCollectionYear 
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_login: aRequest [

	| authorization response userName password user session |

	response := Dictionary new.
	response
		at: 'id' put: nil;
		at: 'name' put: '';
		at: 'loggedIn' put: false;
		at: 'isAdmin' put: false.

	authorization := [ aRequest basicAuthentication ]
		                 on: Error
		                 do: [ nil ].

	authorization ifNil: [ ^response ].
	userName := authorization first.
	password := authorization last.

	user := schedule userNamed: userName.
	user ifNil: [ ^ response ].
	user password = password ifFalse: [ ^ response ].
	session := aRequest session.
	session attributeAt: 'user' put: user id.

	response
		at: 'isAdmin' put: user isAdmin;
		at: 'name' put: user name;
		at: 'id' put: user id;
		at: 'loggedIn' put: true.
		
	^response
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_user: aRequest [

	| session response |
	response := Dictionary new.
	response
		at: 'id' put: nil;
		at: 'name' put: '';
		at: 'loggedIn' put: false;
		at: 'isAdmin' put: false.

	session := aRequest session.
	session isValid ifTrue: [ 
		(session attributeAt: 'user' ifAbsent: [ nil ]) ifNotNil: [ 
			:userId | 
			| user |
			user := schedule userAt: userId.
			user ifNotNil: [ 
				response
					at: 'isAdmin' put: user isAdmin;
					at: 'name' put: user name;
					at: 'id' put: user id;
					at: 'loggedIn' put: true ] ] ].

	^ response
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_users: aRequest [
		
	^schedule sortedUsers
]

{ #category : #'accessing-requests' }
GeoOudpapierSession >> request_years: aRequest [
	^schedule reversedCollectionYears 
]

{ #category : #initialization }
GeoOudpapierSession >> start [

	self stop.
	
	schedule := GeoOPCollectionSchedule new.
	schedule fileIn.
	schedule setAdminUser.
	schedule createCollectionMonths.
	
	teapot := Teapot configure: {(#port -> self portNumber) . #defaultOutput -> #json . #debugMode -> true}.

	self addRoutes.
	teapot start
]

{ #category : #initialization }
GeoOudpapierSession >> stop [ 
	
	teapot ifNotNil: [ teapot stop ].
	teapot := nil.
	schedule := nil
]
