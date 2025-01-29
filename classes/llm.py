# This is the file that pertains to everything to do with calling the llm
    # setting up connection
    # sending query
    # recording response
from dotenv import load_dotenv
import os
from openai import OpenAI

class Llm:
    """
        This is the LLM control class.
    """

    def __init__(self):
        load_dotenv()
        self._openai_client = OpenAI()

    def query(self, query: str):
        stream = self._openai_client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[{"role": "user", "content": query}],
            stream=True,
        )

        response = []
        for chunk in stream:
            if chunk.choices[0].delta.content is not None:
                response.append(chunk.choices[0].delta.content)

        return "".join(response)

