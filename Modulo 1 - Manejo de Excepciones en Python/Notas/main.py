class UserNameException(Exception):
    
    def __init__(self) -> None:
        super().__init__("User is not valid")

    def is_valid_to_rise(self):
        return len(self.__notes__) > 0


def UserNameValidation(name):

    username_error = UserNameException()
    if len(name) <= 5:
        username_error.add_note("Length must be more than 5")

    if name.title() == "Cody":
        username_error.add_note("User can't be cody")

    if "@" in name:
        username_error.add_note("Username can't contain @")


    if username_error.is_valid_to_rise():
        raise username_error



username = "cody"
UserNameValidation(username)