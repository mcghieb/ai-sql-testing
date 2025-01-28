import psycopg2
import sys

class Db:
    """
        This is the database control class.
    """
    
    def __init__(self, dbname, user, password, host, port):
        _connparams = {
            "dbname": dbname,
            "user": user,
            "password": password,
            "host": host,
            "port": port
        }
        
        try:
            _dbconn = psycopg2.connect(**_connparams)
            _health = "Healthy"
        except Exception as e:
            print(f"Database connection not made.\n\t{e}\n", file=sys.stderr)
            _health = "Not Healthy"
        
        _cursorList = []


    def runQuery(self, query: str, params: tuple[str]):
        """
            This function is used to run queries on the database.

            - Args: Query (string with %s as the user inputs), params (tuple(str) of params to insert)
            - Returns: All rows where the cursor executed 
        """
        try:
            if self._health != "Healthy":
                raise Exception("Db connection is not healthy.")
            
            cursor = self._dbconn.cursor()
            self._cursorlist.append(cursor) # Added for later cleanup

            if (params):
                cursor.execute(query, params) # This is to avoid sql injection
            else:
                cursor.execute(query)

            self._dbconn.commit()

            return cursor.fetchall()
        except Exception as e:
            print(f"An error occured in 'runQuery()':\n\t{e}\n", file=sys.stderr)
            cursor.close()

    def cleanUp(self):
        """
            This function is for closing all connections (db and cursors).
        """
        for cursor in self._cursorList:
            cursor.close()

        self._dbconn.close()

    def healthCheck(self):
        """
            This function is for performing external health checks on the database connection.

            Returns: Either 'Healthy' or 'Not Healthy
        """
        return self._health
