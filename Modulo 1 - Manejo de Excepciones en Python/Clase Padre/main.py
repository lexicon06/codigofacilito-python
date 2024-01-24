
def __main__():
    try:

        n1:int = 2
        n2:int = 3
        resultado:int = sd/n2

    except Exception as e:

        print(f"Sorry code cannot continue")
        print(e)


    else:

        print(f"El resultado es {resultado}")


    finally:
        print(f"Fin del codigo")


__main__()