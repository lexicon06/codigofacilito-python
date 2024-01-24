from contextlib import suppress

#we can use any type  of exception but we use exception default
with suppress(Exception):

    result = 1 / 0

print("ha finalizado el code")

