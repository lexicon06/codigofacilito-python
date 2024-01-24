import logging
import traceback


logging.basicConfig(
    level = logging.ERROR,
    filename='errors.log',
    format="%(asctime)s:%(levelname)s:%(message)s"
)



try:
    1/0
except Exception as err:
    exception_info = {
        'mensaje': str(err),
        'detail': traceback.format_exc()
    }
    logging.error(exception_info)