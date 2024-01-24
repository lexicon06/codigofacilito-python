def validate_username(name):
    if name.lower() == "cody":
        raise Exception("El nombre no puede ser Cody")
    if len(name) < 3:
        raise Exception("Tiene que tener mas de 3 caracteres")
    
    return True


try:
    response:bool = validate_username("Cody")

except Exception as e:
    print("Something went wrong")
    print(e)

