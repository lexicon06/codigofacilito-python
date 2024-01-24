
def __main__():
    try:

        n1:int = 2
        n2:int = 2
        resultado:int = n1/n2

    except ZeroDivisionError as e:

        print(f"no fue posible completar el codigo error fue {e}")

    else:

        print(f"El resultado es {resultado}")


    finally:
        print(f"Fin del codigo")


__main__()