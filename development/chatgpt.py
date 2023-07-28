#!/bin/python3

import openai
import os


openai.api_key_path = "/home/solardebris/openaikey"

print("Enter prompt: ", end="")
prompt = input()

response = openai.Completion.create(
    engine = "text-davinci-002",
    prompt = prompt,
    max_tokens = 4000
)

code = response["choices"][0]["text"]

print(f"Output: {code}")
