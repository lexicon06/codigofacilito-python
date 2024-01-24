import logging
import traceback
import contextlib

logging.basicConfig(
    level = logging.ERROR,
    filename = "errors.log",
    format = "%(asctime)s:%(levelname)s:%(message)s"
)

@contextlib.contextmanager
def write_on_log_error():

    try:
        yield
    
    except Exception as error:
        exception_info = {
        'message': str(error),
        'detail': traceback.format_exc()
        }
        logging.error(exception_info)


with write_on_log_error():
    result = a + b
    print(result)


with write_on_log_error():
    file = open("file.txt")