Class {
	#name : #ADOGlorpTests,
	#superclass : #TestCase,
	#category : #'ADO-Glorp-Tests'
}

{ #category : #tests }
ADOGlorpTests >> testBasicConnectivity [
	| login accessor session |

	"to se požene enkrat, glej knjigo"
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: SQLServerPlatform new;
		connectString: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;';
		username: '';
		password: '';
		yourself.
	
	accessor := DatabaseAccessor forLogin: login.
	accessor login.
	accessor isLoggedIn .

	(accessor basicExecuteSQLString: 'SELECT 3+4') contents first first.

	session := TestingDescriptorSystem sessionForLogin: login.
	session login.
	
	session isLoggedIn .


"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Movies.mdf;Initial Catalog=Movies;Integrated Security=True"

]

{ #category : #tests }
ADOGlorpTests >> testCreateTables [
| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: SQLServerPlatform new;
		connectString: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;';
		username: '';
		password: '';
		yourself.

	session := TestingDescriptorSystem sessionForLogin: login.
	session login.

	session createTables .
]

{ #category : #tests }
ADOGlorpTests >> testInsertTables [
| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: SQLServerPlatform new;
		connectString: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;';
		username: '';
		password: '';
		yourself.

	session := TestingDescriptorSystem sessionForLogin: login.
	session login.

	session inUnitOfWorkDo: [
		{
			(Person new
				firstName: 'John'; lastName: 'Locke';
				birthDate: '1704-08-29' asDate).
			(Person new
				firstName: 'John'; lastName: 'Malkovich';
				birthDate: '1953-12-09' asDate).
			(Person new
				firstName: 'George'; lastName: 'Lucas';
				birthDate: '1944-05-14' asDate)
		} do: [ :each | session register: each ]
	].

]

{ #category : #tests }
ADOGlorpTests >> testReadTables [
| login session |
	PharoDatabaseAccessor DefaultDriver: ADODatabaseDriver .

	login := Login new
		database: SQLServerPlatform new;
		connectString: 'Provider=SQLNCLI11;Server=(localdb)\MSSQLLocalDB;Initial Catalog=People;Integrated Security=SSPI;';
		username: '';
		password: '';
		yourself.

	session := TestingDescriptorSystem sessionForLogin: login.
	session login.

	session read: Person.
]
