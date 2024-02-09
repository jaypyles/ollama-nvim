import sys

from langchain_community.llms import Ollama

if __name__ == "__main__":
    llm = Ollama(model="llama2")
    result = llm.invoke(sys.argv[1])
    print(rf"{result}")
