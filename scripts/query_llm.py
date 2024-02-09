import sys

from langchain_community.llms import Ollama
from rich.console import Console

if __name__ == "__main__":
    console = Console()
    llm = Ollama(model="llama2")
    with console.status("[bold green]Processing...", spinner="dots"):
        result = llm.invoke(sys.argv[1])
    print(rf"{result}")
