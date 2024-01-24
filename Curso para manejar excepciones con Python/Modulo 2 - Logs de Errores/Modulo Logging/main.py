# LOGGING
import logging

# INFO            = 10
# DEBUG           = 20
# WARNING         = 30
# ERROR           = 40
# CRITICAL        = 50


logging.basicConfig(
    level=10
)

"""
or example level = INFO
"""

logging.info("hola")
logging.debug("Este es un msj debug")
logging.warning("Error alerta")
logging.error("errrorrrrrrr")
logging.critical("critical error")