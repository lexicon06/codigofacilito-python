
def __main__():
    try:

        n1:int = 2
        n2:int = 3
        resultado:int = f/n2

    except ZeroDivisionError as e:

        print(f"no fue posible completar el codigo error fue {e}")

    except NameError as e:
        print(f"Lo sentimos la variable no es correcta {e}")

    else:

        print(f"El resultado es {resultado}")


    finally:
        print(f"Fin del codigo")


__main__()