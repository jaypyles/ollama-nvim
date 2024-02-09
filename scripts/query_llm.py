if __name__ == "__main__":
    llm = Ollama(model="llama2")
    llm.invoke("What is an AI?")
