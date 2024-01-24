def deco_validator(func):
    def wrapper(a:int,b:int):
        if a % 2 != 0 and b % 2 != 0:
            return func(a, b)
        else:
            raise TypeError("Number is even")

    return wrapper

@deco_validator
def add(a:int, b:int):
    return a+b
   

try:
    result = add(1,2)
except Exception as error:
    print(f"Error {error} has been found")
else:
    print(f"Result is {result}")
finally:
    print(f"Code has ended")
