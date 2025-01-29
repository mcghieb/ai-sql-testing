# This is the file that is in charge of control flow
from dotenv import load_dotenv
from classes.db import Db
from classes.llm import Llm
import os
from time import time
import json

fdir = os.path.dirname(__file__)
questions = [
    "How many people attended more than 3 races within a year?",
    "Which event had the most people from the same area code?",
    "How many people registered for events using this tool?",
    "What area code is the person who coordinated the most events in 2024 from?",
    "How many people outside of TX use this tool?",
    "How many races were held outside of the WA?",
    "Which person hosting races had the most number of people attending?",
    "Find the emails of every person attending an event that has a camping location so that we can send them a notification.",
    "What is the name of the person who is currently working on the most events (that are not currently listed on the site)."
]
sqlOnlyPrefix = "Give me a postgres sql select statement that answers the following question. Do not explain any errors. Make your response very simple, the preferred response is only a sql statement."


def main():
    load_dotenv()
    db_conn_str = os.getenv("DB_CONN_STR")
    db = Db(db_conn_str)
    print("\nDB Connection Healthcheck status:\n\t" + db.healthCheck() + "\n")
    schema_info = getAllSchemaInfo()
    llm = Llm()

    # single shot
    results = []
    error = "None"
    for question in questions:
        try:
            sqlGptResponse = llm.query(schema_info + " " + schema_info + " " + question)
            sanitizedSql = sanitizeForJustSql(sqlGptResponse)
            
            rawSqlResponse = str(db.runQuery(sanitizedSql))

            gptExplanationPrompt = f"Given this question: {question}\nAnd this response: {rawSqlResponse}\nPlease give me a more friendly explanation of the data. Please do not chatter or give any other information."
            gptExplanationResponse = llm.query(gptExplanationPrompt)
            
            print(sanitizedSql)
            print(rawSqlResponse)
            print(gptExplanationResponse)
        except Exception as e:
            error = str(e)

        results.append({
            "question": question,
            "sql": sanitizedSql,
            "queryRawResponse": rawSqlResponse,
            "friendlyResponse": gptExplanationResponse,
            "error": error
        })
    
    with open(getPath(f"response_{time()}.json"), "w") as outFile:
        json.dump(results, outFile, indent = 2)

    db.cleanUp()


def getAllSchemaInfo():
    script_list = ['./scripts/' + name for name in 
                                ['init_tables.sql',
                                 'init_relationships.sql']]
    
    result = "This is the database schema you will use:\n"
    for script_name in script_list:
        with open(script_name) as f:
            result += f.read()
    
    return result


def sanitizeForJustSql(value):
        gptStartSqlMarker = "```sql"
        gptEndSqlMarker = "```"
        if gptStartSqlMarker in value:
            value = value.split(gptStartSqlMarker)[1]
        if gptEndSqlMarker in value:
            value = value.split(gptEndSqlMarker)[0]

        return value


def getPath(fname):
    return os.path.join(fdir, fname)



if __name__ == "__main__":
    main()