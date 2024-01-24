class CustomError1(Exception):
    def __init__(self):
        self.message = "First exception"
        super().__init__(self.message)



class CustomError2(Exception):
    def __init__(self):
        super().__init__("Second exception")




class CustomError3(Exception):
    def __init__(self):
        super().__init__("Third exception")
