class UserNameException(Exception):
    def __init__(self):
        self.message = "Cody no puede ser tu nombre"


def validate_username(name):
    if name.lower() == "cody":
        raise UserNameException()
    if len(name) < 3:
        raise Exception("Tiene que tener mas de 3 caracteres")
    
    return True


try:
    response:bool = validate_username("Cody")

except Exception as e:
    print("Custom errors")
    print(e.message)

