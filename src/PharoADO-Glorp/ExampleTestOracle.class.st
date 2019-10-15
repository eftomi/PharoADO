Class {
	#name : #ExampleTestOracle,
	#superclass : #TestCase,
	#category : #'PharoADO-Glorp-Examples'
}

{ #category : #tests }
ExampleTestOracle >> testAddPersons [
	| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: OraclePlatformADO new;
		connectString: 'Driver={Oracle in instantclient_19_3};dbq=itchy.miskoti.si:1521/XE;Uid=c##pharo;Pwd=pharo;';
		username: '';
		password: '';
		encodingStrategy: #utf8;
		yourself.

	session := ExampleDescriptorSystem sessionForLogin: login.
	session login.

"We will create some sample data for our example, and for the Persons we
will save three instances named after famous Smalltalkers, with random addresses, so don’t mail them."

	session inUnitOfWorkDo: [
		{ 'Dan'. 'Alan'. 'Adele' }
			with: {'Ingalls'. 'Kay'. 'Goldberg'}
			do: [ :firstName :lastName |
				| person |
				person := (Person new
					firstName: firstName;
					lastName: lastName).
				person addresses add: (
					Address new
						street: (1 to: 1000) atRandom printString
							, ' Random Avenue';
						zip: (1000 to: 9000 by: 100) atRandom;
						yourself).
				session register: person
			]
		].

"Now we created the sample Persons, let’s add an extra address for Alan."

	session inUnitOfWorkDo: [
		| alan |
		alan := session
			readOneOf: Person
			where: [ :each | each firstName = 'Alan' ].
		alan addresses
			add: (Address new
			street: '1025 Westwood Blv, 2nd Floor, Los Angeles, CA';
			zip: 90024;
			yourself)
	].

"As you can see, we didn’t have to register the newly created address because
the Person was read inside of a UnitOfWork. If we read the instance again
and inspect its addresses we will find the new instance is there."

	(session
		readOneOf: Person
		where: [ :each | each firstName = 'Alan' ]) addresses inspect.
		
"We can now procceed to create an few instances of Invoice. Let’s create one
invoice for each person in the database with two items describing donations to the Pharo Consortium2 and Association3 with randomized amounts (within a certain range) for each one."

	session inUnitOfWorkDo: [
		(session read: Person) do: [:person |
			| invoice |
			invoice := Invoice new
				issueDate: Date today;
				person: person;
				address: person addresses atRandom.
			invoice
				addItem: (InvoiceItem
					description: 'Pharo Consortium donation'
					price: (1000s to: 4000s by: 1000s) atRandom);
				addItem: (InvoiceItem
					description: 'Pharo Association donation'
					price: (20s to: 100s by: 10s) atRandom); yourself.
			session register: invoice.
		]
	].




]

{ #category : #tests }
ExampleTestOracle >> testCreateTables [
	| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: OraclePlatformADO new;
		connectString: 'Driver={Oracle in instantclient_19_3};dbq=itchy.miskoti.si:1521/XE;Uid=c##pharo;Pwd=pharo;';
		username: '';
		password: '';
		encodingStrategy: #utf8;
		yourself.

	session := ExampleDescriptorSystem sessionForLogin: login.
	session login.

	session createTables .
]

{ #category : #tests }
ExampleTestOracle >> testGroupBy [
	| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: OraclePlatformADO new;
		connectString: 'Driver={Oracle in instantclient_19_3};dbq=itchy.miskoti.si:1521/XE;Uid=c##pharo;Pwd=pharo;';
		username: '';
		password: '';
		encodingStrategy: #utf8;
		yourself.

	session := ExampleDescriptorSystem sessionForLogin: login.
	session login.
	
	(((SimpleQuery read: InvoiceItem)
		retrieve: [ :e |
			e invoice person id];
		retrieve: [ :e | e price sum ];
		groupBy: [ :e |
			e invoice person id]
		) executeIn: session) inspect.
		
	(((SimpleQuery read: InvoiceItem)
		retrieve: [ :each | each description];
		retrieve: [ :each | each price average ];
		groupBy: [ :each | each description]) executeIn: session) inspect.
		
]

{ #category : #tests }
ExampleTestOracle >> testOrderBy [
	| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: OraclePlatformADO new;
		connectString: 'Driver={Oracle in instantclient_19_3};dbq=itchy.miskoti.si:1521/XE;Uid=c##pharo;Pwd=pharo;';
		username: '';
		password: '';
		encodingStrategy: #utf8;
		yourself.

	session := ExampleDescriptorSystem sessionForLogin: login.
	session login.
	
	(((SimpleQuery read: InvoiceItem)
		orderBy: [:each | each price descending];
		orderBy: [:each | each invoice person lastName]
		) executeIn: session) inspect.
]

{ #category : #tests }
ExampleTestOracle >> testRead [
	| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: OraclePlatformADO new;
		connectString: 'Driver={Oracle in instantclient_19_3};dbq=itchy.miskoti.si:1521/XE;Uid=c##pharo;Pwd=pharo;';
		username: '';
		password: '';
		encodingStrategy: #utf8;
		yourself.

	session := ExampleDescriptorSystem sessionForLogin: login.
	session login.
	
"As usual, you can read the Invoices by doing session read: Invoice, let’s
print how much each Person donated."

	(session read: Invoice) do: [:each |
		Transcript
			show: each person firstName, ' ', each person lastName;
			show: ': ', each totalPrice printString;
			cr.
	].

	Transcript show: ((session read: Invoice) sum: #totalPrice); cr.

]

{ #category : #tests }
ExampleTestOracle >> testWhere [
	| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: OraclePlatformADO new;
		connectString: 'Driver={Oracle in instantclient_19_3};dbq=itchy.miskoti.si:1521/XE;Uid=c##pharo;Pwd=pharo;';
		username: '';
		password: '';
		encodingStrategy: #utf8;
		yourself.

	session := ExampleDescriptorSystem sessionForLogin: login.
	session login.
	
	(((SimpleQuery read: Invoice)
		where: [ :each | each person lastName = 'Goldberg' ]
		) executeIn: session) inspect.
		
	(((SimpleQuery read: Invoice)
		where: [:invoice |
			invoice items anySatisfy: [ :item |
				item price > 200 ]]) executeIn: session) inspect.
]
