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
		connectString: 'DSN=ISLOVAR;';
"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Movies.mdf;Initial Catalog=Movies;Integrated Security=True"
		username: 'Islovar30';
		password: 'informatika01'.
	
	accessor := DatabaseAccessor forLogin: login.
	accessor login.
	(accessor basicExecuteSQLString: 'SELECT 3+4') contents first first.


"
	accessor isLoggedIn .
	session := TestingDescriptorSystem sessionForLogin: login.
	session login.
	
	session isLoggedIn .
"


]
