
def __main__():
    try:
        n1:int = 2
        n2:int = 0
        resultado:int = n1/n2
        print(f"el resultado es {resultado}")
        print(resultado)
    except ZeroDivisionError as e:
        print(f"no fue posible completar el codigo error fue {e}")


__main__()