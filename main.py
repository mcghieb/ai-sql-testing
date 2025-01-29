# This is the file that is in charge of control flow
from dotenv import load_dotenv
from classes.db import Db
import os


def main():
    load_dotenv()

    db_conn_str = os.getenv("DB_CONN_STR")

    db = Db(db_conn_str)

    print("\nDB Connection Healthcheck status:\n\t" + db.healthCheck() + "\n")

    db.cleanUp()
    return 0 # dummy return (not enough code to start running scripts.)

if __name__ == "__main__":
    main()