import logging

logging.basicConfig(
    level=logging.ERROR,
    filename='errors.log'
)

try:
    10 / 0
except Exception as error:
    logging.error("Sorry this is not possible to do")