"This document serves to determinethe cubesats orbital position using TLE data."

import math
from datetime import datetime, timedelta
from sgp4.api import Satrec, WGS72
from sgp4.api import jday
from pytz import utc
import numpy as np
from scipy.optimize import minimize

