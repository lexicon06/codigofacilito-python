class UserNameException(Exception):
    def __init__(self):
        self.message = "Cody no puede ser tu nombre"
        super().__init__(self.message)

class UserNameLenException(Exception):
    def __init__(self, name):
        self.message = f"User {name} needs to have at least 3 characters"
        super().__init__(self.message)



def validate_username(name):
    if name.lower() == "cody":
        raise UserNameException()
    if len(name) < 3:
        raise UserNameLenException(name)
    
    return True


try:
    response:bool = validate_username("Cod")

except Exception as e:
    print("Custom errors")
    print(e)

else:
    print("User is valid")

