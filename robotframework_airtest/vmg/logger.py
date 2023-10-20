import logging
import sys


FORMAT = "%(name)s-%(levelname)s:%(message)s"

log_level = logging.DEBUG

fh = logging.FileHandler("vmg.log", "w")
fh.setLevel(log_level)

ch = logging.StreamHandler()
ch.setLevel(log_level)

logging.basicConfig(format=FORMAT, level=logging.DEBUG, handlers=[fh, ch])
logger = logging.getLogger("vmg")


# 捕获所有异常
sys.excepthook = lambda exc_type, exc_value, exc_traceback: logger.error(
    "未捕获异常", exc_info=(exc_type, exc_value, exc_traceback)
)
