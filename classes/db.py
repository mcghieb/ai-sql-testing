import psycopg2
import sys

class Db:
    """
        This is the database control class.
    """
    
    def __init__(self, connstr):
        self._cursorList = []

        try:
            self._dbconn = psycopg2.connect(connstr)
            self._health = "Healthy"
        except Exception as e:
            print(f"Database connection not made.\n\t{e}\n", file=sys.stderr)
            self._health = "Not Healthy"
            return

        self._sqlSetup()

    def runQuery(self, query: str, params=None):
        """
            This function is used to run queries on the database.

            - Args: Query (string with %s as the user inputs), params (tuple(str) of params to insert)
            - Returns: All rows where the cursor executed 
        """
        try:
            if self._health != "Healthy":
                raise Exception("Db connection is not healthy.")
            
            cursor = self._dbconn.cursor()
            self._cursorList.append(cursor) # Added for later cleanup

            if (params):
                cursor.execute(query, params) # This is to avoid sql injection
                return cursor.fetchall()
            else:
                cursor.execute(query)
                return cursor.fetchall()

        except Exception as e:
            print(f"An error occured in 'runQuery()':\n\t{e}\n", file=sys.stderr)
            cursor.execute("ROLLBACK")
            cursor.close()

    def cleanUp(self):
        """
            This function is for closing all connections (db and cursors).
        """

        if self._cursorList:
            for cursor in self._cursorList:
                cursor.close()

        self._dbconn.close()

    def healthCheck(self):
        """
            This function is for performing external health checks on the database connection.

            Returns: Either 'Healthy' or 'Not Healthy
        """
        return self._health

    def _sqlSetup(self):
        try:
            if self._health != "Healthy":
                raise Exception("Db connection is not healthy.")

            cursor = self._dbconn.cursor()

            script_list = ['./scripts/' + name for name in 
                                ['delete_db.sql', 'init_types.sql', 'init_tables.sql',
                                 'init_relationships.sql', 'init_data.sql']]

            for script_name in script_list:
                with open(script_name) as f:
                    script = f.read()

                cursor.execute(script)
                self._dbconn.commit()

        except Exception as e:
            print(f"SQL Setup went wrong:\n\t{e}\n", file=sys.stderr)
            cursor.close()
