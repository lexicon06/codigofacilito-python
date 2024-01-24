from exceptions import *

try:
    raise ExceptionGroup(
    'Grupo de errores Propios',
    [CustomError1(), CustomError2(), CustomError3()])

except *CustomError1:
    print(f"Error1")

except *CustomError2:
    print(f"Error2")

except *CustomError3:
    print(f"Error3")    

"""
except ExceptionGroup as group:
    print(group)
"""

#or individual

